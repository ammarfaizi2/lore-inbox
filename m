Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWF3BC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWF3BC3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 21:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWF3BC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 21:02:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750704AbWF3BC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 21:02:27 -0400
Date: Thu, 29 Jun 2006 18:05:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: hadi@cyberus.ca, pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060629180502.3987a98e.akpm@osdl.org>
In-Reply-To: <44A47285.6060307@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
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
	<44A425A7.2060900@watson.ibm.com>
	<20060629123338.0d355297.akpm@osdl.org>
	<44A43187.3090307@watson.ibm.com>
	<1151621692.8922.4.camel@jzny2>
	<44A47285.6060307@watson.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
> The rates (or upper bounds) that are being discussed here, as of now, 
> are 1000 exits/sec/CPU for
> 1024 CPU systems. That would be roughly 1M exits/system * 
> 248Bytes/message  = 248 MB/sec.

I think it's worth differentiating between burst rates and sustained rates
here.

One could easily imagine 10,000 threads all exiting at once, and the user
being interested in reliably collecting the results.

But if the machine is _sustaining_ such a high rate then that means that
these exiting tasks all have a teeny runtime and the user isn't going to be
interested in the per-thread statistics.

So if we can detect the silly sustained-high-exit-rate scenario then it
seems to me quite legitimate to do some aggressive data reduction on that. 
Like, a single message which says "20,000 sub-millisecond-runtime tasks
exited in the past second" or something.

