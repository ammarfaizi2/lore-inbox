Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280765AbRKBSS0>; Fri, 2 Nov 2001 13:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280764AbRKBSSR>; Fri, 2 Nov 2001 13:18:17 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:40069 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S280763AbRKBSSB>; Fri, 2 Nov 2001 13:18:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>,
        Sven Heinicke <sven@research.nj.nec.com>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Date: Fri, 2 Nov 2001 19:19:01 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Ben Smith <ben@google.com>,
        Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <15330.56589.291830.542215@abasin.nj.nec.com> <20011102190046.B6003@athlon.random>
In-Reply-To: <20011102190046.B6003@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011102181758Z16039-4784+420@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 2, 2001 07:00 pm, Andrea Arcangeli wrote:
> On Fri, Nov 02, 2001 at 12:51:09PM -0500, Sven Heinicke wrote:
> > a bunch of times.  Then doesn't free the mmaped memory until file
> > system is unmounted.  It never starts going into swap.
> 
> thanks for testing. This matches the idea that those pages doesn't want
> to be unmapped for whatever reason (and because there's an mlock in our
> way at the moment I'd tend to point my finger in that direction rather
> than into the vm direction). I'll look more closely into this testcase
> shortly.

The mlock handling looks dead simple:

vmscan.c
227         if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
228                 return count;

It's hard to see how that could be wrong.  Plus, this test program does run 
under 2.4.9, it just uses way too much CPU on that kernel.  So I'd say mm 
bug.

--
Daniel
