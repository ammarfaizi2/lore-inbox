Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWDEANd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWDEANd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWDEANc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:13:32 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:62091
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750954AbWDEANc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:13:32 -0400
Date: Tue, 4 Apr 2006 17:12:26 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: gregkh@suse.de, torvalds@osdl.org, tytso@mit.edu, zwane@arm.linux.org.uk,
       jmforbes@linuxtx.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, bunk@stusta.de, rdunlap@xenotime.net,
       mst@mellanox.co.il, davej@redhat.com, rolandd@cisco.com,
       chuckw@quantumlinux.com, stable@kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] Re: [patch 11/26] IPOB: Move destructor from neigh->ops to neigh_param
Message-ID: <20060405001226.GA29002@kroah.com>
References: <20060404235634.696852000@quad.kroah.org> <20060404235927.GA27049@kroah.com> <20060405000030.GL27049@kroah.com> <20060404.170720.61536177.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404.170720.61536177.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 05:07:20PM -0700, David S. Miller wrote:
> From: gregkh@suse.de
> Date: Tue, 4 Apr 2006 17:00:30 -0700
> 
> > From: Michael Tsirkin <mst@mellanox.co.il>
> > 
> > struct neigh_ops currently has a destructor field, but not a constructor field.
> > The infiniband/ulp/ipoib in-tree driver stashes some info in the neighbour
> > structure (the results of the second-stage lookup from ARP results to real
> > link-level path), and it uses neigh->ops->destructor to get a callback so it can
> > clean up this extra info when a neighbour is freed.  We've run into problems
> > with this: since the destructor is in an ops field that is shared between
> > neighbours that may belong to different net devices, there's no way to set/clear
> > it safely.
> > 
> > The following patch moves this field to neigh_parms where it can be safely set,
> > together with its twin neigh_setup, and switches the only two in-kernel users
> > (ipoib and clip) to this interface.
> 
> Major NAK.
> 
> This does not fix a bug, it is merely and API change that the
> inifiniband folks want for some of their infrastructure.
> 
> It was accepted for 2.6.17, but this change is not appropriate
> for the -stable release branch.
> 
> Furthermore, this version of the patch here will break the build of
> ATM.

Thanks for the information and the review, I've dropped this patch from
the queue now.

greg k-h
