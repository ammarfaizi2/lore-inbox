Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUG1Qd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUG1Qd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 12:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUG1QcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 12:32:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46226 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267304AbUG1Q1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 12:27:51 -0400
Date: Wed, 28 Jul 2004 12:27:03 -0400
From: Alan Cox <alan@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: fix some 32bit isms
Message-ID: <20040728162703.GB4074@devserv.devel.redhat.com>
References: <20040728135941.GA17409@devserv.devel.redhat.com> <20040728092334.74e0cfcd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728092334.74e0cfcd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 09:23:34AM -0700, Andrew Morton wrote:
> Alan Cox <alan@redhat.com> wrote:
> >
> >  		printk(MYIOC_s_ERR_FMT 
> >   		     "Invalid IOC facts reply, msgLength=%d offsetof=%d!\n",
> >  -		     ioc->name, facts->MsgLength, (offsetof(IOCFactsReply_t,
> >  +		     ioc->name, facts->MsgLength, (int)(offsetof(IOCFactsReply_t,
> 
> printk expects %zd for a size_t

So I've now learned. I've been a bit out of touch with the 2.5/2.6 printk
evolution

> Some architectures will emit a warning here, and will perhaps print the
> wrong thing.  We need to print size_t's with %zd.  I'll fix that up.

Thanks

