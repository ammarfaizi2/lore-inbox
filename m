Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285260AbRLFW30>; Thu, 6 Dec 2001 17:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285261AbRLFW3O>; Thu, 6 Dec 2001 17:29:14 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:558 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285260AbRLFW1L>; Thu, 6 Dec 2001 17:27:11 -0500
Date: Thu, 6 Dec 2001 17:27:08 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: lm@bitmover.com, phillips@bonn-fries.net, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206172708.B31752@redhat.com>
In-Reply-To: <20011206121004.F27589@work.bitmover.com> <20011206.121554.106436207.davem@redhat.com> <20011206122116.H27589@work.bitmover.com> <20011206.130202.107681970.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206.130202.107681970.davem@redhat.com>; from davem@redhat.com on Thu, Dec 06, 2001 at 01:02:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 01:02:02PM -0800, David S. Miller wrote:
> We've done %90 of the "other stuff" already, why waste the work?
> We've done the networking, we've done the scheduler, and the
> networking/block drivers are there too.

The scheduler doesn't scale too well...

> I was actually pretty happy with how easy (relatively) the networking
> was to thread nicely.
> 
> The point is, you have to make a captivating argument for ccClusters,
> what does it buy us now that we've done a lot of the work you are
> telling us it will save?

The most captivating arguments are along the following lines:

	- scales perfectly across NUMA fabrics: there are a number of 
	  upcoming architechures (hammer, power4, others) where the 
	  latency costs on remote memory are significantly higher.  By
	  making the entire kernel local, we'll see optimal performance 
	  for local operations, with good performance for the remote 
	  actions (the ccClusterFS should be very low overhead).
	- opens up a number of possibilities in terms of serviceability: 
	  if a chunk of the system is taken offline, only the one kernel 
	  group has to go away.  Useful in containing failures.
	- lower overhead for SMP systems.  We can use UP kernels local 
	  to each CPU.  Should make kernel compiles faster. ;-)

At the very least it is well worth investigating.  Bootstrapping the 
ccCluster work shouldn't take more than a week or so, which will let 
us attach some hard numbers to the kind of impact it has on purely 
cpu local tasks.

		-ben
-- 
Fish.
