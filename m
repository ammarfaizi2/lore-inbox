Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319005AbSIDCMR>; Tue, 3 Sep 2002 22:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319007AbSIDCMR>; Tue, 3 Sep 2002 22:12:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36618 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319005AbSIDCMQ>; Tue, 3 Sep 2002 22:12:16 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4.18 --> 2.4.19. Ramdisk requires floppy?
Date: 3 Sep 2002 19:16:38 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <al3qe6$lvl$1@cesium.transmeta.com>
References: <20020903165133.GA8726@southpole.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020903165133.GA8726@southpole.se>
By author:    jakob@southpole.se (Jakob Sandgren)
In newsgroup: linux.dev.kernel
>
> Hi,
> 
> I've noticed that the 2.4.19 version of "prepare_namespace"
> (init/do_mounts.c) not allows you to mount a non floppy as a
> ramdisk(?). This has changed since 2.4.18 (split of main.c ->
> {do_mounts,main}.c).
> 
> 2.4.18 does a very simple check (below):
> 
> --- 2.4.18 ---
> #ifdef CONFIG_BLK_DEV_RAM
> #ifdef CONFIG_BLK_DEV_INITRD
>         if (mount_initrd)
>                 initrd_load();
>         else
> #endif
>         rd_load();
> #endif
> --- 2.4.18 ---
> 
> however, in 2.4.19 it just tries to load a ramdisk if it's on a
> floppy. Why? There may still be a ramdisk on an other device, NOT
> using initrd. 
> 

You can't search every device hunting for a ramdisk.  rd_load() is
ancient cruft that should be nuked, and will be pushed into userspace
as part of the initramfs/early userspace work.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
