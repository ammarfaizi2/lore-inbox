Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVC3UBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVC3UBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVC3T5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:57:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:16316 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262428AbVC3T47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:56:59 -0500
Date: Wed, 30 Mar 2005 11:56:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: rlrevell@joe-job.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: NFS client latencies
Message-Id: <20050330115640.0bc38d01.akpm@osdl.org>
In-Reply-To: <1112194256.10634.35.camel@lade.trondhjem.org>
References: <1112137487.5386.33.camel@mindpipe>
	<1112138283.11346.2.camel@lade.trondhjem.org>
	<1112192778.17365.2.camel@mindpipe>
	<1112194256.10634.35.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> on den 30.03.2005 Klokka 09:26 (-0500) skreiv Lee Revell:
> > On Tue, 2005-03-29 at 18:18 -0500, Trond Myklebust wrote:
> > > ty den 29.03.2005 Klokka 18:04 (-0500) skreiv Lee Revell:
> > > > I am seeing long latencies in the NFS client code.  Attached is a ~1.9
> > > > ms latency trace.
> > > 
> > > What kind of workload are you using to produce these numbers?
> > > 
> > 
> > Here is the other long latency I am seeing in the NFS client.  I posted
> > this before, but did not cc: the correct people.
> > 
> > It looks like nfs_wait_on_requests is doing thousands of
> > radix_tree_gang_lookups while holding some lock.
> 
> That's normal and cannot be avoided: when writing, we have to look for
> the existence of old nfs_page requests. The reason is that if one does
> exist, we must either coalesce our new dirty area into it or if we
> can't, we must flush the old request out to the server.

One could use the radix-tree tagging stuff so that the gang lookup only
looks up pages which are !NFS_WBACK_BUSY.
