Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUKHVFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUKHVFW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUKHU7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 15:59:38 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:22443 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S261221AbUKHUxM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 15:53:12 -0500
Date: Mon, 8 Nov 2004 15:53:03 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
Message-ID: <20041108205303.GC13355@fieldses.org>
References: <41877751.502@wasp.net.au> <1099413424.7582.5.camel@lade.trondhjem.org> <4187E4E1.5080304@pobox.com> <20041102215126.GE6694@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041102215126.GE6694@fieldses.org>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 04:51:26PM -0500, J. Bruce Fields wrote:
> On Tue, Nov 02, 2004 at 02:49:53PM -0500, Jeff Garzik wrote:
> > I'm also seeing stale filehandle problems here in recent kernels.
> > 
> > Setup:  x86 or x86-64, TCP, NFSv4 compiled in to both server and client, 
> > but not specified in mount options.
> > 
> > This is readily reproducible with rsync -- I just boot to an earlier 
> > version of the kernel on the NFS client, and the stale filehandle 
> > problems go away.
> 
> Are any of the people seeing these problems able to reproduce them with
> the no_subtree_check export option set?

I've finally managed to reproduce it here.  It looks to me like it's
failing in nfsd_acceptable, so exporting with no_subtree_check (which
should probably be the default anyway) should eliminate the stale
filehandle errors.  Still trying to figure out why this is happening,
though.

--Bruce Fields
