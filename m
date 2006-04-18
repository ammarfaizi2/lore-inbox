Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWDRTH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWDRTH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 15:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWDRTH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 15:07:28 -0400
Received: from ns1.siteground.net ([207.218.208.2]:33752 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932288AbWDRTH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 15:07:27 -0400
Date: Tue, 18 Apr 2006 12:08:29 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Mingming Cao <cmm@us.ibm.com>, Takashi Sato <sho@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
Message-ID: <20060418190829.GA3905@localhost.localdomain>
References: <20060329175446.67149f32.akpm@osdl.org> <1144660270.5816.3.camel@openx2.frec.bull.fr> <20060410012431.716d1000.akpm@osdl.org> <1144941999.2914.1.camel@openx2.frec.bull.fr> <20060417210746.GB3945@localhost.localdomain> <1145308176.2847.90.camel@laptopd505.fenrus.org> <20060417213201.GC3945@localhost.localdomain> <1145344481.17767.1.camel@openx2.frec.bull.fr> <1145345407.2976.13.camel@laptopd505.fenrus.org> <1145357820.17767.11.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145357820.17767.11.camel@openx2.frec.bull.fr>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 12:57:00PM +0200, Laurent Vivier wrote:
> 
> I made tests on same system (x440) with postmark-1.51 :
> 
> pm> set numbers 100000
> pm> set transactions 250000
> pm> run
> 
> With atomic_t:
> 
> Time:
>         3761 seconds total
>         2414 seconds of transactions (103 per second)
> 
> Files:
>         225064 created (59 per second)
>                 Creation alone: 100000 files (87 per second)
>                 Mixed with transactions: 125064 files (51 per second)
>         124961 read (51 per second)
>         124895 appended (51 per second)
>         225064 deleted (59 per second)
>                 Deletion alone: 100128 files (503 per second)
>                 Mixed with transactions: 124936 files (51 per second)
> 
> Data:
>         731.14 megabytes read (199.07 kilobytes per second)
>         1359.02 megabytes written (370.02 kilobytes per second)
> 
> With percpu_counter:
> 
> Time:
>         3787 seconds total
>         2422 seconds of transactions (103 per second)
> 
> Files:
>         225064 created (59 per second)
>                 Creation alone: 100000 files (85 per second)
>                 Mixed with transactions: 125064 files (51 per second)
>         124961 read (51 per second)
>         124895 appended (51 per second)
>         225064 deleted (59 per second)
>                 Deletion alone: 100128 files (503 per second)
>                 Mixed with transactions: 124936 files (51 per second)
> 
> Data:
>         731.14 megabytes read (197.70 kilobytes per second)
>         1359.02 megabytes written (367.48 kilobytes per second)

Can we get oprofile output for these tests please?  It will give us a clue as
to how much of hot spots the ext3 atomic counters are with this benchmark.
Also, it will be nice to have results for 3-5 iterations of the test
to make sure we are looking at statistically significant numbers.

Thanks,
Kiran
