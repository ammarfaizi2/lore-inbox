Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTFBJCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTFBJCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:02:05 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:60401 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262030AbTFBJCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:02:04 -0400
Date: Mon, 2 Jun 2003 02:15:29 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4 v. 2.5 nfs_dentry_iput()
Message-ID: <20030602021529.A19114@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could someone quickly explain the difference between the 2.4.20 and 2.5.69
nfs_dentry_iput()?

static void nfs_dentry_iput(struct dentry *dentry, struct inode *inode)
{
        if (dentry->d_flags & DCACHE_NFSFS_RENAMED) {
                lock_kernel();
		inode->i_nlink--;		/* only in 2.5 */
                nfs_complete_unlink(dentry);
                unlock_kernel();
        }
        if (is_bad_inode(inode))		/* not in 2.5 */
                force_delete(inode);		/* not in 2.5 */
        /* When creating a negative dentry, we want to renew d_time */
        nfs_renew_times(dentry);		/* only in 2.5 */
        iput(inode);
}

Thanks,
/fc
