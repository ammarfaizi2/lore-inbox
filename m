Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbVKIDXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbVKIDXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 22:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbVKIDXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 22:23:35 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:22728 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030423AbVKIDXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 22:23:34 -0500
Date: Tue, 8 Nov 2005 19:23:12 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, Mike Kravetz <kravetz@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       torvalds@osdl.org, Hirokazu Takahashi <taka@valinux.co.jp>,
       Andi Kleen <ak@suse.de>, Magnus Damm <magnus.damm@gmail.com>,
       Paul Jackson <pj@sgi.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH 5/8] Direct Migration V2: upgrade MPOL_MF_MOVE and
 sys_migrate_pages()
In-Reply-To: <43715266.5080900@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.62.0511081922260.582@schroedinger.engr.sgi.com>
References: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
 <20051108210402.31330.19167.sendpatchset@schroedinger.engr.sgi.com>
 <43715266.5080900@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, KAMEZAWA Hiroyuki wrote:

> Christoph Lameter wrote:
> > +	err = migrate_pages(pagelist, &newlist, &moved, &failed);
> > +
> > +	putback_lru_pages(&moved);	/* Call release pages instead ?? */
> > +
> > +	if (err >= 0 && list_empty(&newlist) && !list_empty(pagelist))
> > +		goto redo;
> 
> 
> Here, list_empty(&newlist) is needed ?
> For checking permanent failure case, list_empty(&failed) looks better.

We only allocate 256 pages which are on the newlist. If the newlist is 
empty but there are still pages that could be migrated 
(!list_empty(pagelist)) then we need to allocate more pages and call 
migrate_pages() again.

