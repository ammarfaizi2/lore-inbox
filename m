Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWDEAIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWDEAIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWDEAIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:08:02 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:30927
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750956AbWDEAH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:07:29 -0400
Date: Tue, 04 Apr 2006 17:07:20 -0700 (PDT)
Message-Id: <20060404.170720.61536177.davem@davemloft.net>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, openib-general@openib.org,
       bunk@stusta.de, jmforbes@linuxtx.org, zwane@arm.linux.org.uk,
       tytso@mit.edu, rdunlap@xenotime.net, davej@redhat.com,
       chuckw@quantumlinux.com, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, mst@mellanox.co.il, rolandd@cisco.com
Subject: Re: [patch 11/26] IPOB: Move destructor from neigh->ops to
 neigh_param
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060405000030.GL27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
	<20060404235927.GA27049@kroah.com>
	<20060405000030.GL27049@kroah.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: gregkh@suse.de
Date: Tue, 4 Apr 2006 17:00:30 -0700

> From: Michael Tsirkin <mst@mellanox.co.il>
> 
> struct neigh_ops currently has a destructor field, but not a constructor field.
> The infiniband/ulp/ipoib in-tree driver stashes some info in the neighbour
> structure (the results of the second-stage lookup from ARP results to real
> link-level path), and it uses neigh->ops->destructor to get a callback so it can
> clean up this extra info when a neighbour is freed.  We've run into problems
> with this: since the destructor is in an ops field that is shared between
> neighbours that may belong to different net devices, there's no way to set/clear
> it safely.
> 
> The following patch moves this field to neigh_parms where it can be safely set,
> together with its twin neigh_setup, and switches the only two in-kernel users
> (ipoib and clip) to this interface.

Major NAK.

This does not fix a bug, it is merely and API change that the
inifiniband folks want for some of their infrastructure.

It was accepted for 2.6.17, but this change is not appropriate
for the -stable release branch.

Furthermore, this version of the patch here will break the build of
ATM.
