Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277419AbRJVBxD>; Sun, 21 Oct 2001 21:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277440AbRJVBwx>; Sun, 21 Oct 2001 21:52:53 -0400
Received: from zok.sgi.com ([204.94.215.101]:61607 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S277419AbRJVBwe>;
	Sun, 21 Oct 2001 21:52:34 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Todd <todd@unm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 50MB kernel on ia64?? 
In-Reply-To: Your message of "Sun, 21 Oct 2001 19:00:38 CST."
             <Pine.A41.4.33.0110211857340.119340-200000@aix10.unm.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Oct 2001 11:52:54 +1000
Message-ID: <19244.1003715574@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Oct 2001 19:00:38 -0600 (MDT), 
Todd <todd@unm.edu> wrote:
>i've recently been trying to compile kernels on ia64 platform.  i've
>resolved some compiler problems (thanks to help here and from redhat) but
>now i've got another problem:  kernels built with the attached .config (or
>anything even vaguely similar--this one is for 2.4.7) are around 50MB in
>size!  morevover, there's no vmlinux or bzImage target in the makefile
>once ia64 is selected as the architecture.  i've been having problems
>getting the compiled kernels to boot, but i'm not sure if size is part of
>the reason.

The IA64 patch adds -g to CFLAGS.  All the debugging information bloats
vmlinux.  For the bootable kernel, I run

  strip -g vmlinux -o /boot/efi/vmlinux

You can boot from the unstripped vmlinux, the IA64 loader ignores the
debug data.  But the oversized kernels are slower to load and they take
up a lot of space in /boot/efi.  Don't understand your compile problem,
  make -j4 modules vmlinux
works for me in native IA64 mode (not cross compiling).

