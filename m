Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUIVScf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUIVScf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 14:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266616AbUIVScf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 14:32:35 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:51636 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S266611AbUIVScd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 14:32:33 -0400
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
From: Adrian Cox <adrian@humboldt.co.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com
Cc: Michael Hunold <hunold-ml@web.de>, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20040922122848.M14129@linux-fr.org>
References: <414F111C.9030809@linuxtv.org>
	 <20040921154111.GA13028@kroah.com>	 <41506099.8000307@web.de>
	 <41506D78.6030106@web.de> <1095843365.18365.48.camel@localhost>
	 <20040922102938.M15856@linux-fr.org> <1095854048.18365.75.camel@localhost>
	 <20040922122848.M14129@linux-fr.org>
Content-Type: text/plain
Message-Id: <1095877951.18365.232.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 19:32:31 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 14:38, Jean Delvare wrote:

> Aha, this is an interesting point (which was missing from your previous
> explanation). The base of your proposal would be to have several small i2c
> "trees" (where a tree is a list of adapters and a list of clients) instead of
> a larger, unique one. This would indeed solve a number of problems, and I
> admit that it is somehow equivalent to Michael's classes in that it
> efficiently prevents the hardware monitoring clients from probing the video
> stuff. The rest is just details internal to each "tree". As I understand it,
> each video device would be a tree on itself, while the whole hardware
> monitoring stuff would constitute one (bigger) tree. Correct?

I've been rereading the code, and it could be even simpler. How about
this:

1) The card driver defines an i2c_adapter structure, but never calls
i2c_add_adapter(). The only extra thing it needs to do is to initialise
the semaphores in the structure.
2) The frontend calls i2c_transfer() directly.
3) The i2c core never gets involved, and there is never any i2c_client
structure.

This gives us the required reuse of the I2C algo-bit code, without any
of the list walking or device probing being required.

- Adrian Cox
Humboldt Solutions Ltd.


