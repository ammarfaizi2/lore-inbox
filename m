Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUIVUFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUIVUFL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266838AbUIVUFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:05:11 -0400
Received: from smtp-relay.dca.net ([216.158.48.66]:29330 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S266870AbUIVUEv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:04:51 -0400
Date: Wed, 22 Sep 2004 16:04:46 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com, Michael Hunold <hunold-ml@web.de>,
       Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Message-ID: <20040922200446.GC4256@jupiter.solarsys.private>
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com> <41506099.8000307@web.de> <41506D78.6030106@web.de> <1095843365.18365.48.camel@localhost> <1095854048.18365.75.camel@localhost> <20040922122848.M14129@linux-fr.org> <1095877951.18365.232.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095877951.18365.232.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian:

* Adrian Cox <adrian@humboldt.co.uk> [2004-09-22 19:32:31 +0100]:
> On Wed, 2004-09-22 at 14:38, Jean Delvare wrote:
> 
> > Aha, this is an interesting point (which was missing from your previous
> > explanation). The base of your proposal would be to have several small i2c
> > "trees" (where a tree is a list of adapters and a list of clients) instead of
> > a larger, unique one. This would indeed solve a number of problems, and I
> > admit that it is somehow equivalent to Michael's classes in that it
> > efficiently prevents the hardware monitoring clients from probing the video
> > stuff. The rest is just details internal to each "tree". As I understand it,
> > each video device would be a tree on itself, while the whole hardware
> > monitoring stuff would constitute one (bigger) tree. Correct?
> 
> I've been rereading the code, and it could be even simpler. How about
> this:
> 
> 1) The card driver defines an i2c_adapter structure, but never calls
> i2c_add_adapter(). The only extra thing it needs to do is to initialise
> the semaphores in the structure.
> 2) The frontend calls i2c_transfer() directly.
> 3) The i2c core never gets involved, and there is never any i2c_client
> structure.

Yes, almost...

Why force your card driver to re-implement i2c_smbus_read_byte() and all
its relatives?  Go ahead and define the i2c_client structure(s) as well,
but don't i2c_attach_client().  Sensors drivers do their probing before
attaching the client, so I know that works.

> This gives us the required reuse of the I2C algo-bit code, without any
> of the list walking or device probing being required.

Ditto, *plus* you can still reuse all the i2c_core helper routines that
require a client structure.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

