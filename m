Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269042AbUIHJRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269042AbUIHJRs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269046AbUIHJR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:17:29 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:56839 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269042AbUIHJRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:17:12 -0400
Date: Wed, 8 Sep 2004 10:17:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: linux-kernel@vger.kernel.org, Jay Lan <jlan@engr.sgi.com>
Subject: Re: [patch 2.6.8.1] BSD accounting: update chars transferred value
Message-ID: <20040908101704.A29949@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
	linux-kernel@vger.kernel.org, Jay Lan <jlan@engr.sgi.com>
References: <20040908090657.GA9879@frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040908090657.GA9879@frec.bull.fr>; from guillaume.thouvenin@bull.net on Wed, Sep 08, 2004 at 11:06:57AM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 11:06:57AM +0200, Guillaume Thouvenin wrote:
> Hello,
> 
>   The goal of this patch is to improve BSD accounting by using what 
> is done in the CSA into BSD accounting. The final goal is to have a
> uniform accounting structure. 
> 
>   This patch updates information given by BSD accounting concerning
> bytes read and written. A field is already present in the BSD accounting
> structure but it is never updated. We don't add information about blocks
> read and written because, as it was discussed in previous email, the 
> information is inaccurate. Most writes which are flushed delayed would 
> get accounted to pdflushd. Thus, one solution to get this kind of 
> information is to add counters when the write back is performed. The 
> problem is that we don't know how to get information about the IID at 
> the page level (ie from struct page). So we remove this information for 
> the moment and it will be provided in another patch.
> 
> Changelog:
>   
>   - Adds two counters in the task_struct (rchar, wchar)
>   - Init fields during the creation of the process (during the fork)
>   - File I/O operations are done through sys_read(), sys_write(), 
>     sys_readv(), sys_writev() and sys_sendfile(). Thus we increment 
>     counters into those functions except with sys_sendfile(). For the
>     latter, the incrementation is done in the do_sendfile() because this
>     routine be directly called from the return of sys_sendfile().

I think it should be done in vfs_readv/vfs_write.  Else we'll miss the
updates from inekrnel consumers like nfsd.

