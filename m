Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTFBTir (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 15:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTFBTir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 15:38:47 -0400
Received: from pat.uio.no ([129.240.130.16]:2037 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261843AbTFBTip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 15:38:45 -0400
To: Frank Cusack <fcusack@fcusack.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 v. 2.5 nfs_dentry_iput()
References: <20030602021529.A19114@google.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 02 Jun 2003 21:52:05 +0200
In-Reply-To: <20030602021529.A19114@google.com>
Message-ID: <shsy90kb6l6.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:

     > Hi, Could someone quickly explain the difference between the
     > 2.4.20 and 2.5.69 nfs_dentry_iput()?

     > static void nfs_dentry_iput(struct dentry *dentry, struct inode
     > *inode) {
     >         if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
     >                 lock_kernel();
     >                 inode-> i_nlink--; /* only in 2.5 */

Should eventually go into 2.4.x. Not critical...

     >                 nfs_complete_unlink(dentry); unlock_kernel();
     >         } if (is_bad_inode(inode)) /* not in 2.5 */
     >                 force_delete(inode); /* not in 2.5 */

Done in the VFS in 2.5

     >         /* When creating a negative dentry, we want to renew
     >         d_time */ nfs_renew_times(dentry); /* only in 2.5 */

Only needed for the new CTO code in 2.5.

     >         iput(inode);
     > }

Cheers,
  Trond
