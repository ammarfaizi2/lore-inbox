Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263272AbVCEBGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbVCEBGc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 20:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbVCEA6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:58:48 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:4566 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261511AbVCEAwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:52:04 -0500
Subject: Re: [PATCH] 2.6.11-mm1 "nobh" support for ext3 writeback mode
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050304164553.29811e8f.akpm@osdl.org>
References: <1109980952.7236.39.camel@dyn318077bld.beaverton.ibm.com>
	 <20050304162331.4a7dfdb8.akpm@osdl.org>
	 <1109982557.7236.65.camel@dyn318077bld.beaverton.ibm.com>
	 <20050304164553.29811e8f.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1109983752.7236.69.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Mar 2005 16:49:13 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 16:45, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > > What's all this doing?  (It needs comments please - it's very unobvious).
> > 
> > All its trying to do is - to make sure the page is uptodate so that
> > it can zero out the portion thats needed. 
> 
> OK.
> 
> > I can do getblock() and ll_rw_block(READ) instead. I was
> > trying to re-use the code and mpage_readpage() drops the lock.
> > What do you think ?
> 
> Can you just call ->prepare_write, as nobh_truncate_page() does?  That'll
> cause a nested transaction, but that's legal.
> 

Thats what I tried earlier, but never got it working. Lots of journal
asserts :( 

I guess I really need to learn journaling code someday.

Thanks,
Badari

