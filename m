Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268888AbTBZTv3>; Wed, 26 Feb 2003 14:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268891AbTBZTv3>; Wed, 26 Feb 2003 14:51:29 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:24229 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268888AbTBZTv2>; Wed, 26 Feb 2003 14:51:28 -0500
Subject: Re: zImage now holds vmlinux, System.map and config in sections.
	(fwd)
From: Todd Inglett <tinglett@vnet.ibm.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030225175204.B21014@flint.arm.linux.org.uk>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE84C@mailse01.axis.se>
	<20030225092520.A9257@flint.arm.linux.org.uk>
	<20030225110704.GD159052@niksula.cs.hut.fi>
	<20030225113557.C9257@flint.arm.linux.org.uk>
	<20030225083811.797fbce6.rddunlap@osdl.org> 
	<20030225175204.B21014@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 26 Feb 2003 14:01:14 -0600
Message-Id: <1046289675.21297.11.camel@q.rchland.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-25 at 11:52, Russell King wrote:

> Well, rather than creating yet another archive system, maybe we should
> just tar the lot up and make all boot loaders aware of the tar format?
> After all, everyone understands tar and .debs better than RPMs, don't
> they?

I'm not sure ELF should really be considered "yet another archive
system."  This is analogous with keeping debug in another ELF section
for user apps.  You can keep it, you can strip it, etc.  Other formats
would work, but as you say you'd have to modify the bootloaders to
accept them.

These sections don't have to be thrown away after boot either.  While
the sections should be marked as no-load, it may be useful to actually
load them and have the kernel explicitly toss them if it finds no use
for them.  Real uses would including exporting to /proc/config.gz (if
you like that kind of thing), or providing the System.map to kdb if kdb
is enabled.

Note that we also supply the initial ramdisk (which is loaded of course)
this way.  In theory you could remove the ramdisk and replace it by
using objcopy, but we still have some things to fix before that will
work.  This *is* useful for people who netboot (at least for ppc64
systems).

-todd

