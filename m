Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVJLQhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVJLQhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 12:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbVJLQhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 12:37:16 -0400
Received: from pat.uio.no ([129.240.130.16]:1956 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751358AbVJLQhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 12:37:14 -0400
Subject: Re: blocking file lock functions (lockf,flock,fcntl) do not return
	after timer signal
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Alex Riesen <raa.lkml@gmail.com>
Cc: boi@boi.at, linux-kernel@vger.kernel.org
In-Reply-To: <81b0412b0510120810o6d06a678q1d4a9787687b9bfa@mail.gmail.com>
References: <434CC144.6000504@boi.at>
	 <81b0412b0510120548k3464d355ne75cce4e5edcce1a@mail.gmail.com>
	 <1129127947.8561.44.camel@lade.trondhjem.org>
	 <81b0412b0510120810o6d06a678q1d4a9787687b9bfa@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 12:36:47 -0400
Message-Id: <1129135007.8434.19.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.715, required 12,
	autolearn=disabled, AWL 1.28, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 12.10.2005 Klokka 17:10 (+0200) skreiv Alex Riesen:

> > Desktop$ ./gnurr gnarg
> > locking...
> > timeout
> > timeout
> > timeout
> > timeout
> > timeout
> 
> Doesn't look so. I'd expect "flock: EWOULDBLOCK" and "sleeping" after
> the first timeout.

I would rather expect flock to return with ERESTARTSYS and then for libc
to restart the syscall once the signal handler has finished executing.
A stint with the "strace" utility will show you that this is precisely
what happens.

As Dick and others already pointed out to you, the POSIX function
sigaction() allows you to disable the automatic restarting of the
syscall.

Cheers,
  Trond

