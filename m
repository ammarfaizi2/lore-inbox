Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVJBGeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVJBGeS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 02:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVJBGeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 02:34:18 -0400
Received: from ms-smtp-03-qfe0.socal.rr.com ([66.75.162.135]:58039 "EHLO
	ms-smtp-03-eri0.socal.rr.com") by vger.kernel.org with ESMTP
	id S1750989AbVJBGeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 02:34:18 -0400
Date: Sat, 1 Oct 2005 23:32:44 -0700 (PDT)
From: Kernel Enthusiast <kernel@clones.net>
To: linux-kernel@vger.kernel.org
Subject: LVM Compilation error on 2.6.13.2
Message-ID: <Pine.NEB.4.61.0510012327430.451@resurrection.clones.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a problem building LVM on a new 2.6.13.2 kernel I built 
yesterday.   I built the kernel on an older Mandrake 8 system after 
updating to the latest gnu binutils.  It's very fast... much faster than 
my previous 2.4 kernel.  I have no complaints about performance.
I was able to build the kernel with the stock gcc-2.96. Disk access is 
much quieter than with previous kernels.

I'm not sure if this problem was due to a kernel customization error, but
I got the error "BLKBSZGET undefined (first use this function)" in
LVM2.2.0.14/lib/device/dev-io.c.  I added the following definition to the 
LVM code in order to enable LVM to compile:

#define BLKBSZGET _IO(0x12,104)

after the #INCLUDE statements in dev-io.c and then LVM 2.2.0.14 compiled 
without errors.

My question is this:   Was the above problem due to a non-standard kernel 
config file, i.e. a kernel lacking support for BLKBSZGET? Or is gcc-2.96 
too old, or a bad version?  This fix feels like a kludge and before I
configure LVM, I would like to make sure I didn't cause a problem for myself
by adding the above definition to the LVM source code.
I don't want to hard-code a definition in the LVM sources if the same
parameter is supposed to be defined in my environment elsewhere.

>From a theoretical standpoint, I am hoping it will not matter, but if anyone
on the list is familiar with BLKBSZGET and knows whether it is supposed to be
a kernel function, I would be delighted to hear your thoughts on the matter.
I'm not sure what effect hard-coding the definition of Block Size will have,
but if there is a standard way to define it, I would like to know about 
it.

Regards,

Glendon Gross


