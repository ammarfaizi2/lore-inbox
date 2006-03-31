Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWCaTkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWCaTkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 14:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWCaTkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 14:40:47 -0500
Received: from pat.uio.no ([129.240.10.6]:11156 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932109AbWCaTkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 14:40:45 -0500
Subject: Re: [PATCH 2/4] locks: don't unnecessarily fail posix lock
	operations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <E1FPPFC-0005mL-00@dorka.pomaz.szeredi.hu>
References: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu>
	 <E1FPNSB-0005VK-00@dorka.pomaz.szeredi.hu>
	 <1143829641.8085.7.camel@lade.trondhjem.org>
	 <E1FPPFC-0005mL-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 14:40:22 -0500
Message-Id: <1143834022.8116.1.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.297, required 12,
	autolearn=disabled, AWL 1.52, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-31 at 21:25 +0200, Miklos Szeredi wrote:
> > NACK.
> > 
> > This changes the behaviour of F_UNLCK. Currently, if the allocation
> > fails, the inode locking state remains unchanged. With your change, an
> > unlock request may end up unlocking part of the inode, but not the rest.
> 
> No, look more closer.  There are two cases:
> 
>   - some locks are partially or completely removed
> 
>   - the unlock splits an existing lock in two.
> 
> In the first case no new locks are needed.  In the second, no locks
> are modified prior to the check.

Consider something like

fcntl(SETLK, 0, 100)
fcntl(SETLK, 0, 100)
fcntl(SETLK, 0, 100)


