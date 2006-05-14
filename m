Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWENLor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWENLor (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 07:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWENLor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 07:44:47 -0400
Received: from mx2.mail.ru ([194.67.23.122]:53620 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751397AbWENLoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 07:44:46 -0400
Date: Sun, 14 May 2006 15:47:51 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] ufs: ufs_trunc_indirect: infinite cycle
Message-ID: <20060514114751.GA6215@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20060514081807.GA9802@rain.homenetwork> <20060514024752.2d666443.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060514024752.2d666443.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 02:47:52AM -0700, Andrew Morton wrote:
> Evgeniy Dushistov <dushistov@mail.ru> wrote:
> >
> > The situation the same: in ufs_trunc_(not direct),
> >  we read block,
> >  check if count of links to it is equal to one, 
> >  if so we finish cycle, if not continue.
> >  Because of "count of links" always >=2 this operation cause 
> >  infinite cycle and hang up the kernel.
> 
> okay, but do we know what that code which you removed was actually intended
> to do?
> 
I suppose it wait untill all range of buffers, which used by 
"inode" will be freed. "vmtruncate" should care about
this.

> Do you know whether 2.4 kernels exhibit the same bug?  
I suppose 2.4 doesn't affected, because of "sb_get_hash_table"
(analog of sb_find_get_block in 2.6) use "get_bh" only once,
so b_count equal to 1 if nobody used it.


-- 
/Evgeniy

