Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUIVNNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUIVNNY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 09:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUIVNNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 09:13:24 -0400
Received: from mail.humboldt.co.uk ([81.2.65.18]:26544 "EHLO
	mail.humboldt.co.uk") by vger.kernel.org with ESMTP id S264668AbUIVNNW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 09:13:22 -0400
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
Message-Id: <1095858798.18365.99.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 14:13:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 14:38, Jean Delvare wrote:
> On Wed, 22 Sep 2004 12:54:08 +0100, Adrian Cox wrote

> > What I want is a way for a card driver to create a private I2C 
> > adapter, and private instances of I2C clients, for purposes of code 
> > reuse. The card driver would be responsible for attaching those 
> > clients to the bus and cleaning up the objects on removal. The bus 
> > wouldn't be visible in sysfs, or accessible from user-mode.
> 
> Aha, this is an interesting point (which was missing from your previous
> explanation). The base of your proposal would be to have several small i2c
> "trees" (where a tree is a list of adapters and a list of clients) instead of
> a larger, unique one. This would indeed solve a number of problems, and I
> admit that it is somehow equivalent to Michael's classes in that it
> efficiently prevents the hardware monitoring clients from probing the video
> stuff. The rest is just details internal to each "tree". As I understand it,
> each video device would be a tree on itself, while the whole hardware
> monitoring stuff would constitute one (bigger) tree. Correct?

Yes. It took me an extra cup of coffee to explain the idea. 

An important detail is that frontends would no longer contain
module_init() and module_exit() functions. Instead, the card driver
would call a function in the frontend module to attach the frontend
client to the tree and simultaneously set the correct parameters for
that specific card. This provides type safety, and a guarantee that the
client parameters match the correct card when mixing cards from
different manufacturers.

> > Some USB webcams have internal I2C busses to connect the sensor to 
> > the USB chip. The drivers for these ignore the I2C core completely, and
> > invent their own system for reading and writing the sensor registers.
> > Maybe that's actually the best way of dealing with this.
> 
> With your proposal, these drivers could use the common code again while still
> being completely separated from the other i2c busses, right?

Possibly, though they tend to have very limited I2C controllers which
makes it more awkward.

- Adrian Cox
Humboldt Solutions Ltd.


