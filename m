Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWGCQcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWGCQcU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 12:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWGCQcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 12:32:19 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:42986 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750953AbWGCQcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 12:32:16 -0400
Date: Mon, 3 Jul 2006 09:31:48 -0700
From: Paul Jackson <pj@sgi.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: akpm@osdl.org, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org,
       hadi@cyberus.ca, netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060703093148.5e61a7e4.pj@sgi.com>
In-Reply-To: <44A93179.2080303@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
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
	<44A57310.3010208@watson.ibm.com>
	<44A5770F.3080206@watson.ibm.com>
	<20060630155030.5ea1faba.akpm@osdl.org>
	<44A5DBE7.2020704@watson.ibm.com>
	<44A5EDE6.3010605@watson.ibm.com>
	<20060702215350.2c1de596.pj@sgi.com>
	<44A93179.2080303@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh wrote:
> I don't know if there are buffer overflow 
> issues in passing a string

I don't know if this comment applies to "the standard netlink way of
passing it up using NLA_STRING", but the way I deal with buffer length
issues in the cpuset code is to insist that the user code express the
list in no fewer than 100 + 6 * NR_CPUS bytes:

>From kernel/cpuset.c:

        /* Crude upper limit on largest legitimate cpulist user might write. */
        if (nbytes > 100 + 6 * NR_CPUS)
                return -E2BIG;

This lets the user specify the buffer size passed in, but prevents
them from trying a denial of service attack on the kernel by trying
to pass in a huge buffer.

If the user can't figure out how to write the desired cpulist in
that size, then tough toenails.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
