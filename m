Return-Path: <linux-kernel-owner+w=401wt.eu-S1762594AbWLKAkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762594AbWLKAkl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 19:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762595AbWLKAkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 19:40:41 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:40887 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762594AbWLKAkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 19:40:40 -0500
Date: Mon, 11 Dec 2006 09:43:06 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: "Bob Picco" <bob.picco@hp.com>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org,
       akpm@osdl.org
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [0/4] introduction
Message-Id: <20061211094306.522df229.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061210194730.GA10629@localhost>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com>
	<20061210194730.GA10629@localhost>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006 14:47:30 -0500
"Bob Picco" <bob.picco@hp.com> wrote:
> > Intro:
> > When using SPARSEMEM, pfn_to_page()/page_to_pfn() accesses global big table
> > of mem_section. if SPARSEMEM_EXTREME, this is 2-level table lookup.
> Did you gather any performance numbers comparing
> VIRTUAL_MEM_MAP+SPARSEMEM to SPARSEMEM+EXTREME? I did some quick but
> inconclusive (small machine) ones when you first posted. There was
> perhaps a slight degradation in VIRTUAL_MEM_MAP+SPARSEMEM.
> 
No, I didn't. I'll do when I have a chance to do it. I hope that this won't
be merged until someone shows the benefit by data.
(I think this verion is better than the first one but..)

IIRC, DISCONTIGMEM + VIRTUAL_MEM_MAP shows a bit better performance than
SPARSEMEM_EXTREME. What I expect is to archive VIRTUAL_MEM_MAP performance
with SPARSEMEM.

Now, we still have chance to optimization.
- optimize pfn_valid. (I'll post this. mem_section[] will be never accessed
  in runtime by this.)
- use large-sized-page (no concrete idea, maybe to modify map/unmap func
  will work enough.)

Thanks,
-Kame

