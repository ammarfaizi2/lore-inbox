Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVC3Txl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVC3Txl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 14:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVC3TwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 14:52:12 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:32708 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262418AbVC3Tui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 14:50:38 -0500
Subject: Re: NFS client latencies
From: Lee Revell <rlrevell@joe-job.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1112194256.10634.35.camel@lade.trondhjem.org>
References: <1112137487.5386.33.camel@mindpipe>
	 <1112138283.11346.2.camel@lade.trondhjem.org>
	 <1112192778.17365.2.camel@mindpipe>
	 <1112194256.10634.35.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 14:50:34 -0500
Message-Id: <1112212234.17365.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 09:50 -0500, Trond Myklebust wrote:
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

But holding a spinlock for 3ms is not acceptable.  _Something_ has to be
done.  Can't the lock be dropped and reacquired after processing N
requests where N is some reasonable number?

Lee

