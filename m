Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVJKOsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVJKOsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 10:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVJKOsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 10:48:11 -0400
Received: from pat.uio.no ([129.240.130.16]:24283 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932104AbVJKOsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 10:48:10 -0400
Subject: Re: Cache invalidation bug in NFS v3 - trivially reproducible
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Leif Nixon <nixon@nsc.liu.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m33bn8bet4.fsf@nammatj.nsc.liu.se>
References: <m33bn8bet4.fsf@nammatj.nsc.liu.se>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 10:47:57 -0400
Message-Id: <1129042077.11164.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.905, required 12,
	autolearn=disabled, AWL 0.91, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 11.10.2005 Klokka 11:09 (+0200) skreiv Leif Nixon:
> Hi,
> 
> We have come across a bug where a NFS v3 client fails to invalidate
> its data cache for a file even though it realizes that the file
> attributes have changed. We have been able to recreate the bug on a
> range of kernel versions and different underlying file systems.
> 
> Here's a minimal way to reproduce the error (there seems to be some
> timing issues involved, but this has worked at least 90% of the time):
> 
>   NFS client n1                NFS client n2
> 
>   $ echo 1 > f
> 			       $ cat f
> 			       1
>   $ touch .
>   $ echo 2 > f
> 			       $ touch f
> 			       $ cat f
> 			       1
> 
> Now client n2 is stuck in a state where it uses its old cached data
> forever (or at least for several hours):

Yep. I can see a problem whereby the cache is "losing" consistency
information when you do this sort of thing. I'm working on a fix.

Cheers,
  Trond

