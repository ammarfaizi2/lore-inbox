Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbVL1Run@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVL1Run (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVL1Run
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:50:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:908 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964859AbVL1Rum convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:50:42 -0500
Message-ID: <1880308.1135792235045.SLOX.WebMail.wwwrun@imap-dhs.suse.de>
Date: Wed, 28 Dec 2005 18:50:35 +0100 (CET)
From: Andreas Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [RFC] [PATCH] Add memcpy32 function
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1135782025.1527.104.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-304-smp i386 (JVM 1.3.1_16)
Organization: SuSE Linux AG
References: <1135301759.4212.76.camel@serpentine.pathscale.com> <p73fyodmqn6.fsf@verdi.suse.de> <1135782025.1527.104.camel@serpentine.pathscale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi 28.12.2005 16:00 schrieb Bryan O'Sullivan <bos@pathscale.com>:

> All of our uses of memcpy_toio32 (which uses memcpy32 on x86_64) copy
> from kernel virtual addresses to MMIO space. There's no direct copying
> from userspace to MMIO space through the driver.
>
> However, we do let userspace code directly access portions of our
> chip.
> That code uses a routine that is exactly the same as memcpy32 to
> perform
> MMIO writes. That's where I think the confusion arose on the part of
> whoever responded to you.

Ok thanks. And do you have numbers that show that the assembly
function with rep ; movsl actually  improves performance over C?  I
guess the MMIO
is uncached or at best write combined and in both cases it usually
doesn't
matter if the CPU burns a few more cycles generating the writes or not
because everything is bus bound and every cycle you save
is just lost again on the next synchronization point with the hardware.

If the assembly is not really faster I would recommend you just use a
writel()
loop in the driver instead of adding this very special purpose function
everywhere.

-Andi




