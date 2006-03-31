Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWCaLUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWCaLUt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 06:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWCaLUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 06:20:49 -0500
Received: from morbo.e-centre.net ([66.154.82.3]:12238 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP
	id S1751250AbWCaLUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 06:20:49 -0500
X-ASG-Debug-ID: 1143804047-22205-391-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Re: [PATCH] ioremap_cached()
Subject: Re: [PATCH] ioremap_cached()
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060330164120.GJ13590@parisc-linux.org>
References: <20060330164120.GJ13590@parisc-linux.org>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 13:20:44 +0200
Message-Id: <1143804045.3053.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10304
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> It seems clear to me that ioremap() and ioremap_nocache() are the
> wrong way around.  The default needs to be uncached -- and the obvious
> (rare) alternative becomes ioremap_cached().
> 
> So here's a patch for i386 to add ioremap_cached() and make ioremap()
> uncached.  ioremap_nocache() remains as an alias for ioremap() so we
> don't needlessly break old drivers.  Architecture maintainers will need
> to fix up their ports if this patch is accepted.

I'd actually suggest deprecating ioremap() and moving away from it to
make sure all users think of which variant they want. Explicit naming is
always better than "some" unknown behavior (especially for old drivers
that work on multiple kernels... while you allow them to keep compiling,
you change the world under them so I think eventually break them
compiling is actually better than having them limp along broken)

