Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264909AbSJ3Ukj>; Wed, 30 Oct 2002 15:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbSJ3Ukj>; Wed, 30 Oct 2002 15:40:39 -0500
Received: from kim.it.uu.se ([130.238.12.178]:1480 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S264909AbSJ3Ukj>;
	Wed, 30 Oct 2002 15:40:39 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15808.17731.311432.596865@kim.it.uu.se>
Date: Wed, 30 Oct 2002 21:46:59 +0100
To: rml@tech9.net
CC: linux-kernel@vger.kernel.org
Subject: Are x86 trap gate handlers safe for preemption?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Consider an exception handler like vector 7, device_not_available:

ENTRY(device_not_available)
        pushl $-1                       # mark this as an int
        SAVE_ALL
        movl %cr0, %eax
        testl $0x4, %eax                # EM (math emulation bit)
        jne device_not_available_emulate
        preempt_stop

Since this is invoked via a trap gate and not an interrupt gate,
what's preventing this code from being preempted and resumed on
another CPU before the read from %cr0? Another example is the
machine_check vector (also trap gate) whose handlers access MSRs.

I'm sure this actually works, but I don't see how.

/Mikael
