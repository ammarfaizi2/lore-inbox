Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268583AbUHMAhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268583AbUHMAhz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 20:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268590AbUHMAhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 20:37:55 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:25986 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S268583AbUHMAhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 20:37:50 -0400
From: Benno <benjl@cse.unsw.edu.au>
To: Dan Aloni <da-x@colinux.org>
Date: Fri, 13 Aug 2004 10:37:43 +1000
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Generation of *.s files from *.S files in kbuild
Message-ID: <20040813003743.GF30576@cse.unsw.edu.au>
References: <20040812192535.GA20953@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812192535.GA20953@callisto.yi.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Aug 12, 2004 at 22:25:35 +0300, Dan Aloni wrote:
>Hello, 
>
>Is the generation of *.s files from *.S files in the kernel
>build system a wide spread phenomenon? As far as I can see
>only vmlinux.lds.s is built that way in my default i386 config.
>
>It causes problems when trying to cross-build a kernel on a 
>file system that has case-insensitive filenames, or on a GNU
>port that is case insensitive (such as Cygwin).
>
>If anyone wondered, I'm trying to cross build a Linux kernel
>on a Cygwin system using a Linux native toolchain, in order
>to make development of the Windows port of coLinux easier
>for some people.

Hi Dan, 

I'm having the exact same problem on Mac OSX with the case-insensitive
HFS+ filesystem.

After looking the only files that use this rule are the vmlinux.lds
files. (Although there is one of them for each architecture.)

It is actually a bit frustrating because due to the way make works
this is a problem even if you use a separate build directory.

The solution is fairly striaght forward -- just change the suffixes,
the problem is exactly how to change them. I would propose changing it
such that was stick with "vmlinux.lds.S" and have it generate "vmlinux.lds"

This would require the fewest changes to implement, just
1/ change %.s %.S rule to %.lds %.lds.S
2/ change the link flags from "-T vmlinux.lds.s" -> "-T vmlinux.lds"

Cheers,

Benno

