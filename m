Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422898AbWHYUpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422898AbWHYUpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422899AbWHYUpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:45:09 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:25087 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1422898AbWHYUpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:45:07 -0400
Subject: Re: [PATCH 7/6] Lost bits - fix PG_writeback vs PG_private race in
	NFS
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>
In-Reply-To: <1156536687.5927.25.camel@localhost>
References: <20060825153709.24254.28118.sendpatchset@twins>
	 <1156523815.16027.43.camel@taijtu>  <1156536687.5927.25.camel@localhost>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 22:44:21 +0200
Message-Id: <1156538662.26945.21.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 16:11 -0400, Trond Myklebust wrote:
> On Fri, 2006-08-25 at 18:36 +0200, Peter Zijlstra wrote:
> > Make sure we clear PG_writeback after we clear PG_private, otherwise
> > weird and wonderfull stuff will happen.
> > 
> NACK.
> 
> Look carefully at the case of unstable writes: your patch does nothing
> to guarantee that PG_writeback is cleared after PG_private for that
> case.

Ah, right. Thanks for pointing this out.

> Anyhow, you don't explain exactly what is wrong with clearing
> PG_writeback before PG_private.

Yes, this was a rather hasty patch, I was mortified to find that I
missed a few changes and my patch-set would crash instantly someone
would try it.

The VM doesn't really like PG_private set on PG_swapcache pages, I guess
I'll have to rectify that and leave the NFS behaviour as is.

Will correct this in the next round.

Thanks for the feedback,

Peter

