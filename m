Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUFDSVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUFDSVT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 14:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUFDSVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 14:21:18 -0400
Received: from holomorphy.com ([207.189.100.168]:52647 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265921AbUFDSU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 14:20:29 -0400
Date: Fri, 4 Jun 2004 11:20:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>, mikpe@csd.uu.se, nickpiggin@yahoo.com.au,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       Simon.Derr@bull.net
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based implementation
Message-ID: <20040604182018.GH21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, mikpe@csd.uu.se, nickpiggin@yahoo.com.au,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
	ak@muc.de, ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
	joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
	Simon.Derr@bull.net
References: <20040604093712.GU21007@holomorphy.com> <16576.17673.548349.36588@alkaid.it.uu.se> <20040604095929.GX21007@holomorphy.com> <16576.23059.490262.610771@alkaid.it.uu.se> <20040604112744.GZ21007@holomorphy.com> <20040604113252.GA21007@holomorphy.com> <20040604092316.3ab91e36.pj@sgi.com> <20040604162853.GB21007@holomorphy.com> <20040604104756.472fd542.pj@sgi.com> <20040604181233.GF21007@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604181233.GF21007@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 11:12:33AM -0700, William Lee Irwin III wrote:
> 	while (lower < upper) {

--- nr_cpus.c.orig	2004-06-04 11:16:16.492419568 -0700
+++ nr_cpus.c	2004-06-04 11:16:26.508896832 -0700
@@ -23,7 +23,7 @@
 		if (!realloc(cpus, 2*upper))
 			return -ENOMEM;
 	}
-	while (lower < upper) {
+	while (lower < upper - 1) {
 		middle = (lower + upper)/2;
 		if (!realloc(cpus, middle))
 			return -ENOMEM;
