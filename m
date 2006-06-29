Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWF2TmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWF2TmO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWF2TmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:42:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62884 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751278AbWF2TmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:42:10 -0400
Date: Thu, 29 Jun 2006 12:41:48 -0700
From: Paul Jackson <pj@sgi.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: akpm@osdl.org, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060629124148.48d4c9ad.pj@sgi.com>
In-Reply-To: <44A426DC.9090009@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	<44999A98.8030406@engr.sgi.com>
	<44999F5A.2080809@watson.ibm.com>
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
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh wrote:
> I suppose this is because cpuset's offer some middle ground between 
> collecting data per-cpu vs. collecting it for all cpus ?

Yes - well said.  And I have this strange tendency to see all the
worlds problems as opportunities for cpuset solutions <grin>.

> What happens when someone is using cpusets on such a machine and
> changes its membership in response to other needs.  All taskstats
> users would need to monitor for such changes and adjust their
> processing....seems like unnecessary tying up of two unrelated
> concepts.

I would not expect taskstat users to monitor for such changes.
I'd expect them to monitor the stats from whatever is in the
cpuset they named.  If a task moves out of that cpuset to another,
then tough -- that task will no longer be monitored by that
particular monitoring request.

Cpusets do provide a convenient middle ground, as you say, which
is really useful for reducing scaling issues such as this one to
a managable size.

Per-cpu is too fine grained, and per-system too coarse.

An unnecessary tying - yes.  But perhaps a useful one.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
