Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261871AbTCTUNw>; Thu, 20 Mar 2003 15:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261876AbTCTUNw>; Thu, 20 Mar 2003 15:13:52 -0500
Received: from ns.suse.de ([213.95.15.193]:52241 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261871AbTCTUNv>;
	Thu, 20 Mar 2003 15:13:51 -0500
Subject: Re: share COMPATIBLE_IOCTL()s across architectures
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
In-Reply-To: <20030320193212.GA312@elf.ucw.cz>
References: <20030319232157.GA13415@elf.ucw.cz>
	<20030319.160130.112180221.davem@redhat.com> 
	<20030320193212.GA312@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Mar 2003 21:24:49 +0100
Message-Id: <1048191889.15338.189.camel@averell>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-20 at 20:32, Pavel Machek wrote:
> Hi!
> 
> >    This patche moves common COMPATIBLE_IOCTLs to
> >    include/linux/compat_ioctl.h, enabling pretty nice cleanups:
> > 
> > Please be careful.  For anything non-trivial there can be major
> > differences between compat layers.
> 
> I'm trying to be carefull. How common are ioctls that are
> COMPATIBLE_IOCTL(foo) on one arch, but not on another? So far I tried
> to decide, and mostly decided that one architecture was simply
> missing...

The only issue I'm aware of are structures with long long. IA64 and
x86-64 are special in that long long has a different alignmnet in 32bit
and 64bit (4 bytes in 32bit, 8 bytes in 64bit). All the other archs with
compat code have always 8 byte alignment. This means if sparc64 doesn't
do a conversion, but x86-64 does you cannot put it into the COMPAT_IOCTL
list. Make sure you only use the common set.

Fortunately long long is not that common and many uses of it are already
8 byte aligned, but not all are.

-Andi



