Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262631AbTCTVbq>; Thu, 20 Mar 2003 16:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262635AbTCTVbq>; Thu, 20 Mar 2003 16:31:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61202 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262631AbTCTVbp>; Thu, 20 Mar 2003 16:31:45 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Larger dev_t and major/minor split
Date: 20 Mar 2003 13:42:41 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b5dckh$lv1$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since Linus opened for this the other day I guess I would like to
suggest it "officially":

Since glibc already runs with a 64-bit dev_t on as far as I know all
Linux platforms, which means that userspace is already taking the
performance hit, *and* since it cause it isn't murdeously obvious by
now, changing the kernel/userspace interface for this is painful as
hell, I would like to suggest that:

a) We use a 32+32 bit split for dev_t.  Major zero, minor < 65536
   would be reserved for compatibility with the old 16-bit dev_t; it
   still leaves the zero value the "no device" entry.  We could still
   use major 0, minor >= 65536 as anonymous devices, or we could
   switch using major 255 which has been reserved for expansion for
   the past eight years.
   
b) In order to support NFSv2 and other filesystems which only support
   a 32-bit dev_t, I suggest we stay within a (12,20)-bit range for as
   long as that is practical.  Note, however, that this only affect
   using those filesystems for /dev, and I personally think it's not
   too huge of a loss to say "well, if you use NFS for root, either
   use NFSv3 or make /dev a tmpfs and extract a tarball from your
   initrd."

   All cases where we have to deal with a 32-bit dev_t on the wire or
   on disk should use a 12+20 split.

How does this sound?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
