Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278311AbRJSFrk>; Fri, 19 Oct 2001 01:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278312AbRJSFrU>; Fri, 19 Oct 2001 01:47:20 -0400
Received: from zero.tech9.net ([209.61.188.187]:30482 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S278311AbRJSFrM>;
	Fri, 19 Oct 2001 01:47:12 -0400
Subject: Re: 2.4.13pre5aa1
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20011019061914.A1568@athlon.random>
In-Reply-To: <20011019061914.A1568@athlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 19 Oct 2001 01:48:05 -0400
Message-Id: <1003470485.913.13.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-10-19 at 00:19, Andrea Arcangeli wrote:
> Only in 2.4.13pre3aa1: 00_files_struct_rcu-2.4.10-04-1
> Only in 2.4.13pre5aa1: 00_files_struct_rcu-2.4.10-04-2

I want to point out to preempt-kernel users that RCU is not
preempt-safe. The implicit locking assumed from per-CPU data structures
is defeated by preemptibility.

(Actually, FWIW, I think I can think of ways to make RCU preemptible but
it would involve changing the write-side quiescent code for the case
where the pointers were carried over the task switches.  Probably not
worth it.) 

This is not to say RCU is worthless with a preemptible kernel, but that
we need to make it safe (and then make sure it is still a performance
advantage, but I don't think this would add much overhead).  Note this
is clean, simply wrapping the read code in non-preemption statements.

I will hack up a patch when I get the time, but I would like to prevent
myself from maintaining the patch against a third tree ... where, oh
where, is 2.5? :)

	Robert Love

