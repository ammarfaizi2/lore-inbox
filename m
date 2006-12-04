Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936916AbWLDSVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936916AbWLDSVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 13:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937229AbWLDSVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 13:21:43 -0500
Received: from pat.uio.no ([129.240.10.15]:42664 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936916AbWLDSVn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 13:21:43 -0500
Subject: Re: Mounting NFS root FS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Janne Karhunen <Janne.Karhunen@gmail.com>
Cc: MrUmunhum@popdial.com, linux-kernel@vger.kernel.org
In-Reply-To: <200612041912.30527.Janne.Karhunen@gmail.com>
References: <4571CE06.4040800@popdial.com>
	 <24c1515f0612040351p6056101frc12db8eb86063213@mail.gmail.com>
	 <1165246177.711.179.camel@lade.trondhjem.org>
	 <200612041912.30527.Janne.Karhunen@gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 04 Dec 2006 13:21:30 -0500
Message-Id: <1165256490.711.233.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.317, required 12,
	autolearn=disabled, AWL 1.55, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 19:12 +0200, Janne Karhunen wrote:
> > 2) NFS provides persistent storage.
> 
> To me this sounds like a chicken and an egg problem. It 
> both depends and provides this at the same time :/. But 
> hey, if it's supposed to work then OK.

??? Locking depends on persistent storage, but persistent storage never
depended on locking. Neither rpc.statd nor lockd, nor the nfs client
depend on locking working a priori.

> Anyhoo, I tried this at some stage and failed as random
> clients seemed to occasionally get stuck in insmod¹ at
> boot (infinite wait on lock that never gets released). 
> At that stage guess was that server could not properly 
> recognize client reboot given stale client lock data.
> But if it's supposed to work I guess I have to give it 
> another shot and do better analysis on it.
> 
> What about NLM/NSM protocol issues - do they properly 
> deal with packet loss and clients that stay down (client 
> holding a lock crashing and staying down; will the lock 
> ever be released)?

1) Packet loss is dealt with by retrying ad-infinitum.

2) No. The problem of client crashes was fixed in NFSv4 with the
addition of lease-based locks.

> ¹ And why does insmod require a lock on module at load??

Does it? I've no idea why it should need that.

Trond

