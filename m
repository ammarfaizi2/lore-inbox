Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267414AbSKQAHu>; Sat, 16 Nov 2002 19:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267415AbSKQAHu>; Sat, 16 Nov 2002 19:07:50 -0500
Received: from holomorphy.com ([66.224.33.161]:63446 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267414AbSKQAHt>;
	Sat, 16 Nov 2002 19:07:49 -0500
Date: Sat, 16 Nov 2002 16:11:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [lart] /bin/ps output
Message-ID: <20021117001111.GG23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dave Hansen <haveblue@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <3DA798B6.9070400@us.ibm.com> <20021116092424.GY22031@holomorphy.com> <1037491895.24777.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037491895.24777.26.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2002 at 12:11:35AM +0000, Alan Cox wrote:
> Bill - so what happens if you trim down the aio, event and ksoftirqd
> threads to a sane size (you might also want to do something about the
> fact 2.5 still runs ksoftirq too easily). Intuitively I'd go for a
> square root of the number of processors + 1 sort of function but what do
> the benchmarks say ?


Both reorganizing the per-cpu thread pools as state machines and
inserting new locking look like work-intensive projects...

It's not become explosively bad yet (1MB of overhead is eyebrow-raising
but not particularly damaging) so there's no rush to trim this down,
but I'm at least thinking about doing this later. One of the major
obstacles for the state machine approach is that the migration threads
run at RT priority while the rest do not, and of course the greater
than per-cpu granularity approach suffers from additional locking.


Bill
