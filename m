Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbVJXVB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVJXVB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 17:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVJXVB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 17:01:59 -0400
Received: from mtaout1.012.net.il ([84.95.2.1]:38099 "EHLO mtaout1.012.net.il")
	by vger.kernel.org with ESMTP id S1751293AbVJXVB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 17:01:58 -0400
Date: Mon, 24 Oct 2005 23:00:47 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [TRIVIAL] Error checks omitted in init_tmpfs() in mm/tiny-shmem.c
In-reply-to: <20051024204518.GI26160@waste.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Hareesh Nagarajan <hnagar2@gmail.com>, linux-kernel@vger.kernel.org,
       ak@suse.de
Message-id: <20051024210047.GG17764@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <435C7149.3010004@gmail.com> <20051024070921.GW26160@waste.org>
 <435CA1CF.3070204@gmail.com> <20051024204518.GI26160@waste.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 01:45:18PM -0700, Matt Mackall wrote:

> > --- linux-2.6.13.4/mm/tiny-shmem.c	2005-10-10 13:54:29.000000000 -0500
> > +++ linux-2.6.13.4-edit/mm/tiny-shmem.c	2005-10-24 03:43:38.614071000 -0500
> > @@ -31,12 +31,18 @@
> >  
> >  static int __init init_tmpfs(void)
> >  {
> > -	register_filesystem(&tmpfs_fs_type);
> > +	int error;
> > +
> > +	error = register_filesystem(&tmpfs_fs_type);
> > +	BUG_ON(error);
> 
> Can we just do BUG_ON(register_filesystem() != 0)?

It seems a little risky to me to rely on a macro always evaluating its
arguments, even though this one does on every kernel version I
checked.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

