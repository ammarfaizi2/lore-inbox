Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751567AbVHZNUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbVHZNUS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 09:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbVHZNUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 09:20:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:57561 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751567AbVHZNUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 09:20:16 -0400
Date: Fri, 26 Aug 2005 04:23:06 -0500
From: serue@us.ibm.com
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>,
       Stephen Smalley <sds@epoch.ncsc.mil>, linux-security-module@wirex.com
Subject: Re: [PATCH 0/5] LSM hook updates
Message-ID: <20050826092306.GA429@sergelap.austin.ibm.com>
References: <20050825012028.720597000@localhost.localdomain> <Pine.LNX.4.63.0508250038450.13875@excalibur.intercode> <20050825053208.GS7762@shell0.pdx.osdl.net> <20050825191548.GY7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825191548.GY7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wright (chrisw@osdl.org):
> * Chris Wright (chrisw@osdl.org) wrote:
> > I'll have some numbers tomorrow.  If you'd like to run SELinux that'd
> > be quite useful.
> 
> These are just lmbench and kernel build numbers (certainly not the best
> for real benchmark numbers, but easy to get a quick view run).  This is
> just baseline (i.e. default, nothing loaded).

Here are some numbers on a 4way x86 - PIII 700Mhz with 1G memory (hmm,
highmem not enabled).  I should hopefully have a 2way ppc available
later today for a pair of runs.

dbench and tbench were run 50 times each, kernbench and reaim 10 times
each.  Results are mean +/- 95% confidence half-interval.  Kernel had
selinux and capabilities compiled in.

A little surprising: kernbench is improved, but dbench and tbench
are worse - though within the 95% CI.

dbench (throughput, larger is better):
original: 357.957780 +/- 3.509188
patched:  351.266820 +/- 4.736168

tbench (throughput, larger is better):
original: 38.710270 +/- 0.028970
patched:  38.210506 +/- 0.032954

kernbench (time, smaller is better):
original: 91.837000 +/- 0.324471
patched:  91.466000 +/- 0.308797

reaim (#children vs throughput, larger is better):

original:
1 48702.197000 1875.223996
3 131411.870000 4497.107969
5 130219.174000 6365.289551
7 162377.027000 3131.071134
9 155432.904000 4964.935291
11 169784.384000 4490.812272
13 164540.169000 3902.652904
15 172983.569000 3149.934591

patched:
1 47525.273000 1509.578035
3 132151.651000 2282.043786
5 131244.291000 5874.212092
7 165629.693000 4646.641230
9 156163.110000 3422.903849
11 170608.526000 4132.988693
13 164863.102000 3664.214481
15 172947.803000 2548.662380

thanks,
-serge
