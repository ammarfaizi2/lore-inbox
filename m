Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWFJEw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWFJEw7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 00:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWFJEw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 00:52:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47824 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030266AbWFJEw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 00:52:58 -0400
Date: Fri, 9 Jun 2006 21:52:46 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hugh@veritas.com,
       npiggin@suse.de, linux-mm@kvack.org, ak@suse.de
Subject: Re: zoned VM stats: Add NR_ANON
In-Reply-To: <20060610133207.df05aa29.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0606092149220.4820@schroedinger.engr.sgi.com>
References: <20060608230239.25121.83503.sendpatchset@schroedinger.engr.sgi.com>
 <20060608230305.25121.97821.sendpatchset@schroedinger.engr.sgi.com>
 <20060608210056.9b2f3f13.akpm@osdl.org> <Pine.LNX.4.64.0606091152490.916@schroedinger.engr.sgi.com>
 <20060610133207.df05aa29.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006, KAMEZAWA Hiroyuki wrote:

> Can this accounting catch  page migration ?  TBD ?
> Now all coutners are counted per zone, migration should be cared.

Page migration removes the reverse mapping for the old page and installs 
the mappings to the new page later. This means that the counters are taken 
care of.

try_to_unmap_one removes the mapping and decrements the zone counter.

remove_migration_pte adds the mapping to the new page and increments the 
relevant zone counter.

