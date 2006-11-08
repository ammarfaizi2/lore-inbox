Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754498AbWKHJ7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498AbWKHJ7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 04:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754507AbWKHJ7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 04:59:55 -0500
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:58009 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1754498AbWKHJ7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 04:59:53 -0500
Subject: Re: [PATCH 0/1] mspec driver: compile error
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: Jes Sorensen <jes@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Robin Holt <holt@sgi.com>, Dean Nelson <dcn@sgi.com>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>,
       Tony Luck <tony.luck@gmail.com>
In-Reply-To: <20061108015618.571242fb.akpm@osdl.org>
References: <1162881017.13700.105.camel@sebastian.intellilink.co.jp>
	 <4550609A.7010908@sgi.com> <20061107133512.a49b11e0.akpm@osdl.org>
	 <1162977589.7805.77.camel@sebastian.intellilink.co.jp>
	 <4551A66A.2070506@sgi.com>
	 <1162979130.7805.80.camel@sebastian.intellilink.co.jp>
	 <20061108015618.571242fb.akpm@osdl.org>
Content-Type: text/plain; charset=utf-8
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Wed, 08 Nov 2006 18:59:51 +0900
Message-Id: <1162979991.7805.84.camel@sebastian.intellilink.co.jp>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 01:56 -0800, Andrew Morton wrote:
> On Wed, 08 Nov 2006 18:45:30 +0900
> Fernando Luis Vázquez Cao <fernando@oss.ntt.co.jp> wrote:
> 
> > On Wed, 2006-11-08 at 10:42 +0100, Jes Sorensen wrote:
> > > Fernando Luis Vázquez Cao wrote:
> > > > On Tue, 2006-11-07 at 13:35 -0800, Andrew Morton wrote:
> > > > The problem occurs because i386 (as expected) does not define
> > > > IA64_UNCACHED_ALLOCATOR. I thought that making the select expression
> > > > depend on IA64 as shown below might silence allmodconfig:
> > > > 
> > > >   select IA64_UNCACHED_ALLOCATOR if IA64
> > > > 
> > > > But my guess was wrong and the same warning appeared. It seems that "if"
> > > > expressions do not prevent allmodconfig from checking the symbol
> > > > indicated by the select the "if" is conditioning. By the way, is this
> > > > the expected behaviour? If so, we need to get rid of the reverse
> > > > dependency, modify the "depends on" line accordingly, and make
> > > > IA64_UNCACHED_ALLOCATOR selectable. I may be missing the whole point so
> > > > please correct if I am wrong.
> > > 
> > > This patch is a bad solution as it requires people to manually select
> > > the uncached allocator. It should be enabled automatically by MSPEC,
> > > not the other way round.
> > > 
> > > Given that MSPEC is clearly marked as depending on IA64, it seems bogus
> > > for i386 allmodconfig to barf over it and the problem should be fixed
> > > there instead IMHO.
> > Agreed. That is why I asked if that was allmodconfig's expected
> > behaviour. Andrew?
> > 
> 
> kconfig's `select' isn't very smart.  This is one of the reasons why one
> should avoid using it.
Is my previous patch an acceptable workaround then? Or should we take a
different approach in such cases?

