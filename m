Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWEQTNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWEQTNX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 15:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWEQTNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 15:13:23 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:35051 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750992AbWEQTNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 15:13:23 -0400
Date: Wed, 17 May 2006 15:12:12 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Hugh Dickins <hugh@veritas.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: swapper_space export
Message-ID: <20060517191212.GA23038@filer.fsl.cs.sunysb.edu>
References: <20060516232443.GA10762@filer.fsl.cs.sunysb.edu> <1147864721.3051.17.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0605171626460.6711@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605171626460.6711@blonde.wat.veritas.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 04:52:36PM +0100, Hugh Dickins wrote:
> On Wed, 17 May 2006, Arjan van de Ven wrote:
> > On Tue, 2006-05-16 at 19:24 -0400, Josef Sipek wrote:
> > > I was trying to compile the Unionfs[1] to get it up to sync it up with
> > > the kernel developments from the past few months. Anyway, long story
> > > short...swapper_space (defined in mm/swap_state.c) is not exported
> > > anymore (git commit: 4936967374c1ad0eb3b734f24875e2484c3786cc). This
> > > apparently is not an issue for most modules. Troubles arise when the
> > > modules include mm.h or any of its relatives.
> > > 
> > > One simply gets a linker error about swapper_space not being defined.
> > > The problem is that it is used in mm.h.
> > 
> > don't you think it's really suspect that no other filesystem, in fact no
> > other driver in the kernel needs this? Could it just be that unionfs is 
> > using a wrong API ? Because if that's the case you're patch is just the
> > wrong thing. Maybe the unionfs people should try to submit their code
> > for review etc......
>
> I see no reference to page_mapping() in the unionfs source (and at
> present there's no other justifiable modular use of swapper_space);
> but my guess would be that Jeff is being more conscientious than is
> called for in getting it to sync up with the kernel -

That's what happens when one is trying to get ready to send the code to
linux-kernel & fs-devel :)

> The unionfs source does contain its own inline "sync_page" which
> comments that it "is copied verbatim from mm/filemap.c".  I'm
> guessing Jeff has noticed that it's no longer a verbatim copy,
> has made it so, and is thereby involving page_mapping().

Good guess, exactly what happened.

> Just use page->mapping as before.

Thanks for the advice.

> (But I notice that unionfs better not have a tmpfs in its union:
> the unionfs use of grab_cache_page is not strictly compatible with
> the way tmpfs pages are swapped out under memory pressure.)

We have some tmpfs nastiness reported in the bugzilla - I guess this is
a good starting point - thanks!

Thanks all,
Josef "Jeff" Sipek.
