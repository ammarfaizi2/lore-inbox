Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWGRQAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWGRQAP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 12:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWGRQAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 12:00:15 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:21413 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751097AbWGRQAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 12:00:13 -0400
Date: Wed, 19 Jul 2006 00:59:53 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, mbligh@mbligh.org, a.p.zijlstra@chello.nl,
       linux-mm@kvack.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: inactive-clean list
Message-Id: <20060719005953.5e34f4f1.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0607180742580.31065@schroedinger.engr.sgi.com>
References: <1153167857.31891.78.camel@lappy>
	<Pine.LNX.4.64.0607172035140.28956@schroedinger.engr.sgi.com>
	<1153224998.2041.15.camel@lappy>
	<Pine.LNX.4.64.0607180557440.30245@schroedinger.engr.sgi.com>
	<44BCE86A.4030602@mbligh.org>
	<Pine.LNX.4.64.0607180659310.30887@schroedinger.engr.sgi.com>
	<20060718072545.7cfed5b2.akpm@osdl.org>
	<Pine.LNX.4.64.0607180742580.31065@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2006 07:45:21 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Tue, 18 Jul 2006, Andrew Morton wrote:
> 
> > Christoph Lameter <clameter@sgi.com> wrote:
> > > What other types of non freeable pages could exist?
> > 
> > PageWriteback() pages (potentially all of memory)
> 
> Doesnt write throttling take care of that?
> 
> > Pinned pages (various transient conditions, mainly get_user_pages())
> 
> Hmm....
>  
> > Some pages whose buffers are attached to an ext3 journal.
> 
> These are just pinned by an increased refcount right?
>  
> > Possibly NFS unstable pages.
> 
> These are tracked by NR_NFS_UNSTABLE.
> 
> Maybe we need a NR_UNSTABLE that includes pinned pages?
> 

I'm not sure what was discussed in VM summit. If I miss the point, sorry.

I think the important thing here is the amount of free pages we try to keep.
Remaining unused pages as page cache(and not free them) may help performance if lucky
but increases uncertainity.
 

Now, enlarging min_free_kbytes or mempool is useful to avoid page allocation failure 
in device drivers, which does write-back of dirty pages.
I think controlling free memory itself is better than controlling *used* inactive clean
pages.

Bye
-Kame


