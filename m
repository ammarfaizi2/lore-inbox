Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVJXVKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVJXVKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 17:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVJXVKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 17:10:42 -0400
Received: from waste.org ([216.27.176.166]:38587 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751294AbVJXVKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 17:10:41 -0400
Date: Mon, 24 Oct 2005 14:08:54 -0700
From: Matt Mackall <mpm@selenic.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Hareesh Nagarajan <hnagar2@gmail.com>, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [TRIVIAL] Error checks omitted in init_tmpfs() in mm/tiny-shmem.c
Message-ID: <20051024210854.GK26160@waste.org>
References: <435C7149.3010004@gmail.com> <20051024070921.GW26160@waste.org> <435CA1CF.3070204@gmail.com> <20051024204518.GI26160@waste.org> <20051024210047.GG17764@granada.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024210047.GG17764@granada.merseine.nu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 11:00:47PM +0200, Muli Ben-Yehuda wrote:
> On Mon, Oct 24, 2005 at 01:45:18PM -0700, Matt Mackall wrote:
> 
> > > --- linux-2.6.13.4/mm/tiny-shmem.c	2005-10-10 13:54:29.000000000 -0500
> > > +++ linux-2.6.13.4-edit/mm/tiny-shmem.c	2005-10-24 03:43:38.614071000 -0500
> > > @@ -31,12 +31,18 @@
> > >  
> > >  static int __init init_tmpfs(void)
> > >  {
> > > -	register_filesystem(&tmpfs_fs_type);
> > > +	int error;
> > > +
> > > +	error = register_filesystem(&tmpfs_fs_type);
> > > +	BUG_ON(error);
> > 
> > Can we just do BUG_ON(register_filesystem() != 0)?
> 
> It seems a little risky to me to rely on a macro always evaluating its
> arguments, even though this one does on every kernel version I
> checked.

You must have missed my patch on 1 April that allows turning off all
kernel bugs. It makes sure the arguments are still evaluated.

-- 
Mathematics is the supreme nostalgia of our time.
