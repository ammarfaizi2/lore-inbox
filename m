Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSFRUzl>; Tue, 18 Jun 2002 16:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317620AbSFRUzk>; Tue, 18 Jun 2002 16:55:40 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:51953 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317619AbSFRUzj>; Tue, 18 Jun 2002 16:55:39 -0400
Subject: Re: latest linus-2.5 BK broken
From: Robert Love <rml@tech9.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E17KPdj-0004EP-00@wagner.rustcorp.com.au>
References: <E17KPdj-0004EP-00@wagner.rustcorp.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 18 Jun 2002 13:55:38 -0700
Message-Id: <1024433739.922.236.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-18 at 13:31, Rusty Russell wrote:

> No, you have accepted a non-portable userspace interface and put it in
> generic code.  THAT is idiotic.
> 
> So any program that doesn't use the following is broken:

On top of what Linus replied, there is the issue that if your task does
not know how many CPUs can be in the system then setting its affinity is
worthless in 90% of the cases.

I.e., everyone today can write code like

	sched_setaffinity(0, sizeof(unsigned long), &mask)

but let's say this code is executed on a system with a different number
of bits in the CPU mask.  What do you do with the new/old bits?  Ignore
them?  Set new ones to zero?  To 1?

Summarily, setting CPU affinity is something that is naturally low-level
enough it only makes sense when you know what you are setting and not
setting.  While a mask of -1 may always make sense, random bitmaps
(think RT stuff here) are explicit for the number of CPUs given.

The interface is designed to make this easy clean as possible - i.e.,
the size check, etc.

	Robert Love

