Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbUB2RCm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 12:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbUB2RCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 12:02:42 -0500
Received: from univ.uniyar.ac.ru ([193.233.51.120]:29661 "EHLO
	univ.uniyar.ac.ru") by vger.kernel.org with ESMTP id S262075AbUB2RCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 12:02:41 -0500
Date: Sun, 29 Feb 2004 20:02:12 +0300 (MSK)
From: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
To: linux-kernel@vger.kernel.org
Subject: __buggy_fxsr_alignment() not found.
Message-ID: <Pine.GSO.3.96.SK.1040229200132.17294A-100000@univ.uniyar.ac.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
My system is:
AMD K6-II 450
Linux-2.4.24
glibc-2.2.5

I cannot compile 2.4.24 kernel because linker says:
init/main.o: In function `check_fpu':
init/main.o(.text.init+0x53): undefined reference to `__buggy_fxsr_alignment'

It's prototype is in inculude/asm-i386/bugs.h:
-----
/* Enable FXSR and company _before_ testing for FP problems. */
        /*
         * Verify that the FXSAVE/FXRSTOR data will be 16-byte aligned.
         */
        if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
              extern void __buggy_fxsr_alignment(void);
              __buggy_fxsr_alignment();
-----
But there is no realisation of this function in source files.
When I comment the lines above, everything works.

Please CC to Reply-to.

