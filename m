Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVKQRH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVKQRH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVKQRHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:07:55 -0500
Received: from pat.uio.no ([129.240.130.16]:22990 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932396AbVKQRHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:07:55 -0500
Subject: Re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: cel@citi.umich.edu
Cc: Kenny Simpson <theonetruekenny@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <437CB78E.5010707@citi.umich.edu>
References: <20051116223937.28115.qmail@web34112.mail.mud.yahoo.com>
	 <1132182378.8811.93.camel@lade.trondhjem.org>
	 <437CB78E.5010707@citi.umich.edu>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 12:07:35 -0500
Message-Id: <1132247255.8028.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.947, required 12,
	autolearn=disabled, AWL 1.87, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-17 at 12:02 -0500, Chuck Lever wrote:
> Trond Myklebust wrote:
> > I had a quick look at nfs_file_direct_write(), and among other things,
> > it would appear that it is not doing any of the usual overflow checks on
> > *pos and the count size (see generic_write_checks()). In particular,
> > checks are missing against overflow vs. MAX_NON_LFS if O_LARGEFILE is
> > not set (and also against overflow vs. s_maxbytes, but that is less
> > relevant here).
> 
> the architecture is to allow the NFS protocol and server to do these checks.

No it isn't.

The NFS protocol has no clue as to whether or not you opened the file
using O_LARGEFILE. For NFSv2, we do _not_ want file pointers to wrap
once they hit the 32-bit boundary.

The protocol and server cannot be involved in any of those checks. They
must be done on the client.

Cheers,
  Trond

