Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRANAVy>; Sat, 13 Jan 2001 19:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129610AbRANAVp>; Sat, 13 Jan 2001 19:21:45 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:45321 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129485AbRANAV2>;
	Sat, 13 Jan 2001 19:21:28 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: Your message of "Sat, 13 Jan 2001 15:09:40 -0000."
             <Pine.LNX.4.30.0101131413190.21182-100000@imladris.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Jan 2001 11:21:20 +1100
Message-ID: <11983.979431680@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jan 2001 15:09:40 +0000 (GMT), 
David Woodhouse <dwmw2@infradead.org> wrote:
>Lack of [module symbol] runtime typechecking isn't a showstopper.

It is when users try to insert modules from kernel A into kernel B when
the ABI changed between A and B.  This is not type checking to catch
kernel programmers, it is ABI checking to catch user errors.

This is becoming more important as the kernel moves towards hot
plugging devices, especially for binary only drivers.  It is far better
for the kernel community if modutils can say "cannot load module foo
because its interfaces do not match the kernel, upgrade module foo".
That forces the maintenance load back onto the binary supplier and
removes the questions from l-k, including many of the oops reports with
binary only drivers in the module list.

Module symbol versions are the only way to catch ABI changes.  I do not
want to add a mechanism for accessing symbols dynamically if it cannot
detect ABI changes, it leaves the kernel open to difficult to diagnose
user errors.  I'm doing the hard work now to save everybody time later.

Ignore the fact that the existing module symbol version implementation
is broken as designed.  http://gear.torque.net/kbuild/archive/1280.html
lists the major problems with make dep, genksyms has all those problems
plus several of its own.  As part of the Makefile rewrite for 2.5, I am
redesigning module symbol versions from scratch.

I agree that inter_module_xxx does not check ABI.  That was not for
lack of trying, but it cannot be done in 2.4, it needs a major redesign
of module symbols and the makefiles.  It will be possible in 2.5.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
