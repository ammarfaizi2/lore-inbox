Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbVCPFX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbVCPFX5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 00:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbVCPFX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 00:23:57 -0500
Received: from fire.osdl.org ([65.172.181.4]:29129 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262520AbVCPFXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 00:23:55 -0500
Date: Tue, 15 Mar 2005 21:23:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace zone padding with a definition in cache.h
Message-Id: <20050315212337.5484f2a0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503152103580.6087@server.graphe.net>
References: <Pine.LNX.4.58.0503152010190.5134@server.graphe.net>
	<20050315202331.008ec856.akpm@osdl.org>
	<Pine.LNX.4.58.0503152103580.6087@server.graphe.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <christoph@lameter.com> wrote:
>
> On Tue, 15 Mar 2005, Andrew Morton wrote:
> 
> > Christoph Lameter <christoph@lameter.com> wrote:
> > >
> > >  +#ifndef ____cacheline_pad_in_smp
> > >  +#if defined(CONFIG_SMP)
> > >  +#define ____cacheline_pad_in_smp struct { char  x; } ____cacheline_maxaligned_in_smp
> > >  +#else
> > >  +#define ____cacheline_pad_in_smp
> > >  +#endif
> > >  +#endif
> >
> > That's going to spit a warning with older gcc's.  "warning: unnamed
> > struct/union that defines no instances".
> >
> Is it really that important?

Well, it makes gcc-2.95.x unusable, and a number of people like to use it.

It has not proven too burdensome to support.  And we know that if it works
on 2.95.x, it will work on 3.1, 3.2, 3.3, etc.

> If the struct is named then there may be
> conflicts if its used repeatedly.

Hence the "hack" which you just deleted ;)
