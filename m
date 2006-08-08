Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWHHDaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWHHDaq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWHHDaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:30:46 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63370 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932138AbWHHDap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:30:45 -0400
Date: Tue, 8 Aug 2006 13:30:05 +1000
From: Nathan Scott <nathans@sgi.com>
To: Joe Jin <lkmaillist@gmail.com>, "Tony.Ho" <linux@idccenter.cn>,
       jdi@l4x.org, Chris Seufert <seufert@gmail.com>
Cc: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: XFS Bug null pointer dereference in xfs_free_ag_extent
Message-ID: <20060808133005.C2526901@wobbly.melbourne.sgi.com>
References: <44BF29CD.1000809@l4x.org> <44CB0BF7.6030204@idccenter.cn> <44CB1303.7010303@l4x.org> <20060731094424.E2280998@wobbly.melbourne.sgi.com> <44CDA156.6000105@idccenter.cn> <20060731165522.K2280998@wobbly.melbourne.sgi.com> <44CDB135.8080401@idccenter.cn> <20060731194310.A2301615@wobbly.melbourne.sgi.com> <44CDD5B9.8020608@idccenter.cn> <215036450607311849o43b1555br13ea2f3f20fb3b82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <215036450607311849o43b1555br13ea2f3f20fb3b82@mail.gmail.com>; from lkmaillist@gmail.com on Tue, Aug 01, 2006 at 09:49:12AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 09:49:12AM +0800, Joe Jin wrote:
> >From the information, I think it caused by (args.agbp == NULL).
> get rid of, we'll find the call trace should panic:
> xfs_free_extent
> |_   xfs_free_ag_extent  => here args.agbp= NULL;
>         |_ xfs_btree_init_cursor()
>               |_ agf = XFS_BUF_TO_AGF(agbp);  => (xfs_agf_t
> *)XFS_BUF_PTR(arbp)
>                              |_ (xfs_caddr_t)((agbp)->b_addr) : but here,
> agbp is NULL
> so it caused the oops.

You've all reported this same issue - could any/all of you
try the patch here...
http://oss.sgi.com/archives/xfs/2006-08/msg00054.html

Let me know if that fixes it.  In particular, if you were able
to easily reproduce this before, I'd like to hear whether this
resolves things, as I've still not hit the bug myself.

cheers.

-- 
Nathan
