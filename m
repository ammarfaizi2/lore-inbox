Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbTH1Akq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 20:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbTH1Akp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 20:40:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48902 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263552AbTH1Ako (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 20:40:44 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] initramfs + sysfs as root fix
Date: 27 Aug 2003 17:40:33 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bijj21$eco$1@cesium.transmeta.com>
References: <200308232157.53962.gkajmowi@tbaytel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200308232157.53962.gkajmowi@tbaytel.net>
By author:    Garrett Kajmowicz <gkajmowi@tbaytel.net>
In newsgroup: linux.dev.kernel
>
> This is my first real patch, so please vet thoroughly
> 
> This patch allows a person to not require mounting a root device at startup.  
> This works idealy for people trying to use the initramfs/sysfs as the only 
> filesystem.
> 
> What happens is that when the root device is set to 0,0 mount_root is not 
> called.  I have tested in VMWare extensively, and the patch is quite minimal.
> 
> +++ linux/init/do_mounts.c      2003-08-23 17:22:59.000000000 -0400
> @@ -380,6 +380,12 @@
>         if (is_floppy && rd_doload && rd_load_disk(0))
>                 ROOT_DEV = Root_RAM0;
> 
> +#ifndef CONFIG_ROOT_NFS
> +       if (MAJOR(ROOT_DEV) == UNNAMED_MAJOR && MINOR(ROOT_DEV) == 0) {
> +               goto out;
> +       }
> +#endif
> +
>         mount_root();

It seems ugly, to say the least, to conditionalize this on
CONFIG_ROOT_NFS.  If anything it should be conditionalized on no NFS
root actually configured, which is a very different thing.

(Of course, then nfsroot should be done via initramfs...)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
