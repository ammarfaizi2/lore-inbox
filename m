Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286295AbRLTQ7w>; Thu, 20 Dec 2001 11:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286294AbRLTQ7m>; Thu, 20 Dec 2001 11:59:42 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23886 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S286293AbRLTQ7Y>; Thu, 20 Dec 2001 11:59:24 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file / Making Linux multiboot capable and grub loading kernel modules at boot time.
In-Reply-To: <200112181605.KAA00820@tomcat.admin.navo.hpc.mil>
	<m18zbzwp34.fsf@frodo.biederman.org> <3C205FBC.60307@zytor.com>
	<m1zo4fursh.fsf@frodo.biederman.org>
	<9vrlef$mat$1@cesium.transmeta.com>
	<m1r8pqv1w3.fsf@frodo.biederman.org> <3C218BF3.6010603@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Dec 2001 09:39:02 -0700
In-Reply-To: <3C218BF3.6010603@zytor.com>
Message-ID: <m1n10dvobd.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> My comment was mostly that there is a persistent myth that you can't use the x86
> firmware from protected mode.  You can't, directly, but you can get the
> functionality through other means.  This is hardly a new technique; in fact,
> it's very similar to the DOS extenders of old times; in fact, it's somewhat
> simpler.

Agreed.  And to completely dispel the myth.  Etherboot has been doing
something similar for years.  It disables interrupts in 32bit mode so
it doesn't have quite as much work to do but otherwise it is pretty
much the same picture.

I finally tracked down the reason why Setup.S is run in real mode,
instead of being called from protected mode.  And that is in extremely
hostile environments (like loadlin works in) loading the kernel wrecks
the firmware callbacks.  So you must do your BIOS calls as a special
case before you switch to protected mode.

Eric
