Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUIVMiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUIVMiD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 08:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUIVMiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 08:38:03 -0400
Received: from nat.ecole.ensicaen.fr ([193.49.200.25]:41354 "EHLO
	e450.ensicaen.ismra.fr") by vger.kernel.org with ESMTP
	id S264917AbUIVMh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 08:37:59 -0400
From: "Jean Delvare" <khali@linux-fr.org>
To: Adrian Cox <adrian@humboldt.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com
Cc: Michael Hunold <hunold-ml@web.de>, Jon Smirl <jonsmirl@gmail.com>,
       Greg KH <greg@kroah.com>
Reply-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Date: Wed, 22 Sep 2004 14:38:46 +0100
Message-Id: <20040922122848.M14129@linux-fr.org>
In-Reply-To: <1095854048.18365.75.camel@localhost>
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com>	 <41506099.8000307@web.de> <41506D78.6030106@web.de> <1095843365.18365.48.camel@localhost> <20040922102938.M15856@linux-fr.org> <1095854048.18365.75.camel@localhost>
X-Mailer: Open WebMail 2.10 20030617
X-OriginatingIP: 62.23.212.160 (delvare)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004 12:54:08 +0100, Adrian Cox wrote
> On Wed, 2004-09-22 at 13:08, Jean Delvare wrote:
> > Well, I don't quite follow you here. On the one hand you agree that
> > sensors and video/embedded stuff should be handled differently, but
> > then you don't want us to tag them according to their function in order
> > to actually behave differently.
> 
> I don't want them tagged because I don't want them to ever appear on 
> a system-wide list. They're an internal detail of a particular card, 
> and don't even need to be in sysfs. The only reason to have any 
> shared I2C code at all for these cards is to avoid duplicating the
> implementation of bit-banging.
> (...)
> What I want is a way for a card driver to create a private I2C 
> adapter, and private instances of I2C clients, for purposes of code 
> reuse. The card driver would be responsible for attaching those 
> clients to the bus and cleaning up the objects on removal. The bus 
> wouldn't be visible in sysfs, or accessible from user-mode.

Aha, this is an interesting point (which was missing from your previous
explanation). The base of your proposal would be to have several small i2c
"trees" (where a tree is a list of adapters and a list of clients) instead of
a larger, unique one. This would indeed solve a number of problems, and I
admit that it is somehow equivalent to Michael's classes in that it
efficiently prevents the hardware monitoring clients from probing the video
stuff. The rest is just details internal to each "tree". As I understand it,
each video device would be a tree on itself, while the whole hardware
monitoring stuff would constitute one (bigger) tree. Correct?

> Some USB webcams have internal I2C busses to connect the sensor to 
> the USB chip. The drivers for these ignore the I2C core completely, and
> invent their own system for reading and writing the sensor registers.
> Maybe that's actually the best way of dealing with this.

With your proposal, these drivers could use the common code again while still
being completely separated from the other i2c busses, right?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

