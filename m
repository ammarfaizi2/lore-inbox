Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266469AbUHYXcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266469AbUHYXcc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266466AbUHYXcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:32:31 -0400
Received: from ns2.ptt.yu ([212.62.32.5]:12510 "EHLO ns2.ptt.yu")
	by vger.kernel.org with ESMTP id S266488AbUHYXbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:31:35 -0400
Date: Thu, 26 Aug 2004 01:31:36 +0000
From: Predrag Ivanovic <predivan@ptt.yu>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Two .rej files when patching from 2.6.8.1 to 2.6.9-rc1
Message-Id: <20040826013136.72bd1906.predivan@ptt.yu>
Reply-To: predivan@ptt.yu
Organization: Random Violence
X-Mailer: Sylpheed version 0.9.12-gtk2-20040622 (GTK+ 2.4.7; i686-pc-linux-gnu)
X-Operating-System: Crux-2.0
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.

There are two .rej files when I patch 2.6.8.1 to 2.6.9-rc1
(I ran 'make mrproper' when I unpacked 2.6.8.1 tarball).
These are :
linux-2.6.9-rc1/Makefile.rej
-------------------------------------------
***************
*** 1,7 ****
  VERSION = 2
  PATCHLEVEL = 6
- SUBLEVEL = 8
- EXTRAVERSION =
  NAME=Zonked Quokka
  
  # *DOCUMENTATION*
--- 1,7 ----
  VERSION = 2
  PATCHLEVEL = 6
+ SUBLEVEL = 9
+ EXTRAVERSION = -rc1
  NAME=Zonked Quokka
  
  # *DOCUMENTATION*
-------------------------------------------
and linux-2.6.9-rc1/fs/nfs/file.c.rej.
------------------------------------------------
***************
*** 72,78 ****
  
  static int nfs_check_flags(int flags)
  {
- 	if (flags & (O_APPEND | O_DIRECT))
  		return -EINVAL;
  
  	return 0;
--- 74,80 ----
  
  static int nfs_check_flags(int flags)
  {
+ 	if ((flags & (O_APPEND | O_DIRECT)) == (O_APPEND | O_DIRECT))
  		return -EINVAL;
  
  	return 0;
***************
*** 89,95 ****
  	int res;
  
  	res = nfs_check_flags(filp->f_flags);
- 	if (!res)
  		return res;
  
  	lock_kernel();
--- 91,97 ----
  	int res;
  
  	res = nfs_check_flags(filp->f_flags);
+ 	if (res)
  		return res;
  
  	lock_kernel();
------------------------------------------------------------

HTH.
Pedja
LGOEG

-- 
 Give a man a match, and he'll be warm for a minute, but
 set him on fire, and he'll be warm for the rest of his life.
