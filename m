Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbTAECu2>; Sat, 4 Jan 2003 21:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbTAECu2>; Sat, 4 Jan 2003 21:50:28 -0500
Received: from users.ccur.com ([208.248.32.211]:55025 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S262415AbTAECu1>;
	Sat, 4 Jan 2003 21:50:27 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200301050258.CAA01487@rudolph.ccur.com>
Subject: Re: 2.4.21-pre2 stalls out when running unixbench
To: akpm@digeo.com (Andrew Morton)
Date: Sat, 4 Jan 2003 21:58:33 -0500 (EST)
Cc: joe.korty@ccur.com (Joe Korty), sct@redhat.com, adilger@clusterfs.com,
       rusty@rustcorp.com.au, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, hch@sgi.com
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <3E16C171.BFEA45AE@digeo.com> from "Andrew Morton" at Jan 04, 2003 03:11:45 AM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With respect to the lockup problem: it is due to a non-atomic __set_bit()
> in the new buffer_attached() implementation.
> 
> Sure, we don't need atomic semantics for the BH_Attached bit because
> it is always read and modified under a global spinlock.  But *other*
> users of buffer_head.b_state do not run under that lock so the nonatomic
> RMW will stomp on their changes.   2.4.20 does not have this bug.
> 
> Here is a patch:


Hi Andrew,
The patch works (been running the unixbench subset for an hour now).
Your time and effort and very clear explanations are much appreciated.
Thanks,
Joe
