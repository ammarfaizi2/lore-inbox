Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268528AbTANDHZ>; Mon, 13 Jan 2003 22:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268535AbTANDHZ>; Mon, 13 Jan 2003 22:07:25 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37559 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S268528AbTANDHY>; Mon, 13 Jan 2003 22:07:24 -0500
Date: Mon, 13 Jan 2003 19:15:00 -0800
Message-Id: <200301140315.h0E3F0E17051@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: theowl@freemail.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: PTRACE_GET_THREAD_AREA
In-Reply-To: theowl@freemail.hu's message of  Monday, 13 January 2003 12:37:04 +0100 <3E22B2F0.31397.E719685@localhost>
X-Windows: it could happen to you.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i've just seen your patch submitted to 2.5 and i think there's a mistake
> in there. this:
> 
> #define GET_32BIT(desc)		(((desc)->b >> 23) & 1)
> 
> should be
> 
> #define GET_32BIT(desc)		(((desc)->b >> 22) & 1)
> 
> i.e., bit 22 determines the segment bitness (default address/operand
> size), whereas bit 23 determines the granularity used to interpret the
> segment limit.

Those macros in my patch are copied directly from process.c where
get_thread_area is implemented.  Since the purpose of
PTRACE_GET_THREAD_AREA is to match what get_thread_area does, it's correct
that it match.  

But I think you are right that the definition is wrong.  It's obviously
suspect that two things are defined using the same bit:

#define GET_32BIT(desc)		(((desc)->b >> 23) & 1)
#define GET_LIMIT_PAGES(desc)	(((desc)->b >> 23) & 1)

This should be fixed in both process.c and ptrace.c together.
