Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWF2TYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWF2TYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWF2TYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:24:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41891 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932296AbWF2TXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:23:45 -0400
Date: Thu, 29 Jun 2006 12:23:20 -0700
From: Paul Jackson <pj@sgi.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: akpm@osdl.org, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org,
       hadi@cyberus.ca, netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060629122320.c239a8be.pj@sgi.com>
In-Reply-To: <44A425A7.2060900@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	<449999D1.7000403@engr.sgi.com>
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
	<44A425A7.2060900@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh wrote:
> First off, just a reminder that this is inherently a netlink flow
> control issue...which was being exacerbated earlier by taskstats
> decision to send per-tgid data (no longer the case).
> 
> But I'd like to know whats our target here ? How many messages
> per second do we want to be able to be sent and received without
> risking any loss of data ? Netlink will lose messages at a high
> enough rate so the design point will need to be known a bit.

Perhaps its not so much an issue of the design rate, as an issue of
how we deal with hitting the limit.  Sooner or later, perhaps due to
operator error, almost any implementable rate will be exceeded.

Ideally, we would both of the remedies that Andrew mentioned,
rephrasing:
 1) a way for a customer who needs a higher rate to scale
    the useful resources he can apply to the collection, and
 2) a clear indicator when the supported rate was exceeded
    anyway.

> For statistics type usage of the genetlink/netlink, I would have
> thought that userspace, provided it is reliably informed about the loss
> of data through ENOBUFS, could take measures to just account for the
> missing data and carry on ?

If that's so, then the ENOBUFS error may well meet my remedy (2) above,
leaving just the question of how a customer could scale to higher
rates, if they found it was worth doing so.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
