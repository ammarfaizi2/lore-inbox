Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWBWU2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWBWU2d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 15:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWBWU2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 15:28:32 -0500
Received: from mipsfw.mips-uk.com ([194.74.144.146]:53009 "EHLO
	bacchus.dhis.org") by vger.kernel.org with ESMTP id S932107AbWBWU2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 15:28:32 -0500
Date: Thu, 23 Feb 2006 20:26:55 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] flags parameter for linkat
Message-ID: <20060223202655.GA24243@linux-mips.org>
References: <200602231410.k1NEAMk1021578@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602231410.k1NEAMk1021578@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 09:10:22AM -0500, Ulrich Drepper wrote:

> I'm currently at the POSIX meeting and one thing covered was the
> incompatibility of Linux's link() with the POSIX definition.  The
> difference is the treatment of symbolic links in the destination
> name.  Linux does not follow symlinks, POSIX requires it does.
> 
> Even somebody thinks this is a good default behavior we cannot
> change this because it would break the ABI.  But the fact remains
> that some application might want this behavior.
> 
> We have one chance to help implementing this without breaking the
> behavior.  For this we could use the new linkat interface which
> would need a new flags parameter.  If the new parameter is
> AT_SYMLINK_FOLLOW the new behavior could be invoked.
> 
> I do not want to introduce such a patch now.  But we could add the
> parameter now, just don't use it.  The patch below would do this.
> Can we get this late patch applied before the release more or less
> fixes the syscall API?

The number of arguments changes, so below patch would be needed for
32-bit MIPS.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
index d83e033..2f2dc54 100644
--- a/arch/mips/kernel/scall32-o32.S
+++ b/arch/mips/kernel/scall32-o32.S
@@ -626,7 +626,7 @@ einval:	li	v0, -EINVAL
 	sys	sys_fstatat64		4
 	sys	sys_unlinkat		3
 	sys	sys_renameat		4	/* 4295 */
-	sys	sys_linkat		4
+	sys	sys_linkat		5
 	sys	sys_symlinkat		3
 	sys	sys_readlinkat		4
 	sys	sys_fchmodat		3
