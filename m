Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWEQPXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWEQPXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWEQPXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:23:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65188 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750707AbWEQPXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:23:14 -0400
Date: Wed, 17 May 2006 08:22:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: jsipek@fsl.cs.sunysb.edu, linux-kernel@vger.kernel.org
Subject: Re: swapper_space export
Message-Id: <20060517082252.47c75004.akpm@osdl.org>
In-Reply-To: <1147864721.3051.17.camel@laptopd505.fenrus.org>
References: <20060516232443.GA10762@filer.fsl.cs.sunysb.edu>
	<1147864721.3051.17.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> On Tue, 2006-05-16 at 19:24 -0400, Josef Sipek wrote:
> > I was trying to compile the Unionfs[1] to get it up to sync it up with
> > the kernel developments from the past few months. Anyway, long story
> > short...swapper_space (defined in mm/swap_state.c) is not exported
> > anymore (git commit: 4936967374c1ad0eb3b734f24875e2484c3786cc). This
> > apparently is not an issue for most modules. Troubles arise when the
> > modules include mm.h or any of its relatives.
> > 
> > One simply gets a linker error about swapper_space not being defined.
> > The problem is that it is used in mm.h.
> 
> 
> don't you think it's really suspect that no other filesystem, in fact no
> other driver in the kernel needs this? Could it just be that unionfs is 
> using a wrong API ? Because if that's the case you're patch is just the
> wrong thing. Maybe the unionfs people should try to submit their code
> for review etc......

They're probably just using page_mapping(), which is a reasonable thing to so.

Probably it's sufficient to use page->mapping.  It depends how they got
hold of the page.  If it's know to be in filesystem pagecache then
page->mapping will be OK.


