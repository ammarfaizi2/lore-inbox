Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbSLQTDh>; Tue, 17 Dec 2002 14:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266491AbSLQTDg>; Tue, 17 Dec 2002 14:03:36 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51460 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266318AbSLQTDb>; Tue, 17 Dec 2002 14:03:31 -0500
Message-ID: <3DFF76D7.2050403@transmeta.com>
Date: Tue, 17 Dec 2002 11:11:19 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com> <Pine.LNX.4.50.0212162241150.26163-100000@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.50.0212162241150.26163-100000@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
> On Mon, 16 Dec 2002, Linus Torvalds wrote:
> 
>>It's not as good as a pure user-mode solution using tsc could be, but
>>we've seen the kinds of complexities that has with multi-CPU systems, and
>>they are so painful that I suspect the sysenter approach is a lot more
>>palatable even if it doesn't allow for the absolute best theoretical
>>numbers.
> 
> don't many of the multi-CPU problems with tsc go away because you've got a
> per-cpu physical page for the vsyscall?
> 
> i.e. per-cpu tsc epoch and scaling can be set on that page.
> 
> the only trouble i know of is what happens when an interrupt occurs and
> the task is rescheduled on another cpu... in theory you could test %eip
> against 0xfffffxxx and "rollback" (or complete) any incomplete
> gettimeofday call prior to saving a task's state.  but i bet that test is
> undesirable on all interrupt paths.
> 

Exactly.  This is a real problem.

	-hpa

