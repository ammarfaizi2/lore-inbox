Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262360AbVDXSnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbVDXSnF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 14:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVDXSnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 14:43:05 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:57019 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262360AbVDXSm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 14:42:59 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: akpm@osdl.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
Subject: [patch 0/7] uml: some invasive changes for -mm
Date: Sun, 24 Apr 2005 20:39:55 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504242039.57025.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first of a series of 7 invasive patches for the -mm tree, which 
are to be reviewed (not only by UML folks), and possibly merged for the 
2.6.13 cycle.

The first one splits the i386 syscall table out of entry.S, without any real 
change for them (the file is included in the old place); if there are any 
syscall table changes, please be careful; this maybe means place *this* one 
before the others (or even merge now the i386 code movement part); I don't 
want that this patch is modified and that subtle bugs are introduced. The 
code movement is a really trivial code movement, however (no hidden changes).

This is needed to enable us to include the i386 syscall table, so that we are 
sure that they match. I already handled the real differences between i386 and 
UML (see the patch).

uml-fix-syscall-table-i386.patch
  uml: fix syscall table by including $(SUBARCH)'s one, for i386

uml-quick-fix-syscall-table-x86_64.patch
  uml: quick fix syscall table for x86_64

uml-fix-syscall-table-rem-for-x86-64.patch
  uml: fix syscall table by including $(SUBARCH)'s one, for x86-64

uml-console-redo-locking.patch
  uml: redo console locking
[ It's invasive, but seems to work well; wide testing is needed ]

uml-hostfs-avoid-buffers.patch
  uml - hostfs: avoid buffers
[ This is something which should work, even because you said that; I've 
partially verified this myself ]

uml-commentary-about-forking-flag.patch
  uml: commentary about forking flag
[ Jeff, give a look and possibly correct it. ]

uml-ubd-handle-readonly.patch
  uml ubd: handle readonly status
[ I cc'ed Jens Axboe ]

They are not to be confused with the previous series of 6 patches I also sent 
today, which are mostly little or already tested patches (list below); the 
explicitly marked one are urgent for 2.6.12, while for the other just take 
your choice (they should be trivial and have been tested):

[LIST of patches TO MERGE]:
uml-workaround-sed-behaviour.patch
  uml: workaround old problematic sed behaviour [compile-fix, for 2.6.12]

uml-nfsd-syscall.patch
  uml: add nfsd syscall when nfsd is modular [for 2.6.12]

uml-crypto-i586.patch
  uml: support AES i586 crypto driver [for 2.6.12]

uml-Makefile-avoid-rebuild.patch
  uml kbuild: avoid useless rebuilds [for 2.6.13]

uml-inline-empty.patch
  uml: inline empty proc

uml-move-va-copy-conditional.patch
  uml: move va_copy conditional def

Thanks a lot for the attention and regards.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

