Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSIWTLG>; Mon, 23 Sep 2002 15:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261337AbSIWTKF>; Mon, 23 Sep 2002 15:10:05 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261335AbSIWSlp>;
	Mon, 23 Sep 2002 14:41:45 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15759.16948.319035.270576@laputa.namesys.com>
Date: Mon, 23 Sep 2002 20:32:52 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: locking rules for ->dirty_inode()
In-Reply-To: <3D8BA407.E2BFF7E8@digeo.com>
References: <15755.14336.739277.700462@laputa.namesys.com>
	<3D8BA407.E2BFF7E8@digeo.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
Emacs: because extension languages should come with the editor built in.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nikita Danilov wrote:
 > > 
 > > Hello,
 > > 
 > > Documentation/filesystems/Locking states that all super operations may
 > > block, but __set_page_dirty_buffers() calls
 > > 
 > >    __mark_inode_dirty()->s_op->dirty_inode()
 > > 
 > > under mapping->private_lock spin lock.
 > 
 > Actually it doesn't.  We do not call down into the filesystem
 > for I_DIRTY_PAGES.
 > 
 > set_page_dirty() is already called under locks, via __free_pte (pagetable
 > teardown).  2.4 does this as well.

Cannot find __free_pte, it is only mentioned in comments in mm/filemap.c
and include/asm-generic/tlb.h.

 > 
 > But I'll make the change anyway.  I think it removes any
 > ranking requirements between mapping->page_lock and 
 > mapping->private_lock, which is always a nice thing.

Nikita.
