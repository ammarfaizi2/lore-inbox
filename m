Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbSJUNBr>; Mon, 21 Oct 2002 09:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbSJUNBr>; Mon, 21 Oct 2002 09:01:47 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:37776 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id <S261360AbSJUNBq>;
	Mon, 21 Oct 2002 09:01:46 -0400
Date: Mon, 21 Oct 2002 15:07:35 +0200
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Compilation error in the afs/dir.c
Message-ID: <20021021130735.GA24719@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo lkml,

I have problem with compilation of fs/afs/dir.c:

  gcc -Wp,-MD,fs/afs/.dir.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DMODULE -include include/linux/modversions.h   -DKBUILD_BASENAME=dir
-c -o fs/afs/dir.o fs/afs/dir.c
fs/afs/dir.c:75: warning: unnamed struct/union that defines no instances
fs/afs/dir.c: In function `afs_dir_iterate_block':
fs/afs/dir.c:261: union has no member named `name'
fs/afs/dir.c:293: union has no member named `name'
fs/afs/dir.c:296: union has no member named `vnode'
fs/afs/dir.c:296: union has no member named `vnode'
fs/afs/dir.c:296: union has no member named `vnode'
fs/afs/dir.c:297: union has no member named `unique'

Problem is here:

typedef union afs_dirent {
        struct {
                u8      valid;
                u8      unused[1];
                u16     hash_next;
                u32     vnode;
                u32     unique;
                u8      name[16];
                u8      overflow[4];    /* if any char of the name (inc
NUL) reaches here, consume
                                         * the next dirent too */
        };
        u8      extended_name[32];
} afs_dirent_t;

but I don't know, if I can change this typedef to:

typedef struct afs_dirent {
                u8      valid;
                u8      unused[1];
                u16     hash_next;
                u32     vnode;
                u32     unique;
                u8      name[16];
                u8      overflow[4];    /* if any char of the name (inc
NUL) reaches here, consume
                                         * the next dirent too */
} afs_dirent_t;

(extended_name is not used in whole dir.c...)

But is here any better way?

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
