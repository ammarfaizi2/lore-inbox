Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317276AbSHGUc1>; Wed, 7 Aug 2002 16:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317347AbSHGUc1>; Wed, 7 Aug 2002 16:32:27 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:42492 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317276AbSHGUcZ>; Wed, 7 Aug 2002 16:32:25 -0400
Subject: RE: O_SYNC option doesn't work (2.4.18-3)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
Cc: "'trond.myklebust@fys.uio.no'" <trond.myklebust@fys.uio.no>,
       "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
In-Reply-To: <EE83E551E08D1D43AD52D50B9F511092E114E3@ntserver2>
References: <EE83E551E08D1D43AD52D50B9F511092E114E3@ntserver2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 22:55:30 +0100
Message-Id: <1028757330.26935.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 20:24, Gregory Giguashvili wrote:
> I understand that locking file flushes NFS cache, isn't it? Why can't it be
> flushed by O_SYNC and "sync" options presence? This would make the life much
> easier for programmers...
> 
> This means that we will never be able to drop lockd locking and at the same
> time achieve file consistency via NFS?

Welcome to NFS. You basically need file locking (lockf/posix - flock is
not portably applicable to NFS) and you may need to turn off attribute
caching to make O_APPEND work portably.

Its a pain, but NFS has no other way to infer your transaction
constraints. You need to lock for read and for write on all clients, a
client reading without locking may get stale data.

Personally I use my own little daemons to manage transactional data,
ones that understand my transaction rules

