Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUHOXui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUHOXui (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267272AbUHOXuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:50:37 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29396 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267259AbUHOXug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:50:36 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040815115649.GA26259@elte.hu>
References: <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu>
	 <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu>  <20040815115649.GA26259@elte.hu>
Content-Type: text/plain
Message-Id: <1092613882.867.33.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 19:51:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 07:56, Ingo Molnar wrote:
> i've uploaded the -P0 patch:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P0
> 
> those who had APIC (and USB, under SMP) problems under previous
> versions, are the problems still present in -P0?
>  

The mlockall issue is still not resolved; however, I did manage to get a
trace, which was probably not possible before because some higher
latency but lower frequency event was overwriting /proc/latency_trace. 
So, maybe mlockall does cause xruns by having many shorter, but long
enough to be problematic, non-preemptible sections.

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P0

Also it seems that extract_entropy still causes high latencies, even
though a call to preempt_schedule was added.  I looked at the code in
random.c a bit and this strikes me as an area where the algorithm could
be improved, rather than adding a scheduling point.  Do we really need
*that* much entropy, right then?  And if so, isn't there a zero-copy
solution?

Lee



