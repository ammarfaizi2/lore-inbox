Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbVCEA5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbVCEA5B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbVCEAx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:53:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:13769 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263485AbVCEAqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:46:05 -0500
Date: Fri, 4 Mar 2005 16:45:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.11-mm1 "nobh" support for ext3 writeback mode
Message-Id: <20050304164553.29811e8f.akpm@osdl.org>
In-Reply-To: <1109982557.7236.65.camel@dyn318077bld.beaverton.ibm.com>
References: <1109980952.7236.39.camel@dyn318077bld.beaverton.ibm.com>
	<20050304162331.4a7dfdb8.akpm@osdl.org>
	<1109982557.7236.65.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> > What's all this doing?  (It needs comments please - it's very unobvious).
> 
> All its trying to do is - to make sure the page is uptodate so that
> it can zero out the portion thats needed. 

OK.

> I can do getblock() and ll_rw_block(READ) instead. I was
> trying to re-use the code and mpage_readpage() drops the lock.
> What do you think ?

Can you just call ->prepare_write, as nobh_truncate_page() does?  That'll
cause a nested transaction, but that's legal.
