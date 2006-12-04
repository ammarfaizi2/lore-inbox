Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757669AbWLDRMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757669AbWLDRMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 12:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759494AbWLDRMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 12:12:41 -0500
Received: from mail.kolumbus.fi ([193.229.0.46]:45201 "EHLO mail.kolumbus.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757669AbWLDRMk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 12:12:40 -0500
From: Janne Karhunen <Janne.Karhunen@gmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: Mounting NFS root FS
Date: Mon, 4 Dec 2006 19:12:29 +0200
User-Agent: KMail/1.9.5
Cc: MrUmunhum@popdial.com, linux-kernel@vger.kernel.org
References: <4571CE06.4040800@popdial.com> <24c1515f0612040351p6056101frc12db8eb86063213@mail.gmail.com> <1165246177.711.179.camel@lade.trondhjem.org>
In-Reply-To: <1165246177.711.179.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612041912.30527.Janne.Karhunen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 December 2006 17:29, Trond Myklebust wrote:

> > >   I have been trying to make FC5's kernel do a boot
> > > with an NFS root file system.  I see the support is in the
> > > kernel(?).
> >
> > Is this really properly possible (with read/write access and
> > locking in place)? AFAIK NFS client lock state data seems
> > to require persistent storage .. ?
>
> 1) Yes, but not on the root partition (unless you use an initrd to start
> rpc.statd before mounting the NFS partition).

Ok. 


> 2) NFS provides persistent storage.

To me this sounds like a chicken and an egg problem. It 
both depends and provides this at the same time :/. But 
hey, if it's supposed to work then OK.

Anyhoo, I tried this at some stage and failed as random
clients seemed to occasionally get stuck in insmod¹ at
boot (infinite wait on lock that never gets released). 
At that stage guess was that server could not properly 
recognize client reboot given stale client lock data.
But if it's supposed to work I guess I have to give it 
another shot and do better analysis on it.

What about NLM/NSM protocol issues - do they properly 
deal with packet loss and clients that stay down (client 
holding a lock crashing and staying down; will the lock 
ever be released)?

¹ And why does insmod require a lock on module at load??


-- 
// Janne
