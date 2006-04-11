Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWDKOCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWDKOCP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 10:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWDKOCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 10:02:15 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:19140 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750815AbWDKOCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 10:02:14 -0400
Date: Tue, 11 Apr 2006 09:01:46 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, sam@vilain.net,
       "Eric W. Biederman" <ebiederm@xmission.com>, xemul@sw.ru,
       James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 0/5] uts namespaces: Introduction
Message-ID: <20060411140146.GB10610@sergelap.austin.ibm.com>
References: <20060407095132.455784000@sergelap> <443BA1D3.1070200@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443BA1D3.1070200@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kirill Korotaev (dev@sw.ru):
> Serge,
> 
> >This patchset is based on Kirill Korotaev's Mar 24 submission, taking
> >comments (in particular from James Morris and Eric Biederman) into
> >account.
> thanks a lot for doing this!

NP, thanks for doing the first round.

> >Some performance results are attached.  I was mainly curious whether
> >it would be worth putting the task_struct->uts_ns pointer inside
> >a #ifdef CONFIG_UTS_NS.  The result show that leaving it in when
> >CONFIG_UTS_NS=n has negligable performance impact, so that is the
> >approach this patch takes.
> Serge, your testing approach looks really strange for me.
> First of all, you selected the worst namespace to check performance 
> overhead on.
> 1) uts_ns is rarely used and never used on hot paths,
> 2) also all these test suites below doesn't test the code paths you 
> modified.
> 
> So I wonder what was the goal of these tests, especially dbench?!

Right, I wasn't actually aiming to test the performance of the uts
namespaces themselves (despite including those numbers), since they're
not on hot paths.  I was mostly curious whether putting the utsns
pointer into the task_struct would affect performance at all, to know
whether to put that inside an #ifdef.  Based on the results, I kept it
non-#ifdefed even if !CONFIG_UTS_NS, and that's what I was justifying
with those numbers.

These tests should be done again when we get 3 or 5 namespace pointers,
and perhaps there should still be some other tests included, ie mainly a
forkbomb perhaps.  I just did my default set of tests that I usually
use.

thanks,
-serge
