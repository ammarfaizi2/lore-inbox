Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVC3OvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVC3OvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 09:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVC3OvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 09:51:12 -0500
Received: from pat.uio.no ([129.240.130.16]:31206 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261914AbVC3OvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 09:51:08 -0500
Subject: Re: NFS client latencies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1112192778.17365.2.camel@mindpipe>
References: <1112137487.5386.33.camel@mindpipe>
	 <1112138283.11346.2.camel@lade.trondhjem.org>
	 <1112192778.17365.2.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 09:50:56 -0500
Message-Id: <1112194256.10634.35.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.407, required 12,
	autolearn=disabled, AWL 1.54, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 30.03.2005 Klokka 09:26 (-0500) skreiv Lee Revell:
> On Tue, 2005-03-29 at 18:18 -0500, Trond Myklebust wrote:
> > ty den 29.03.2005 Klokka 18:04 (-0500) skreiv Lee Revell:
> > > I am seeing long latencies in the NFS client code.  Attached is a ~1.9
> > > ms latency trace.
> > 
> > What kind of workload are you using to produce these numbers?
> > 
> 
> Here is the other long latency I am seeing in the NFS client.  I posted
> this before, but did not cc: the correct people.
> 
> It looks like nfs_wait_on_requests is doing thousands of
> radix_tree_gang_lookups while holding some lock.

That's normal and cannot be avoided: when writing, we have to look for
the existence of old nfs_page requests. The reason is that if one does
exist, we must either coalesce our new dirty area into it or if we
can't, we must flush the old request out to the server.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

