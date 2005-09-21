Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVIURqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVIURqr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 13:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVIURqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 13:46:47 -0400
Received: from gold.veritas.com ([143.127.12.110]:54817 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751309AbVIURqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 13:46:46 -0400
Date: Wed, 21 Sep 2005 18:46:19 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jay Lan <jlan@engr.sgi.com>
cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <4331990A.80904@engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
 <4331990A.80904@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Sep 2005 17:46:43.0790 (UTC) FILETIME=[6E020EE0:01C5BED4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Jay Lan wrote:
> 
> It is not really an issue of out-of-tree accounting package. The
> system accounting is based on very old technology and needs improvement.
> The issue we face is not an issue of one particular accounting package.
> 
> I think the best approach would be to wrap the mm usage accounting
> in a new CONFIG_ENHANCED_SYS_ACCT and leave it OFF by default so that
> people can still get the minimal accounting with
> CONFIG_BSD_PROCESS_ACCT.

Yes, please: that sounds right.  With macros which dissolve to nothing
when it's off, to avoid #ifdef CONFIG_....s throughout the source.c.
#ifdef around the mm fields themselves?  Probably best that way.

Still need a pointer in the Kconfig to some project that uses these.

Still sceptical that hiwater_vm and hiwater_rss are the magic
missing numbers which bring system accounting into the 21st century:
more to come?

Thanks,
Hugh
