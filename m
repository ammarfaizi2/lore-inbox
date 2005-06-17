Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVFQXVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVFQXVf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 19:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVFQXVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 19:21:35 -0400
Received: from soufre.accelance.net ([213.162.48.15]:17604 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S261191AbVFQXVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 19:21:32 -0400
Message-ID: <42B35AF8.9060301@xenomai.org>
Date: Sat, 18 Jun 2005 01:21:28 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] I-pipe: Introduction
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For the past five years now, I've been working on various real-time
solutions for Linux. Part of this involvement has been the development
of what has been known for a while as the Adeos nanokernel, and also
the refactoring of RTAI and its reimplementation known as the "Fusion"
track within this project. In order to take this work to the next step
and further increase the collaboration and integration with mainstream
kernel development, the following patchset introduces the
interrupt pipeline for Linux.

The I-pipe (in its abbreviated form) is a much stripped down version of
the interrupt pipeline that was contained in the Adeos implementation.
This refactored patchset retains many of the same properties of its
Adeos ancestor, including the ability to implement an executive running
side-by-side with Linux, albeit with less integration with Linux as was
possible with the full Adeos.

Most importantly, this patch makes it possible to obtain deterministic
interrupt response times from the Linux kernel without any further
additions or modifications. A driver, for example, may register a
handler as part of a priority interrupt domain in front of Linux and
thereafter obtain its interrupts in a deterministic fashion regardless
of whether any piece of Linux code has disabled interrupts. Also, it
should be relatively simple to create future iterations which would
allow what remains of Adeos to load itself on top of the I-pipe in
order to allow multiple executives to run side-by-side with Linux in a
fully-integrated fashion, as in Fusion for example.

Basically, the I-pipe inserts itself between the interrupt-management
hardware and Linux. Any attempt from any Linux component to disable
interrupts results in Linux's I-pipe stage to be stalled. While stalled,
a pipeline stage will not receive interrupts. However, any pipeline
stage of higher priority will continue receiving interrupts, unless it
too stalled its own stage. It follows that interrupts are almost never
disabled.

I've broken down the patch into a core set of changes and an x86
architecture-dependent implementation. As you will notice, the changes
in both cases are mainly the addition of the files implementing the
I-pipe, specifically:
- include/linux/ipipe.h
- include/asm-i386/ipipe.h
- ipipe/*
- kernel/ipipe.c
- arch/i386/kernel/ipipe.c

Note that this patch can be conjugated with PREEMPT_RT, as had been
previously demonstrated by the availability of a combo patch including
both Adeos and PREEMPT_RT. I therefore encourage those interested in
PREEMPT_RT to review the I-pipe patches.

Looking forward to your feedback,

-- 

Philippe.


