Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132372AbREBIub>; Wed, 2 May 2001 04:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132413AbREBIuV>; Wed, 2 May 2001 04:50:21 -0400
Received: from post2.inre.asu.edu ([129.219.110.73]:5006 "EHLO
	post2.inre.asu.edu") by vger.kernel.org with ESMTP
	id <S132372AbREBIuR>; Wed, 2 May 2001 04:50:17 -0400
Date: Wed, 02 May 2001 01:50:16 -0700
From: Russ Dill <Russ.Dill@asu.edu>
Subject: Re: Breakage of opl3sax cards since 2.4.3 (at least)
In-Reply-To: <Pine.LNX.4.10.10105020918260.18909-100000@www.teaparty.net>
To: Vivek Dasmohapatra <vivek@etla.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200105020850.BAA03703@smtp.asu.edu>
MIME-version: 1.0
X-Mailer: Evolution (0.9 - Preview Release)
Content-type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 May 2001 09:30:03 +0100, Vivek Dasmohapatra wrote:

> I have an isapnp opl3sax system [2.4.3-ac5] - the sound card
initialises

> fine, I just have to kick the second logical device with by cat'ing the
> following into /proc/isapnp:
> 
> card 0 YMH0802
> dev 0 YMH0022
> port 0 0x201
> activate
> 
> Which then activates the gameport: What are the contents of your
> /proc/isapnp? 


this sounds similar to my manual running of isapnp

> Of course, you have a YMH0020, and I have a YMH0021, that could be making
> all the difference.



not quite, you seem to have a YMH0802, while I have a YMH0802, what
error were you originally getting?
with mine, it doesn't want to isapnp it, so after I do that on my own, I
get:
russ kernel: opl3sa2: Control I/O port 0x240 is not a YMF7xx chipset!

anyway, I changed the above to:

card 0 YMH0020
dev 0 YMH0022
port 0 0x201
activate

does nothing...the diff between the two /proc/isapnp's are (the second
part of the first chunk and the last chunk are a result of me running
isapnp):

-Card 1 'YMH0020:OPL3-SAX Sound Board' PnP version 1.0
+Card 1 'YMH0802:YAMAHA OPL3-SAx Audio System' PnP version 1.0 
   Logical device 0 'YMH0021:Unknown'
     Device is active
     Active port 0x240,0xe80,0x388,0x300,0x100
-    Active IRQ 10 [0x2]
-    Active DMA 0,3
+    Active IRQ 5 [0x2] 
+    Active DMA 1,3 
     Resources 0
       Priority preferred
       Port 0x220-0x220, align 0xf, size 0x10, 16-bit address decoding
@@ -18,7 +18,7 @@
         Priority acceptable
         Port 0x240-0x240, align 0xf, size 0x10, 16-bit address decoding
         Port 0xe80-0xe80, align 0x7, size 0x8, 16-bit address decoding
-        Port 0x388-0x388, align 0x7, size 0x4, 16-bit address decoding
+        Port 0x388-0x388, align 0x3, size 0x4, 16-bit address decoding 
         Port 0x300-0x300, align 0x1, size 0x2, 16-bit address decoding
         Port 0x100-0xffe, align 0x1, size 0x2, 16-bit address decoding
         IRQ 5,7,2/9,10,11 High-Edge
@@ -49,5 +49,5 @@
         Priority acceptable
         Port 0x203-0x203, align 0x0, size 0x1, 16-bit address decoding
       Alternate resources 0:3
-        Priority functional
+        Priority acceptable 
         Port 0x204-0x20f, align 0x0, size 0x1, 16-bit address decoding



