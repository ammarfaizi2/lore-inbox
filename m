Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265972AbUBQESh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 23:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUBQESh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 23:18:37 -0500
Received: from [218.5.74.208] ([218.5.74.208]:64201 "EHLO vhost.bizcn.com")
	by vger.kernel.org with ESMTP id S265972AbUBQESe (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 23:18:34 -0500
Message-ID: <40318FB0.6060109@lovecn.org>
Date: Tue, 17 Feb 2004 11:51:12 +0800
From: Coywolf Qi Hunt <coywolf@lovecn.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: tao@acc.umu.se
CC: Riley@Williams.Name, davej@suse.de, hpa@zytor.com,
       alan@lxorguk.ukuu.org.uk, Linux-Kernel@vger.kernel.org,
       root@chaos.analogic.com
Subject: [2.0.40 2.2.25 2.4.25] Fix boot GDT limit 0x800 to 0x7ff in setup.S
 or not
References: <403114D9.2060402@lovecn.org>
In-Reply-To: <403114D9.2060402@lovecn.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:

> Hello 2.4.xx hackers,
>
> In setup.S, i feel like that the gdt limit 0x8000 is not proper and it 
> should be 0x800.  How came 0x800 into 0x8000 in 2.4.xx code?  Is there 
> a story?  It shouldn't be a careless typo. 256 gdt entries should be 
> enough and since it's boot gdt, 256 is ok even if the code is run on 
> SMP with 64 cpus.
> At least the comment doesn't match the code. Either fix the code or 
> fix the comment.  We really needn't so many GDT entries. Let's use the 
> intel segmentation in a most limited way. Below follows a patch fixing 
> the code.
>
> I don't have the latest 2.4.24, but setup.S isn't changed from 2.4.23 
> to 2.4.24.
>
> Regards, Coywolf
>
>------------------------------------------------------------------------
>
>--- arch/i386/boot/setup.S.orig	2003-11-29 02:26:20.000000000 +0800
>+++ arch/i386/boot/setup.S	2004-02-17 01:15:42.000000000 +0800
>@@ -1093,7 +1093,7 @@
> 	.word	0				# idt limit = 0
> 	.word	0, 0				# idt base = 0L
> gdt_48:
>-	.word	0x8000				# gdt limit=2048,
>+	.word	0x800				# gdt limit=2048,
> 						#  256 GDT entries
> 
> 	.word	0, 0				# gdt base (filled in later)
>
>  
>

Hello all hackers, from 2.0 to 2.4,

In setup.S,  from the very beginning (in boot/boot.s for 0.01 kernel),
all boot GDT limits are set to 0x800. GDT limit is the LIMIT, not SIZE.
So all these 0x800 should be 0x7ff. And actually in the current 2.4.24,
it is even an odd 0x8000 which I previously just sent a patch to fix to
0x800. But it should be set to 0x7ff really.  Until now only 2.6 sets it
properly. Although these will never cause any runtime problem at all,
they are ugly. Please consider fix them.

Since it is always 0x800, i even get used to 0x800 rather then the
proper 0x7ff. If leave it 0x800, it's useful to distinguish the boot GDT
from the later final GDT setting in arch/i386/kernel/head.S. So fix it
or not.


Regards,
Coywolf

-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

