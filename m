Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933060AbWF2WXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933060AbWF2WXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933062AbWF2WXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:23:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34223 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S933060AbWF2WXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:23:43 -0400
Date: Thu, 29 Jun 2006 15:23:19 -0700
From: Paul Jackson <pj@sgi.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: akpm@osdl.org, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060629152319.cfffe0d6.pj@sgi.com>
In-Reply-To: <44A4492E.6090307@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	<4499D7CD.1020303@engr.sgi.com>
	<449C2181.6000007@watson.ibm.com>
	<20060623141926.b28a5fc0.akpm@osdl.org>
	<449C6620.1020203@engr.sgi.com>
	<20060623164743.c894c314.akpm@osdl.org>
	<449CAA78.4080902@watson.ibm.com>
	<20060623213912.96056b02.akpm@osdl.org>
	<449CD4B3.8020300@watson.ibm.com>
	<44A01A50.1050403@sgi.com>
	<20060626105548.edef4c64.akpm@osdl.org>
	<44A020CD.30903@watson.ibm.com>
	<20060626111249.7aece36e.akpm@osdl.org>
	<44A026ED.8080903@sgi.com>
	<20060626113959.839d72bc.akpm@osdl.org>
	<44A2F50D.8030306@engr.sgi.com>
	<20060628145341.529a61ab.akpm@osdl.org>
	<44A2FC72.9090407@engr.sgi.com>
	<20060629014050.d3bf0be4.pj@sgi.com>
	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	<20060629094408.360ac157.pj@sgi.com>
	<20060629110107.2e56310b.akpm@osdl.org>
	<20060629112642.66f35dd5.pj@sgi.com>
	<44A426DC.9090009@watson.ibm.com>
	<20060629124148.48d4c9ad.pj@sgi.com>
	<44A4492E.6090307@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh wrote:
> The idea of collecting stats for a group of cpus rather than all
> (or one) seems attractive.  But cpusets doesnt :-)

Ok ... ;).

If you think yet another cpu grouping mechanism is needed, I'm not
the unbiased neutral part to say it's not needed.

However a static grouping does not seem to fit the actual usage
patterns that we see, at least on our (unusally large) Altix
systems.

At least in the usage we see, people run various sized, independent
jobs on a system, using cpusets to define the cpu and memory containers
holding those jobs.  Much of what they do is naturally divided along
those job boundaries, so they want the ability to dynamically size
other resource management and tracking facilities along the same
boundaries.

One job might want to trace a data stream with no data loss, even if
it means slowing the job down.  Another job might want to collect what
it can with limited collecting resources, and let the bits fall where
they will.  A third job might want to increase the data collection
resources sufficiently to collect alot of data while not slowing the
job down.  One job might have very high fork/exit rates, and another
very low.

If the collectors are grouped along natural job boundaries, there might
not be any need to combine multiple streams, hence no need for the
timestamps you mention.  Cpusets are perhaps the best surrogate for
these boundaries.  Cpusets are hierarchical, so it would be convenient
to have a single collector for a large group of jobs.

It may well be that you find cpusets unattactive for this use for
good reason.  Or perhaps you find them unattractive here just out of
unfamilarity or misunderstanding.  Before introducing yet another
grouping mechanism, we should have an explanation of why the current
mechanism(s) are unsuitable.  Hopefully an explanation slightly more
elaborate than "doesn't seem attactive" ;).

(Hmmm ... I hope I don't end up regretting asking the question "why
do cpusets suck for this ...?")

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
