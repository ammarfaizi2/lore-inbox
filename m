Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264037AbSJRJTH>; Fri, 18 Oct 2002 05:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264615AbSJRJTG>; Fri, 18 Oct 2002 05:19:06 -0400
Received: from ns.suse.de ([213.95.15.193]:50949 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264037AbSJRJTG>;
	Fri, 18 Oct 2002 05:19:06 -0400
To: Crispin Cowan <crispin@wirex.com>
Cc: hch@infradead.org, greg@kroah.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       davem@redhat.com
Subject: Re: [PATCH] remove sys_security
References: <20021017201030.GA384@kroah.com.suse.lists.linux.kernel> <20021017211223.A8095@infradead.org.suse.lists.linux.kernel> <3DAFB260.5000206@wirex.com.suse.lists.linux.kernel> <20021018.000738.05626464.davem@redhat.com.suse.lists.linux.kernel> <3DAFC6E7.9000302@wirex.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 18 Oct 2002 11:25:02 +0200
In-Reply-To: Crispin Cowan's message of "18 Oct 2002 10:37:01 +0200"
Message-ID: <p73wuognlox.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Crispin Cowan <crispin@wirex.com> writes:

> Could you elaborate on why this is a sign of trouble, design wise?

David refers to the 32bit emulation issues. Some ports have a 64bit
kernel, but support 64bit and 32bit userland (e.g. ia64 or x86-64). 
Some ports even only have 32bit userland but 64bit kernel (like sparc64 or 
mips64)

The 32bit and the 64bit worlds have different data types. Structure
layout are different. To handle this the kernel has an emulation
layer that converts the arguments of ioctls and system calls between 
32bit and 64bit.

This emulation layer sits at the 'edge' of the kernel. For example
to convert an ioctl it first figures out the ioctl, converts it
then reissues the same ioctl internally with 64bit arguments. When
the ioctl returns outgoing arguments are converted too as needed.

For this to work all data structures need to be transparent.
The emulation layer needs to have a way to figure out what and
how to convert without looking at internal state in the kernel.
Otherwise it cannot do its job. 

Without working emulation sparc64 won't work and David will be unhappy.

-Andi
