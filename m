Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267351AbSIRRLE>; Wed, 18 Sep 2002 13:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267354AbSIRRLD>; Wed, 18 Sep 2002 13:11:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18194 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267351AbSIRRLD>; Wed, 18 Sep 2002 13:11:03 -0400
Date: Wed, 18 Sep 2002 10:16:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andries Brouwer <aebr@win.tue.nl>, Ingo Molnar <mingo@elte.hu>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <Pine.LNX.4.44L.0209181358470.1519-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0209181008570.1125-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Rik van Riel wrote:
> 
> That's about 18 times the timeout for the NMI oopser and will cause
> people real trouble.

Where did this NMI oopser argument come from? get_pid() doesn't even
disable interrupts. And we hold the read lock, and other interrupts aren't 
allowed to take the write lock anyway. If the NMI oopser triggers, then 
something else is going on than get_pid().

		Linus

