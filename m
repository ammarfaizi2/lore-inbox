Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751833AbWJGSo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWJGSo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 14:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWJGSo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 14:44:28 -0400
Received: from hosting.zipcon.net ([209.221.136.3]:32972 "EHLO
	hosting.zipcon.net") by vger.kernel.org with ESMTP id S1751833AbWJGSo1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 14:44:27 -0400
From: Bill Waddington <william.waddington@beezmo.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Date: Sat, 07 Oct 2006 11:44:22 -0700
Message-ID: <epsfi2t2dkegcm339i310e6k445k2klqt9@4ax.com>
References: <fa.FU9k10MvHKEiGBkmyRa0N7lIvX4@ifi.uio.no> <fa.YmeJPP3GwSahgI09Gcaha4kqm84@ifi.uio.no> <fa.qbSmIOXP3NtOgNMHs5oazelaSJs@ifi.uio.no> <fa.AB8rZ1kwd3vQ1HCbYfV1438E4A0@ifi.uio.no> <fa.fxkKYbd7b8jGDAGrZeNdx030Z/g@ifi.uio.no> <20061002140121.f588b463.akpm@osdl.org> <fa.v9OUIBlFjbmpdm2jHjUOj/6fm5Y@ifi.uio.no>
In-Reply-To: <fa.v9OUIBlFjbmpdm2jHjUOj/6fm5Y@ifi.uio.no>
X-Mailer: Forte Agent 3.3/32.846
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.zipcon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - beezmo.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2006 10:52:19 UTC, in fa.linux.kernel Ingo Molnar
wrote:

>
>* Andrew Morton <akpm@osdl.org> wrote:
>
>> > I don't personally mind the patch, I just wanted to bring that issue 
>> > up.
>> 
>> yup.  Perhaps we could add
>> 
>> #define IRQ_HANDLERS_DONT_USE_PTREGS
>> 
>> so that out-of-tree drivers can reliably do their ifdefing.
>
>i'd suggest we do something like:
>
> #define __PT_REGS
>
>so that backportable drivers can do:
>
>  static irqreturn_t irq_handler(int irq, void *dev_id __PT_REGS)
>
>instead of an #ifdef jungle. Older kernel bases can define __PT_REGS in 
>their interrupt.h (or in the backported driver's header, in one place)
>
> #ifndef __PT_REGS
> # define __PT_REGS , struct pt_regs *regs
> #endif
>
>this would minimize the direct impact in the source-code.

Has this or something like it been sprinkled with penguin pee?  I'm
one of those misguided out-of-tree maintainers.  I dont' use pt_regs
but like warning-free compiles - and a single code module when
possible.

Thanks,
Bill
-- 
William D Waddington
william.waddington@beezmo.com
"Even bugs...are unexpected signposts on
the long road of creativity..." - Ken Burtch
