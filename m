Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWHYVT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWHYVT3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 17:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWHYVT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 17:19:29 -0400
Received: from pat.uio.no ([129.240.10.4]:4997 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750801AbWHYVT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 17:19:29 -0400
Subject: Re: [PATCH 7/6] Lost bits - fix PG_writeback vs PG_private race in
	NFS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>
In-Reply-To: <1156538662.26945.21.camel@lappy>
References: <20060825153709.24254.28118.sendpatchset@twins>
	 <1156523815.16027.43.camel@taijtu>  <1156536687.5927.25.camel@localhost>
	 <1156538662.26945.21.camel@lappy>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 17:19:12 -0400
Message-Id: <1156540752.5927.66.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.215, required 12,
	autolearn=disabled, AWL 1.78, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 22:44 +0200, Peter Zijlstra wrote:
> The VM doesn't really like PG_private set on PG_swapcache pages, I guess
> I'll have to rectify that and leave the NFS behaviour as is.

You might want to consider disabling NFS data cache revalidation on swap
files since it doesn't really make sense to have other clients change
the file while you are using it.

If you do, you could also skip setting PG_private on swap pages, since
there ought to be no further races with invalidate_inode_pages2() to
deal with.

Cheers,
  Trond

