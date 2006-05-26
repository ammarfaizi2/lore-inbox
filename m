Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWEZJxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWEZJxo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 05:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWEZJxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 05:53:44 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:63687 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751366AbWEZJxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 05:53:43 -0400
Message-ID: <4476D020.8070605@garzik.org>
Date: Fri, 26 May 2006 05:53:36 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       gregkh@suse.de
Subject: Recent x86-64 patch causes many devices to disappear
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch made A TON of devices disappear on my HP XW9300 
system.  I complained the day it was committed, but alas...

> commit 5491d0f3e206beb95eeb506510d62a1dab462df1
> Author: Andi Kleen <ak@suse.de>
> Date:   Mon May 15 18:19:41 2006 +0200
> 
>     [PATCH] i386/x86_64: Force pci=noacpi on HP XW9300
> 
>     This is needed to see all devices.


Finally, I was able to get to testing it, and provide proof that a 
shitload of devices do indeed disappear:

	http://gtf.org/garzik/dammit/

Files:
*.rc4		- rc4, plus some libata changes, PCI domains disabled
*.rc5		- rc5-git1, PCI domains disabled
*.rc5-pcidom	- rc5-git1, PCI domains enabled

As the patch doesn't work, and the description is proven patently false, 
maybe we can now consider reverting it and making a better patch?  My 
Marvell SATA and MPT Fusion devices are no longer available, as a diff 
between lspci.rc5 and lspci.rc5-pcidom demonstrates.

	Jeff


