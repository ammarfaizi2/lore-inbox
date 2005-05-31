Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVEaTaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVEaTaT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVEaTaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:30:14 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:48209 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261259AbVEaT3g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:29:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ftVFOq9c3jsjiOQGHZEWsAknNy8XOwHNnItaN1Nev+33miLo2wzc4sC95UULyKPXqs6Tn6TrBlhWmwNJgVC50woh/+nQRkT0YxFRjQsI605MslOaIF/XfwU5xD0SwzMxc10LRTyXgKN73pA+731VNfrmmnhlTV1j3MJ03z/V/Uw=
Message-ID: <934f64a205053112295ee49ffd@mail.gmail.com>
Date: Tue, 31 May 2005 14:29:34 -0500
From: David Nicol <davidnicol@gmail.com>
Reply-To: David Nicol <davidnicol@gmail.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Common Cluster Infrastructure discussion
Cc: Robert Wipfel <rawipfel@novell.com>, phillips@redhat.com,
       linux-ha@lists.linux-ha.org, linux-cluster@redhat.com,
       linux-fsdevel@vger.kernel.org, dcl_discussion@lists.osdl.org,
       cgl_discussion@lists.osdl.org, linux-kernel@vger.kernel.org,
       ssic-linux-devel@lists.sourceforge.net, clusters_sig@lists.osdl.org
In-Reply-To: <20050531102624.GT17565@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <s28eff68.098@sinclair.provo.novell.com>
	 <20050531102624.GT17565@marowsky-bree.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/05, Lars Marowsky-Bree <lmb@suse.de> wrote:
> On 2005-05-21T09:29:01, Robert Wipfel <rawipfel@novell.com> wrote:
> 
> > outside looking in, is web services and grid.  Returning to the
> > reality of many vendor's enterprise* business, the sweet spot for h/a
> > clusters still seems to be somewhere around ~8 dual-CPU nodes with
> > many customers deploying multiple similar clusters. Nodes are never in
> > multiple clusters at once, rather, individual nodes are members of a
> > cluster and that cluster might be a member of a cluster of clusters.

To restate the proposal, in response to this distinction, that "Nodes
are never in
 multiple clusters at once, rather, individual nodes are members of a
 cluster and that cluster might be a member of a cluster of clusters", in the
language of the CCI proposal, one or more nodes in a subcluster would join
the larger cluster, but not all of them, and these liaison nodes would
handle the
communications between this subcluster and other subclusters.  using
CCI, different
subclusters in this grid could run different clustering frameworks, or might be
lone boxes in the supercluster that aren't actually representing clusters.

To implement a cluster being a member of a cluster of clusters with the same
interface that is used to manage a node being a member of a cluster, that is the
idea.  

I take away from LMB's remark a requirement that the CCI must support in-cluster
selection/election for a presented service, so that the liaison nodes,
which could be
all nodes, or could be a subset of all nodes, in the subcluster, 
could present themselves
as a coherent authority to the other members of the supercluster, over
the channels
defined by the supercluster, representing a single node identifier in
the supercluster.

We want in-cluster communications to be through the CCI rather than through an
implementation detail (such as tcp/ip) because we do not want to
confuse communications
by associating node identification with any artifact, such as IP
address, which could
be broken by an architecture change, or even by a failover.

> A single node must be big enough to support sane load balancing; ie, big
> enough to run at least one (or more) "whole" resource entities / jobs.

OTOH, the grain size of a "whole job" can be tuned to fit the reality
of your hardware.

Hopefully the CCI will provide useful metrics about node capability
and current load
to allow apples-to-apples comparisons for making better load balancing decisions
in heterogenous clusters.



> "Ignorance more frequently begets confidence than does knowledge"

very good - I know it does for me!

David L Nicol
Proudly ignorant of many and much
