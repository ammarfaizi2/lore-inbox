Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUFECxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUFECxr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 22:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUFECxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 22:53:47 -0400
Received: from holomorphy.com ([207.189.100.168]:38826 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264501AbUFECxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 22:53:46 -0400
Date: Fri, 4 Jun 2004 19:51:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, pj@sgi.com, mikpe@csd.uu.se,
       nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, ak@muc.de, ashok.raj@intel.com,
       hch@infradead.org, jbarnes@sgi.com, joe.korty@ccur.com,
       manfred@colorfullife.com, colpatch@us.ibm.com, Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040605025131.GO21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, pj@sgi.com, mikpe@csd.uu.se,
	nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org, ak@muc.de, ashok.raj@intel.com,
	hch@infradead.org, jbarnes@sgi.com, joe.korty@ccur.com,
	manfred@colorfullife.com, colpatch@us.ibm.com, Simon.Derr@bull.net
References: <20040604095929.GX21007@holomorphy.com> <16576.23059.490262.610771@alkaid.it.uu.se> <20040604112744.GZ21007@holomorphy.com> <20040604113252.GA21007@holomorphy.com> <20040604092316.3ab91e36.pj@sgi.com> <20040604162853.GB21007@holomorphy.com> <20040604104756.472fd542.pj@sgi.com> <20040604181233.GF21007@holomorphy.com> <20040604112730.534cca55.akpm@osdl.org> <20040604183815.GI21007@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604183815.GI21007@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 11:38:15AM -0700, William Lee Irwin III wrote:
>  		if (!realloc(cpus, 2*upper))
> -			return -ENOMEM;
> +			goto out;

... and as someone pointed out:


--- nr_cpus.c.orig3	2004-06-04 19:49:15.000000000 -0700
+++ nr_cpus.c	2004-06-04 19:49:31.000000000 -0700
@@ -24,12 +24,12 @@
 	if (!cpus)
 		return -ENOMEM;
 	for (upper = lower; getaffinity(0, upper, cpus) < 0; upper *= 2) {
-		if (!realloc(cpus, 2*upper))
+		if (!(cpus = realloc(cpus, 2*upper)))
 			goto out;
 	}
 	while (lower < upper - 1) {
 		middle = (lower + upper)/2;
-		if (!realloc(cpus, middle))
+		if (!(cpus = realloc(cpus, middle)))
 			goto out;
 		if (getaffinity(0, middle, cpus) < 0)
 			lower = middle;
