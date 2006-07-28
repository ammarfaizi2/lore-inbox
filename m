Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161289AbWG1UwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161289AbWG1UwE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161297AbWG1UwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:52:04 -0400
Received: from mail.fieldses.org ([66.93.2.214]:6864 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S1161289AbWG1UwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:52:02 -0400
Date: Fri, 28 Jul 2006 16:51:56 -0400
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] knfsd: Fix stale file handle problem with subtree_checking.
Message-ID: <20060728205156.GB12183@fieldses.org>
References: <20060728194103.7245.patches@notabene> <1060728094255.7278@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060728094255.7278@suse.de>
User-Agent: Mutt/1.5.12-2006-07-14
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 07:42:55PM +1000, NeilBrown wrote:
> The following patch fixes a bug that was introduced since 2.6.17,
> and should go in 2.6.18.
> 
> ### Comments for Changeset
> 
> A recent patch:
> 
>   h=7fc90ec93a5eb71f4b08403baf5ba7176b3ec6b1
> 
> moved the call to nfsd_setuser out of the 'find a dentry for a
> filehandle' branch of fh_verify so that it would always be called.
> 
> This had the unfortunately side-effect of moving *after* the call
> to decode_fh, so the prober fsuid was not set when nfsd_acceptable
> was called, the 'permission' check did the wrong thing.

Argh, sorry, thanks for the fix.

It'd be great if we could deprecate subtree checking some day in the
distant future....

Would it be feasible to add filesystem support for some sort of
subvolume-like thing that acted like a mountpoint (in the sense that it
restricted hardlinks and renames) but that didn't require setting aside
a separate partition?  I imagine that'd probably do what most people
exporting subtrees want without forcing us to do dubious tricks with
filehandles.

--b.
