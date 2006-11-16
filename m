Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162145AbWKPBOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162145AbWKPBOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 20:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162147AbWKPBOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 20:14:12 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:26795 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1162145AbWKPBOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 20:14:10 -0500
Date: Thu, 16 Nov 2006 10:17:29 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: mbligh@mbligh.org, steiner@sgi.com, krafft@de.ibm.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] enables booting a NUMA system where some nodes have
 no memory
Message-Id: <20061116101729.41257355.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0611151653560.24565@schroedinger.engr.sgi.com>
References: <20061115193049.3457b44c@localhost>
	<20061115193437.25cdc371@localhost>
	<Pine.LNX.4.64.0611151323330.22074@schroedinger.engr.sgi.com>
	<20061115215845.GB20526@sgi.com>
	<Pine.LNX.4.64.0611151432050.23201@schroedinger.engr.sgi.com>
	<455B9825.3030403@mbligh.org>
	<Pine.LNX.4.64.0611151451450.23477@schroedinger.engr.sgi.com>
	<20061116095429.0e6109a7.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0611151653560.24565@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 16:57:56 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:
> numa_node_id() points to this and we always get allocations redirected to 
> other nodes. The slab duplicates its per node structures on the fallback 
> node.
> 
> > The zonelist[] donen't contain empty-zone.
> 
> So we will never encounter that zone except when going to the 
> pglist_data struct through numa_node_id()?
> 
Some pgdat/zone scanning code will access it.
See: for_each_zone() and populated_zone().

AFAIK, in 2.6.9 age(means RHEL4), cpus on memory-less-node are moved to the
nearest node. And there were no useless pgdat.

Now, there are memory-less-node. Cpus on memory-less-node are on a pgdat
with empty-zone. I think this is very simple way rather than remapping.
And I think cpus on memory-less-node are sharing something (FSB,switch,etc..)
Tieing cpus to a memory-less-node may have some benefit. 

-Kame

