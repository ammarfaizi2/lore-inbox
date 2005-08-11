Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbVHKBOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbVHKBOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 21:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbVHKBOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 21:14:22 -0400
Received: from pat.uio.no ([129.240.130.16]:14812 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750961AbVHKBOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 21:14:22 -0400
Subject: Re: fcntl(F_GETLEASE) semantics??
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17146.37443.505736.147373@wombat.chubb.wattle.id.au>
References: <17146.37443.505736.147373@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 21:14:08 -0400
Message-Id: <1123722848.8242.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.569, required 12,
	autolearn=disabled, AWL 2.24, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 11.08.2005 Klokka 09:48 (+1000) skreiv Peter Chubb:
> Hi,
> 	The LTP test fcntl23 is failing.  It does, in essence, 
> 	fd = open(xxx, O_RDWR|O_CREAT, 0777);
> 	if (fcntl(fd, F_SETLEASE, F_RDLCK) == -1)
> 	   fail;
> 
> fcntl always returns EAGAIN here.  The manual page says that a read
> lease causes notification when `another process' opens the file for
> writing or truncates it.  The kernel implements `any process'
> (including the current one).
> 
> Which semantics are correct?  Personally I think that what the kernel
> implements is correct (you can't get a read lease unsless there are no
> writers _at_ _all_)

A read lease should mean that there are no writers at all.

If we were to allow the current process to open for write, then that
would still mean that nobody else can get a lease. In effect you have
been granted a lease with exclusive semantics (i.e. a write lease). You
might as well request that instead of pretending it is a read lease.

Cheers,
  Trond

