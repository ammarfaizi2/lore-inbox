Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262213AbSJOA7M>; Mon, 14 Oct 2002 20:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSJOA7M>; Mon, 14 Oct 2002 20:59:12 -0400
Received: from holomorphy.com ([66.224.33.161]:54418 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262213AbSJOA7L>;
	Mon, 14 Oct 2002 20:59:11 -0400
Date: Mon, 14 Oct 2002 17:58:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
Message-ID: <20021015005810.GL4488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Dobson <colpatch@us.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	LSE <lse-tech@lists.sourceforge.net>,
	Andrew Morton <akpm@zip.com.au>,
	Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <3DAB6385.9000207@us.ibm.com> <2005946728.1034617377@[10.10.2.3]> <3DAB669B.3000801@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAB669B.3000801@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 05:51:39PM -0700, Matthew Dobson wrote:
> Well, since each node's memory (or memblk in the parlance of my head ;) 
> has several 'zones' in it (DMA, HIGHMEM, etc), this conversion function 
> will need 2 parameters.  It may well be called 
> __node_and_zone_type_to_flat_zone_number(node, DMA|NORMAL|HIGHMEM).
> Or, we could have:
> __zone_to_node(5) = node #
> and
> __zone_to_zone_type(5) = DMA|NORMAL|HIGHMEM.
> But either way, we would need to specify both pieces.
> Cheers!
> -Matt

Zone "type" can be found in (page->flags >> ZONE_SHIFT) & 0x3UL and
similarly node ID can be found in page_zone(page)->zone_pgdat->node_id
and these are from the page.

zone->zone_pgdat->node_id does the zone to node conversion
zone - zone_pgdat->node_zones does the zone to zone type conversion.

Node and zone type to flat zone number would be
	NODE_DATA(nid)->node_zones[type]

Basically there's a number written in page->flags that should be easy
to decode if you can go on arithmetic alone, and if you need details,
there's a zone_table[] you can get at the zones (and hence pgdats) with.


Bill
