Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbUJ0SEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbUJ0SEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbUJ0SCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:02:53 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:15341 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262568AbUJ0R6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:58:14 -0400
Date: Wed, 27 Oct 2004 10:57:21 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: RE: Hugepages demand paging V1 [4/4]: Numa patch
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB504BFA479@scsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.58.0410271056130.18052@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA479@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Chen, Kenneth W wrote:

> > @@ -32,14 +32,17 @@
> > +	struct zonelist *zonelist = NODE_DATA(nid)->node_zonelists;
> > +	struct zone **zones = zonelist->zones;
> > +	struct zone *z;
> > +	int i;
> > +
> > +	for(i=0; (z = zones[i])!= NULL; i++) {
> > +		nid = z->zone_pgdat->node_id;
> > +		if (list_empty(&hugepage_freelists[node_id]))
> > +			break;
> >  	}
>
> Also this is generic code, we should consider scanning ZONE_HIGHMEM
> zonelist. Otherwise, this will likely screw up x86 numa machine.

The highmem zones are included in the zones[] array AFAIK.

