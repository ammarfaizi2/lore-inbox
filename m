Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130491AbRBQA3d>; Fri, 16 Feb 2001 19:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130170AbRBQA3X>; Fri, 16 Feb 2001 19:29:23 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:33546 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130491AbRBQA3E>;
	Fri, 16 Feb 2001 19:29:04 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Tom Rini <trini@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_MODVERSIONS and same named files 
In-Reply-To: Your message of "Fri, 16 Feb 2001 08:19:28 PDT."
             <20010216081928.A2209@opus.bloom.county> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Feb 2001 11:28:56 +1100
Message-ID: <11429.982369736@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2001 08:19:28 -0700, 
Tom Rini <trini@kernel.crashing.org> wrote:
>Hey all.  The modversions code has a slight problem with files of the same
>name, but in different directories.  eg: drivers/a/foo.c exports FOO, and
>drivers/b/foo.c exports BAR, include/linux/modules/foo.ver will only have the
>information about drivers/b/foo.c.  Anyone got an idea on how to fix this?

Files that export symbols must have unique names.  Which is why we have
abominations like this.

fs/msdos/msdosfs_syms.c
fs/proc/procfs_syms.c
fs/fat/fatfs_syms.c
fs/vfat/vfatfs_syms.c
fs/lockd/lockd_syms.c
kernel/ksyms.c
net/netsyms.c
net/sunrpc/sunrpc_syms.c
net/irda/irsyms.c

Module symbol versions is being completely redesigned for 2.5 and will
not have this problem.  In the meantime create a unique filename for
anything that exports symbols.

