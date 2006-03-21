Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWCULSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWCULSN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWCULSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:18:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54210 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751383AbWCULSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:18:11 -0500
Date: Tue, 21 Mar 2006 03:14:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Luke Yang" <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2]Blackfin archtecture patche for 2.6.16
Message-Id: <20060321031457.69fa0892.akpm@osdl.org>
In-Reply-To: <489ecd0c0603200200va747a68k187651930a3f0a51@mail.gmail.com>
References: <489ecd0c0603200200va747a68k187651930a3f0a51@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luke Yang" <luke.adi@gmail.com> wrote:
>
>    This is the Blackfin archtecture patch for kernel 2.6.16.
>

There are few practical issues we need to be concerned about with new
architectures.

- We don't want to be putting 44000 lines of new code in the kernel and
  then have it rot.  Who will support this in the long-term?  What
  resources are behind it?  IOW: what can you say to convince us that it
  won't rot?

  The lack of a MAINTAINERS entry doesn't inspire confidence..

- How widespread/popular is the blackfin?  Are many devices using it? 
  How old/mature is it?  Is it a new thing or is it near end-of-life?

  It's a cost/benefit thing.  It costs us to add code to the kenrel.  How
  many people would benefit from us doing that?

- Are easy-to-install x86 cross-build packages available?  If not, are
  there straightforward instructions anywhere to guide people in generating
  a cross-build setup?

  <looks>

  OK, blackfin.uclinux.org seems to have that.  Does binutils support
  blackfin?

- A lot of this code appears to come from Analog Devices, but you don't ;)
  We'd need to see some sort of authorisation from the original authors
  for the inclusion of their code.  Preferably in the form of
  Signed-off-by:s.  

>  http://blackfin.uclinux.org/frs/download.php/810/blackfin-arch.patch.tar.bz2

As I said, 44kloc ;)

- Do you really need to support old_mmap()?

- It would be preferable to use the generic IRQ infrastructure in kernel/irq/

- Too much use of open-coded `volatile'.  The objective should be to have
  zero occurrences in .c files.  And volatile sometimes creates suspicion
  even when it's used in .h files.

- bug: coreb_ioctl() does copy_from_user() and down() inside spinlock.

- err, coreb_ioctl() does down(&file->f_dentry->d_inode->i_sem); but
  that's a mutex now, so I assume that's actually dead code?


