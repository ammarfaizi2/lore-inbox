Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbRCTJdU>; Tue, 20 Mar 2001 04:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129346AbRCTJdK>; Tue, 20 Mar 2001 04:33:10 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:11783 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129321AbRCTJdF>;
	Tue, 20 Mar 2001 04:33:05 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: nigel@nrg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: Your message of "Tue, 20 Mar 2001 19:43:50 +1100."
             <m14fHk9-001PKgC@mozart> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 20 Mar 2001 20:32:15 +1100
Message-ID: <851.985080735@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001 19:43:50 +1100, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>The third is that preemtivity conflicts with the naive
>quiescent-period approach proposed for module unloading in 2.5, and
>useful for several other things (eg. hotplugging CPUs).  This method
>relies on knowing that when a schedule() has occurred on every CPU, we
>know noone is holding certain references.
>
>This, too, is soluble, but it means that synchronize_kernel() must
>guarantee that each task which was running or preempted in kernel
>space when it was called, has been non-preemtively scheduled before
>synchronize_kernel() can exit.  Icky.

The preemption patch only allows preemption from interrupt and only for
a single level of preemption.  That coexists quite happily with
synchronize_kernel() which runs in user context.  Just count user
context schedules (preempt_count == 0), not preemptive schedules.

