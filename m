Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264700AbTFEOct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 10:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbTFEOcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 10:32:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264700AbTFEOcp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 10:32:45 -0400
Date: Thu, 5 Jun 2003 10:46:18 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Shared Library starter, ld.so
Message-ID: <Pine.LNX.4.53.0306051045180.6171@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I know this is not a Kernel problem but... it is an
embedded system problem using Linux with a very
minimal (homemade) 'C' runtime library.

The dynamic linker, provided with RedHat 9 no longer
compiles with the de facto standard of having register
EDX point to function to be called before exit.

This is (was) the relevent rule:

#
#	This is the entry point, usually the first thing in the text
#	segment. The SVR4/i386 ABI (pages 3-31, 3-32) says that upon
#	entry most registers' values are unspecified, except for:
#
#   %edx	Contains a function pointer to be registered with `atexit'.
#   		This is how the dynamic linker arranges to have DT_FINI
#		functions called for shared libraries that have been loaded
#		before this code runs.
#
#   %esp	The stack contains the arguments and environment:
#   		0(%esp)			argc
#		4(%esp)			argv[0]
#		...
#		(4*argc)(%esp)		NULL
#		(4*(argc+1))(%esp)	envp[0]
#		...
#					NULL

Now the register contains junk, so if it was used as a function-
pointer, the code will seg-fault.

How does code 'know' not to call this function? If this is
no longer used, then EDX must be set to zero to let the start-up
code know not to call it.

I tried to find the source-code for ld.so (ld-linux.so.2) used with
this version and was not able to find it anywhere.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

