Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbULJDIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbULJDIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 22:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbULJDIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 22:08:44 -0500
Received: from relay.axxeo.de ([213.239.199.237]:11671 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261616AbULJDIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 22:08:41 -0500
From: Ingo Oeser <ioe@axxeo.de>
Reply-To: linux-kernel@vger.kernel.org
Organization: Axxeo GmbH
To: dhowells@redhat.com
Subject: Re: [PATCH 4/5] NOMMU: Make POSIX shmem work on ramfs-backed files
Date: Fri, 10 Dec 2004 04:08:33 +0100
User-Agent: KMail/1.6.2
References: <3e47b0ba-49f4-11d9-9df1-0002b3163499@redhat.com> <200412091508.iB9F8wja027564@warthog.cambridge.redhat.com>
In-Reply-To: <200412091508.iB9F8wja027564@warthog.cambridge.redhat.com>
Cc: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200412100408.33482.ioe@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You wrote:
> diff -uNrp linux-2.6.10-rc2-mm3-mmcleanup/fs/ramfs/Makefile
> linux-2.6.10-rc2-mm3-shmem/fs/ramfs/Makefile ---
> linux-2.6.10-rc2-mm3-mmcleanup/fs/ramfs/Makefile 2004-06-18
> 13:41:28.000000000 +0100 +++
> linux-2.6.10-rc2-mm3-shmem/fs/ramfs/Makefile 2004-11-26 15:36:07.000000000
> +0000 @@ -4,4 +4,10 @@
>
>  obj-$(CONFIG_RAMFS) += ramfs.o
>
> -ramfs-objs := inode.o
> +ifeq ($(CONFIG_MMU),y)
> +ramfs-objs := file-mmu.o
> +else
> +ramfs-objs := file-nommu.o
> +endif
> +
> +ramfs-objs += inode.o

What about this pattern instead:

file-mmu-y := file-mmu.o
file-mmu-n := file-nommu.o
file-mmu- := file-nommu.o
ramfs-objs += file-mmu-$(CONFIG_MMU)


Requires more work while writing it, but removes the ifeq, 
which should be avoided in makefiles as hell
-- 
Ingo Oeser
axxeo GmbH
Tiestestr. 16, 30171 Hannover
Tel. +49-511-4753706
Fax. +49-511-4753716

mailto:support@axxeo.de

