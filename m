Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265539AbUAGPM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 10:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbUAGPM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 10:12:59 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7028 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265539AbUAGPM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 10:12:57 -0500
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@colin2.muc.de>,
       Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
References: <20040106040546.GA77287@colin2.muc.de>
	<Pine.LNX.4.58.0401052100380.2653@home.osdl.org>
	<20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi>
	<20040106094442.GB44540@colin2.muc.de>
	<Pine.LNX.4.58.0401060726450.2653@home.osdl.org>
	<20040106153706.GA63471@colin2.muc.de>
	<m1brpgn1c3.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0401061554010.9166@home.osdl.org>
	<m13casmk28.fsf@ebiederm.dsl.xmission.com>
	<20040107093143.A29200@flint.arm.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jan 2004 08:06:04 -0700
In-Reply-To: <20040107093143.A29200@flint.arm.linux.org.uk>
Message-ID: <m1wu83lrxf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> On Tue, Jan 06, 2004 at 09:58:23PM -0700, Eric W. Biederman wrote:
> > ffff0000-ffffffff : reserved
> > 
> > That last reserved region is 64K.  Which looking at the pci registers
> > is technically correct at the moment.  Only 64K happen to be decoded.
> 
> We already have this distinction between in use (or busy) resources and
> allocated resources.  Surely the BIOS ROM region should be an allocation
> resource not a busy resource, so that the MTD driver can obtain a busy
> resource against it?

Nope the BIOS region is allocated as BUSY, at least as it comes
out of the E820 map.

>From arch/i386/kernel/setup.c:legacy_init_iomem_resources
....
		res -> start = e820.map[i].addr;
		res -> end = res->start + e820.map[i].size - 1;
		res -> flags = IORESOURCE_MEM | IORESOURCE_BUSY;
		request_resource(&iomem_resource, res);

Eric



