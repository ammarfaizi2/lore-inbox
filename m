Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWG3Jvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWG3Jvk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWG3Jvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:51:40 -0400
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:15530 "EHLO
	smtpq2.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932171AbWG3Jvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:51:39 -0400
Message-ID: <44CC8213.6020201@keyaccess.nl>
Date: Sun, 30 Jul 2006 11:55:31 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Simon White <s_a_white@email.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Driver model ISA bus
References: <20060730081824.2763A478088@ws1-5.us4.outblaze.com>
In-Reply-To: <20060730081824.2763A478088@ws1-5.us4.outblaze.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon White wrote:

> Would it be better to have a name variable directly in isa_device and
> then copy that to driver in isa_register_device (like
> pci_register_device does)?

No, that wouldn't be useful. The point of this code is largely that the 
devices belong to the driver; do not have a life of their own. As such, 
naming them after the driver is the correct thibng to do.

> I was trying to look for use examples of this code in 2.6.18-rc2 but
> didn't see any.

Yes, apologies. I was converting ALSA ISA drivers to use it but had (and 
have) to deal with a few other matters first all of a sudden. I'll get 
to it shortly. There is a usage example I posted on the kernelnewbies 
list a while ago:

http://www.spinics.net/lists/newbies/msg21845.html

> Is the intent of name to be the cards address, and ndev to be the
> function on a specific card?

No, the name is just an identifier under which the driver (and devices) 
show up in sysfs and ndev the number of devices we want to the driver 
code to call our methods with -- given that ISA devices do not announce 
themselves we have to tell the driver core this.

By the way, please CC people on LKML. I'm still being busy and had to 
pick this out of the trash where it caught my eye by chance...

Rene.
