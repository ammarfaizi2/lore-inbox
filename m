Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbUJaPlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbUJaPlI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 10:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbUJaPlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 10:41:08 -0500
Received: from aun.it.uu.se ([130.238.12.36]:60831 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261153AbUJaPlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 10:41:04 -0500
Date: Sun, 31 Oct 2004 16:41:00 +0100 (MET)
Message-Id: <200410311541.i9VFf0ah023857@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, pluto@pld-linux.org
Subject: Re: unit-at-a-time...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2004 15:57:00 +0100, pluto@pld-linux.org wrote:
>/i386/Makefile:# Disable unit-at-a-time mode, it makes gcc use a lot morestack
>/i386/Makefile:CFLAGS += $(call cc-option,-fno-unit-at-a-time)
>
>/x86_64/Makefile:# -funit-at-a-time shrinks the kernel .text considerably
>/x86_64/Makefile:CFLAGS += $(call cc-option,-funit-at-a-time)
>
>Which solution is correct?

Disabling unit-at-a-time for i386 is definitely correct.
I've personally observed horrible runtime corruption bugs
in early 2.6 kernels when they were compiled with gcc-3.4
without the -fno-unit-at-a-time fix.

x86-64 is a different architecture. It's possible its larger
number of registers reduces spills enough that gcc's failure
to merge stack slots doesn't matter.

/Mikael
