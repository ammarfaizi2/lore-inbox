Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUBPTH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 14:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUBPTH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 14:07:27 -0500
Received: from [218.5.74.208] ([218.5.74.208]:38621 "EHLO vhost.bizcn.com")
	by vger.kernel.org with ESMTP id S265775AbUBPTHP (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 14:07:15 -0500
Message-ID: <403114D9.2060402@lovecn.org>
Date: Tue, 17 Feb 2004 03:07:05 +0800
From: Coywolf Qi Hunt <coywolf@lovecn.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en, zh
MIME-Version: 1.0
To: Riley@Williams.Name, davej@suse.de, hpa@zytor.com
CC: Linux-Kernel@vger.kernel.org
Subject: [PATCH 2.4.24] Fix GDT limit in setup.S
Content-Type: multipart/mixed;
 boundary="------------050002040905090402050506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050002040905090402050506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello 2.4.xx hackers,

In setup.S, i feel like that the gdt limit 0x8000 is not proper and it 
should be 0x800.  How came 0x800 into 0x8000 in 2.4.xx code?  Is there a 
story?  It shouldn't be a careless typo. 256 gdt entries should be 
enough and since it's boot gdt, 256 is ok even if the code is run on SMP 
with 64 cpus. 

At least the comment doesn't match the code. Either fix the code or fix 
the comment.  We really needn't so many GDT entries. Let's use the intel 
segmentation in a most limited way. Below follows a patch fixing the code.

I don't have the latest 2.4.24, but setup.S isn't changed from 2.4.23 to 
2.4.24.

Regards, Coywolf

-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org


--------------050002040905090402050506
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- arch/i386/boot/setup.S.orig	2003-11-29 02:26:20.000000000 +0800
+++ arch/i386/boot/setup.S	2004-02-17 01:15:42.000000000 +0800
@@ -1093,7 +1093,7 @@
 	.word	0				# idt limit = 0
 	.word	0, 0				# idt base = 0L
 gdt_48:
-	.word	0x8000				# gdt limit=2048,
+	.word	0x800				# gdt limit=2048,
 						#  256 GDT entries
 
 	.word	0, 0				# gdt base (filled in later)


--------------050002040905090402050506--

