Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbUJ0U6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbUJ0U6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbUJ0U5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:57:55 -0400
Received: from fmr03.intel.com ([143.183.121.5]:1440 "EHLO hermes.sc.intel.com")
	by vger.kernel.org with ESMTP id S262707AbUJ0Uxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:53:50 -0400
Message-Id: <200410272050.i9RKoSq03358@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>
Cc: "William Lee Irwin III" <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Hugepages demand paging V1 [4/4]: Numa patch
Date: Wed, 27 Oct 2004 13:53:16 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcS8UKehm1Y6ErCaRRCPwsrXSmhpPgAFLPVQ
In-Reply-To: <Pine.LNX.4.58.0410271056130.18052@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
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

Christoph Lameter wrote on Wednesday, October 27, 2004 10:57 AM
> The highmem zones are included in the zones[] array AFAIK.


node_zonelists is an array in the struct pglist_data.  In your patch,
you are referencing the first element in that array, which has a zone
list for all node memory in normal zone.

What will happen for a x86 numa box with highmem only on some nodes?

- Ken


