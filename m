Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267722AbSLGCBv>; Fri, 6 Dec 2002 21:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267723AbSLGCBv>; Fri, 6 Dec 2002 21:01:51 -0500
Received: from holomorphy.com ([66.224.33.161]:33681 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267722AbSLGCBt>;
	Fri, 6 Dec 2002 21:01:49 -0500
Date: Fri, 6 Dec 2002 18:09:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Norman Gaywood <norm@turing.une.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021207020910.GX9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Norman Gaywood <norm@turing.une.edu.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <20021206222852.GF4335@dualathlon.random> <20021206232125.GR9882@holomorphy.com> <3DF13A54.927C04C1@digeo.com> <20021207002133.GT9882@holomorphy.com> <1039227589.25062.10.camel@irongate.swansea.linux.org.uk> <20021207014643.GW9882@holomorphy.com> <1039228297.25045.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039228297.25045.12.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-12-07 at 01:46, William Lee Irwin III wrote:
>> It's an arch parameter, so they'd probably just
>> #define MMUPAGE_SIZE PAGE_SIZE
>> Hugh's original patch did that for all non-i386 arches.

On Sat, Dec 07, 2002 at 02:31:37AM +0000, Alan Cox wrote:
> These are low end x86 - but we could this based on
> 	<= i586
> 	i586
> 	i686+

It's relatively flexible as to the choice of PAGE_SIZE (it's
MMUPAGE_SIZE that's defined by hardware); about the only constraints
are that jacking it up where PAGE_SIZE spans pmd's breaks the core
vectoring API, PAGE_SIZE >= MMUPAGE_SIZE, both are powers of 2, the
vectors (which are of size MMUPAGE_COUNT*sizeof(pte_t *)) are stack-
allocated, and arch code has to understand small bits of it.

It sounds like we could pick sane defaults based on CPU revision.



Bill
