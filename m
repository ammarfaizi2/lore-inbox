Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315753AbSEDASX>; Fri, 3 May 2002 20:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315754AbSEDAST>; Fri, 3 May 2002 20:18:19 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:12275
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S315753AbSEDASQ>; Fri, 3 May 2002 20:18:16 -0400
Message-ID: <3CD328C5.2C6D389A@eyal.emu.id.au>
Date: Sat, 04 May 2002 10:18:13 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa1 & vm-34: zftape-init.c compile error
In-Reply-To: <20020503203738.E1396@dualathlon.random>
Content-Type: multipart/mixed;
 boundary="------------462F16E97E6D87740EF2DCF8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------462F16E97E6D87740EF2DCF8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrea Arcangeli wrote:
> 
> Full patchkit:
> http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa1.gz

linux-2.4-pre-aa/drivers/char/ftape/zftape/zftape-init.c fails to build,
a declaration is put in an illegal place.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------462F16E97E6D87740EF2DCF8
Content-Type: text/plain; charset=us-ascii;
 name="2.4.19-pre8-aa1-zftape-init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.19-pre8-aa1-zftape-init.patch"

*** linux-2.4-pre-aa/drivers/char/ftape/zftape/zftape-init.c.orig	Sat May  4 10:13:57 2002
--- linux-2.4-pre-aa/drivers/char/ftape/zftape/zftape-init.c	Sat May  4 10:14:28 2002
***************
*** 204,214 ****
  	sigfillset(&current->blocked);
  	lock_kernel();
  	if ((result = ftape_mmap(vma)) >= 0) {
- 		vma->vm_flags &= ~VM_IO;
  #ifndef MSYNC_BUG_WAS_FIXED
  		static struct vm_operations_struct dummy = { NULL, };
  		vma->vm_ops = &dummy;
  #endif
  	}
  	unlock_kernel();
  	current->blocked = old_sigmask; /* restore mask */
--- 204,214 ----
  	sigfillset(&current->blocked);
  	lock_kernel();
  	if ((result = ftape_mmap(vma)) >= 0) {
  #ifndef MSYNC_BUG_WAS_FIXED
  		static struct vm_operations_struct dummy = { NULL, };
  		vma->vm_ops = &dummy;
  #endif
+ 		vma->vm_flags &= ~VM_IO;
  	}
  	unlock_kernel();
  	current->blocked = old_sigmask; /* restore mask */

--------------462F16E97E6D87740EF2DCF8--

