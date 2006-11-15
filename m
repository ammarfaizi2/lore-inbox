Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030620AbWKOQNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030620AbWKOQNy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030630AbWKOQNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:13:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:26848 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030620AbWKOQNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:13:52 -0500
Date: Wed, 15 Nov 2006 08:13:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Ingo Molnar <mingo@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Komuro <komurojun-mbn@nifty.com>, tglx@linutronix.de,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] genirq: do not mask interrupts by default
In-Reply-To: <20061115090427.GA16173@elte.hu>
Message-ID: <Pine.LNX.4.64.0611150808350.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
 <20061108085235.GT4729@stusta.de> <7813413.118221162987983254.komurojun-mbn@nifty.com>
 <11940937.327381163162570124.komurojun-mbn@nifty.com>
 <Pine.LNX.4.64.0611130742440.22714@g5.osdl.org> <m13b8ns24j.fsf@ebiederm.dsl.xmission.com>
 <1163450677.7473.86.camel@earth> <m1bqnboxv5.fsf@ebiederm.dsl.xmission.com>
 <1163492040.28401.76.camel@earth> <Pine.LNX.4.64.0611140757040.31445@g5.osdl.org>
 <20061115090427.GA16173@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Nov 2006, Ingo Molnar wrote:
> 
> problem is, we dont know /for a fact/ that something is "APIC-edge". We 
> only know that the BIOS claims it that it's so.

This is incorrect. We will have _programmed_ the APIC with whatever the 
BIOS said in the MP tables, so if we think it's level triggered, it _is_ 
level triggered.

So I really think that all the arguments for i8259 not wanting replay 
weigh equally on level-triggered PCI irq's too.

Now, the one thing that makes me think your approach is the right one is 
that it's potentially going to be better performance - if people disable 
irq's and the normal case is that no irq will actually happen, then 
optimistically not doing anything at all (except marking the irq disabled, 
of course) is always good.

However, because it's a semantic change, I _really_ don't want to do it 
right now. We're maybe a week away from 2.6.19, and the "ISA irq's don't 
work" report is one of the things that is holding things up right now.

So that's why I'd much rather go with Eric's patch for now - because it 
keeps the semantics that we've always had.

			Linus
