Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbTIRD44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 23:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbTIRD4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 23:56:55 -0400
Received: from neors.cat.cc.md.us ([204.153.79.3]:31436 "EHLO
	student.ccbc.cc.md.us") by vger.kernel.org with ESMTP
	id S262953AbTIRD4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 23:56:54 -0400
Date: Wed, 17 Sep 2003 23:52:46 -0400 (EDT)
From: John R Moser <jmoser5@student.ccbc.cc.md.us>
To: linux-kernel@vger.kernel.org
Subject: Kernel/user process communication
Message-ID: <Pine.A32.3.91.1030917233515.8136A-100000@student.ccbc.cc.md.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be a dumb question, but is it possible to pass data between the
kernel and a userspace process?  I know this is probably brain-damaged in
design, but just tell me if it's possible here. 

What I want to do is write a program that gets run at init time and connects
to the kernel via a syscall.  This process does *not* get touched with the
OOM killer, ever (EVER ever).

The idea is that the kernel when using this process will only ever swap 
out RAM belonging to it and its subprocesses, no other process.  Problems 
I'm already seeing are that each process has a what, 3 GB RAM limit?  
(1.5 if using GRSecurity with certain PAX settings IIRC).

When the kernel is connected to said process, instead of swapping to the 
pagefile, it will swap to the process.  This process will store the data 
in some way (compressed possibly).  This process' data may be swapped 
out.  Other data from the swap file that is already swapped out may still 
be swapped in (duh).

This would . . . be retarded.  Um.  I mean.  This would. . . allow a 
userspace process to be written as a RAM expander.  I'm not sure the 
advantage of doing this in userspace instead of kernel space, but I'd 
like to know if it's possible.  At least it would make the cruft of a 
compressor not appear in the kernel.  The alternative would be a kernel 
module to do it, which could be compiled against the kernel source and 
activate all the same changes when loaded (and also tell the kernel to 
forbid other RAM compressor modules until it is unloaded).

Just a thought.  And yes I've tried compressed page cache :)

--Bluefox

