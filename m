Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUKEXDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUKEXDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUKEXDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:03:33 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:38815 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261244AbUKEXCc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:02:32 -0500
Date: Sat, 6 Nov 2004 00:02:22 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, Andries Brouwer <aebr@win.tue.nl>,
       Adam Heath <doogie@debian.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] change Kconfig entry for RAMFS (Was: Re: support of older
 compilers)
In-Reply-To: <Pine.LNX.4.58.0411051406200.2223@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.60.0411052319160.3255@alpha.polcom.net>
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <20041105195045.GA16766@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
 <Pine.LNX.4.60.0411052242090.3255@alpha.polcom.net>
 <Pine.LNX.4.58.0411051406200.2223@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004, Linus Torvalds wrote:
> On Fri, 5 Nov 2004, Grzegorz Kulewski wrote:
>>
>> And using ramfs for anything else can easily lead to similar problems. So
>> I think we do not need ramfs. Am I wrong? [I understand that removing it
>> will not remove much code.]
>
> ramfs is very useful as a minimal filesystem for showing what the VFS
> interfaces are, and also (I believe) used in embedded environments, where
> it's simply the smallest possible thing, and swap isn't available anyway.
>
> You can just disable it if you don't want it..

Probably, but it looks like it does not display in menuconfig and it is 
set by default. I understand that it is a good example, but it should be 
disabled by default I think... Or at least it should show in menuconfig. 
And I do not know why embedded environments want to use ramfs more 
than tmpfs. Swap is not needed for tmpfs and even if device has no swap it 
can be oomed because of ramfs too.


Will you accept this patch:

Signed-off-by: Grzegorz Kulewski <kangur@polcom.net>

--- linux/fs/Kconfig	 2004-11-05 23:14:27.297548136 +0100
+++ linux-gk/fs/Kconfig	 2004-11-05 23:23:09.365181792 +0100
@@ -929,8 +929,8 @@
         def_bool HUGETLBFS

  config RAMFS
-       bool
-       default y
+       bool "Ramfs file system support (PROBABLY USE TMPFS INSTEAD)"
+       default n
         ---help---
           Ramfs is a file system which keeps all files in RAM. It allows
           read and write access.
@@ -939,8 +939,8 @@
           you need a file system which lives in RAM with limit checking use
           tmpfs.

-         To compile this as a module, choose M here: the module will be called
-         ramfs.
+         WARNING: If you will place too many data on this filesystem,
+         the kernel will panic because of OOM! Use tmpfs instead if you can.

  source "fs/supermount/Kconfig"

-

I think that RAMFS can not be build as a module becuse it is marked bool. 
Am I wrong?

If you will apply this it will be my first kernel patch in mainline. Wow! 
:-)

Because of this reason please do not complain too loud if something is 
not ok with this patch. I am inexperienced in producing and sending 
patches for inclusion into Linux. If this patch is broken or you do not 
want to apply it in this form, I will be more than happy to fix it of 
course.


Thanks,

Grzegorz Kulewski

