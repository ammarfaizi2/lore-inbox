Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265281AbSJaRS6>; Thu, 31 Oct 2002 12:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265282AbSJaRS6>; Thu, 31 Oct 2002 12:18:58 -0500
Received: from ns.suse.de ([213.95.15.193]:35598 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265281AbSJaRS4>;
	Thu, 31 Oct 2002 12:18:56 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: What's left over.
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com.suse.lists.linux.kernel> <20021031030143.401DA2C150@lists.samba.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 31 Oct 2002 18:25:21 +0100
In-Reply-To: Rusty Russell's message of "31 Oct 2002 04:02:44 +0100"
Message-ID: <p73hef2sepq.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:


> > > statfs64
> > 
> > I haven't even seen it.
> 
> It's fairly old, but Peter Chubb said there was some vendor interest
> for v. large devices.  Peter?

statfs64 is needed when you want to access large NFS servers (>2TB is 
becomming quite common for NAS) and want to have working "df" for them.

Currently it is scaled by wsize==blocksize, so it only breaks when
fileserversize/wsize > 2^31. For 1KB wsize it breaks with 2TB, with
4KB with 8TB etc. While 1KB wsize is arguably stupid (but happens sometimes
in practice). 8TB is not an unrealistic size for an NFS server these 
days.

I did an hack to scale the NFS block size in stat to make sure it fits
into 31bit, but statfs64 would be the correct solution for it really.

Also I would like to propose the nanosecond stat patches. It doesn't add
new system calls, but just uses spare fields in the existing stat64 
structure and closes a hole in make.

-Andi
