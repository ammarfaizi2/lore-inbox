Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbULBWzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbULBWzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 17:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbULBWzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 17:55:20 -0500
Received: from gw.goop.org ([64.81.55.164]:41919 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S261358AbULBWzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 17:55:15 -0500
Subject: 32-bit syscalls from 64-bit process on x86-64?
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 08:22:00 -0800
Message-Id: <1102004520.8707.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-0.mozer.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Is it possible for a 64-bit process to invoke the 32-bit syscall
compatibility layer?  I'm thinking this might be useful for Valgrind,
since if it is running on an x86-64 host, it can take advantage of
having more registers and a larger address space to do a better
emulation of plain ia32.  But this is only practical if I can reuse the
kernel's 32-bit emulation layer, since duplicating it in Valgrind would
be silly (particularly ioctls).

>From a quick look at the code, it seems to me that int 0x80 might still
work in 64-bit mode, but connect to 32-bit syscalls.  Is that right?  If
not, could it be made to be right?  Alternatively, something like adding
a constant offset to the syscall numbers would work for me (ie, 0-N are
64-bit syscalls, 0x10000-N are 32-bit).  Hm, no, it looks like int 0x80
just calls normal 64-bit syscalls...

And does the 32-bit layer keep any private state?  For example, if I
modify the signal state with 32-syscalls in one place, and 64-bit
syscalls elsewhere, will that cause a problem or inconsistencies?

Thanks,
	J

