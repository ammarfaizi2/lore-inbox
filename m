Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318271AbSG3Nlh>; Tue, 30 Jul 2002 09:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318285AbSG3Nlg>; Tue, 30 Jul 2002 09:41:36 -0400
Received: from ns.suse.de ([213.95.15.193]:15366 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318271AbSG3Nlg>;
	Tue, 30 Jul 2002 09:41:36 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk.suse.lists.linux.kernel> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com.suse.lists.linux.kernel> <3D448808.CF8D18BA@zip.com.au.suse.lists.linux.kernel> <20020729004942.GL1201@dualathlon.random.suse.lists.linux.kernel> <3D44A2DF.F751B564@zip.com.au.suse.lists.linux.kernel> <20020729205211.GB1201@dualathlon.random.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Jul 2002 15:44:58 +0200
In-Reply-To: Andrea Arcangeli's message of "29 Jul 2002 22:58:11 +0200"
Message-ID: <p73ptx5s52d.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> > Then again, Andi says that sizeof(struct page) is a problem for
> > x86-64.
> 
> not true.

x86-64 has slightly below 100 bytes struct page

Big struct page eats your cache like crazy for many operations.
In addition it costs a considerable amount of memory.

Of course it is not a showstopper because there is no resource to run 
out of too quickly, but still needs attention as an important optimization
(either smaller struct page or bigger softpage size)

Of course longer term bigger softpage size is the best solution - that 
would make the >16GB i386 people happy too and avoid overhead on big memory
systems both 32bit and 64bit.. Unfortunately there are some
problems with the ELF alignment and the mmap API with it, which may be
no easy to solve.

-Andi
