Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281572AbRK0QlL>; Tue, 27 Nov 2001 11:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281541AbRK0QlI>; Tue, 27 Nov 2001 11:41:08 -0500
Received: from mx2.elte.hu ([157.181.151.9]:49384 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S281504AbRK0Qkm>;
	Tue, 27 Nov 2001 11:40:42 -0500
Date: Tue, 27 Nov 2001 19:38:22 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rusty <rusty@rustcorp.com.au>
Subject: Re: smp_call_function & BH handlers
In-Reply-To: <20011127215910.I14200@in.ibm.com>
Message-ID: <Pine.LNX.4.33.0111271935520.23151-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Nov 2001, Maneesh Soni wrote:

> I am working with Dipankar on Read-Copy Update, and experimenting with
> smp_call_function(). We believed the comments for this routine and
> faced this problem. That's why this question came. I have not yet
> searched kernel sources for such places hence not sure whether there
> are really such places or not.

we had similar lockup problems before, eg. TLB flushes initiated from
IRQ/BH contexts - which is illegal now. Generally it's not safe to assume
that every CPU is responsive to synchronous events triggered from IRQ/BH
contexts. Every read_lock user is prone to this problem.

	Ingo

