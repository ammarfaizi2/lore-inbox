Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbTBTE6W>; Wed, 19 Feb 2003 23:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTBTE6V>; Wed, 19 Feb 2003 23:58:21 -0500
Received: from holomorphy.com ([66.224.33.161]:16541 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264863AbTBTE6V>;
	Wed, 19 Feb 2003 23:58:21 -0500
Date: Wed, 19 Feb 2003 21:07:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
Message-ID: <20030220050722.GY29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Chris Wedgwood <cw@f00f.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>
References: <Pine.LNX.4.50.0302192113480.10247-100000@montezuma.mastecende.com> <Pine.LNX.4.44.0302192039400.1453-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302192039400.1453-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 08:52:46PM -0800, Linus Torvalds wrote:
> Whee. So the double-fault patch actually ends up being useful? It didn't 
> help with Chris' problem, but hey, if it helps with something else..
> Anyway, that %esp is crap, which also explains this:
>> 0xc01181c4 <do_page_fault+20>:  mov    %eax,0xc(%esp,1)
> Took a page fault because 0xc(%esp) wasn't there, and the page fault 
> couldn't write the fault trace to the stack (same reason), so you got a 
> double fault.

Not sure where he got his %esp, but I extracted the following:

<zwane> MAXMEM=0x33e00000
<zwane> vmalloc: start = 0xf3e1f000, end = 0xfbe21000
<zwane> fixaddr: start = 0xfbe23000, end = 0xfffff000

which means somehow %esp landed in an unmapped tidbit in the middle of
of vmallocspace that isn't even mapped. I highly suspect rounding
errors of mine since I squished vmallocspace, fixmapspace, and the
physical mapping so close together they might share L3 pagetables, i.e.
they're separated by 2*MMUPAGE_SIZE instead of customary 8MB or so.


-- wli
