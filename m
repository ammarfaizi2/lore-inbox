Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVHGLgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVHGLgD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 07:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVHGLgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 07:36:03 -0400
Received: from ns2.suse.de ([195.135.220.15]:3741 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751062AbVHGLgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 07:36:02 -0400
To: Erick Turnquist <jhujhiti@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks on x86_64
References: <5348b8ba050806204453392f7f@mail.gmail.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Aug 2005 13:36:01 +0200
In-Reply-To: <5348b8ba050806204453392f7f@mail.gmail.com.suse.lists.linux.kernel>
Message-ID: <p73mznuc732.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erick Turnquist <jhujhiti@gmail.com> writes:

> Hi, I'm running an Athlon64 X2 4400+ (a dual core model) with an
> nVidia GeForce 6800 Ultra on a Gigabyte GA-K8NXP-SLI motherboard and
> getting nasty messages like these in my dmesg:
> 
> warning: many lost ticks.
> Your time source seems to be instable or some driver is hogging interupts
> rip default_idle+0x20/0x30

It's most likely bad SMM code in the BIOS that blocks the CPU too long
and is triggered in idle. You can verify that by using idle=poll
(not recommended for production, just for testing) and see if it goes away.

No way to fix this, but you can work around it with very new kernels
by compiling with a lower HZ than 1000.

-Andi
