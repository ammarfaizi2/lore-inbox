Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVH2QPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVH2QPg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbVH2QPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:15:36 -0400
Received: from pat.uio.no ([129.240.130.16]:56992 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751259AbVH2QPf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:15:35 -0400
Subject: Re: syscall: sys_promote
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: qiyong <qiyong@fc-cn.com>, linux-kernel@vger.kernel.org, dhommel@gmail.com
In-Reply-To: <1125318568.23946.15.camel@localhost.localdomain>
References: <20050826092537.GA3416@localhost.localdomain>
	 <20050826110226.GA5184@localhost.localdomain>
	 <1125069558.4958.83.camel@localhost.localdomain>
	 <4312870E.9000708@fc-cn.com>
	 <1125318568.23946.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Aug 2005 09:15:09 -0700
Message-Id: <1125332109.8789.35.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.246, required 12,
	autolearn=disabled, AWL 1.75, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 29.08.2005 Klokka 13:29 (+0100) skreiv Alan Cox:
> You can ignore the patch easily enough. Ignoring the locking doesn't
> work because functionality like fork process counting, exec, and setuid
> all make definite assumptions that are not safe to tamper without unless
> you fix the uid locking.
> 
> Fixing it might be useful in some obscure cases anyway - POSIX threads
> might benefit from it too, providing the functionality of changing all
> thread uids at once isnt triggered for sensible threaded app behaviour.

The latter needs more than just locking fixes. Right now we have some
potentially _very_ interesting behaviour due to the fact that large
swathes of kernel code assume that a thread's privileges will not change
while it is inside a syscall.
This was something I started to try to address with the BSD credential
patches a couple of years ago, but I never managed to finish those in
time for 2.6.0.

Cheers,
  Trond

