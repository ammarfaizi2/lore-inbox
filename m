Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVJXPhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVJXPhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVJXPhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:37:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16342 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751081AbVJXPhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:37:23 -0400
To: vgoyal@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] i386: move apic init in init_IRQs
References: <m1fyrh8gro.fsf@ebiederm.dsl.xmission.com>
	<20051021133306.GC3799@in.ibm.com>
	<m1ach3dj47.fsf@ebiederm.dsl.xmission.com>
	<20051022145207.GA4501@in.ibm.com>
	<m11x2deft5.fsf@ebiederm.dsl.xmission.com>
	<20051024130311.GA5853@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 24 Oct 2005 09:36:52 -0600
In-Reply-To: <20051024130311.GA5853@in.ibm.com> (Vivek Goyal's message of
 "Mon, 24 Oct 2005 18:33:11 +0530")
Message-ID: <m1u0f7c4ff.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> You are right. hard_smp_processor_id() is hard-coded to zero in case of a
> non SMP kernel (include/linux/smp.h) and that's why the problem is happening.
> I am booting a non-SMP capture kernel. In case of kexec on panic, we can very
> well boot on a cpu whose id is not zero.
>
> I have attached a patch with the mail which is now using
> boot_cpu_physical_apicid to hard set presence of boot cpu instead of
> hard_smp_processor_id(). But the interesting questoin remains why BIOS is
> not reporting the boot cpu.

Ok this looks good.  But it raises a couple of followup questions.
- Are there other places that use hard_smp_processor_id in 
  in a uniprocessor kernel?
- Does x86_64 have this same problem?

Anyway it looks like we have this working which is a big step forward
in having a reliable kdump mechanism.

Eric
