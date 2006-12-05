Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031490AbWLEVJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031490AbWLEVJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031451AbWLEVJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:09:20 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:35642 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031410AbWLEVJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:09:19 -0500
Date: Tue, 5 Dec 2006 22:02:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 15/35] Unionfs: Common file operations
In-Reply-To: <11652354702903-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612052155150.18570@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <11652354702903-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Dec 4 2006 07:30, Josef 'Jeff' Sipek wrote:

>+long unionfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>+{
>+	long err;
>+
>+	if ((err = unionfs_file_revalidate(file, 1)))
>+		goto out;
>+
>+	/* check if asked for local commands */
>+	switch (cmd) {
>+		case UNIONFS_IOCTL_INCGEN:
>+			/* Increment the superblock generation count */
>+			err = -EACCES;
>+			if (!capable(CAP_SYS_ADMIN))
>+				goto out;
>+			err = unionfs_ioctl_incgen(file, cmd, arg);
>+			break;
>+
>+		case UNIONFS_IOCTL_QUERYFILE:
>+			/* Return list of branches containing the given file */
>+			err = unionfs_ioctl_queryfile(file, cmd, arg);
>+			break;
>+
>+		default:
>+			/* pass the ioctl down */
>+			err = do_ioctl(file, cmd, arg);
>+			break;
>+	}
>+
>+out:
>+	return err;
>+}


I think there was an ioctl for files to find out where a particular
file lives on disk. Do you think unionfs should handle it and return
something more or less meaningful?


	-`J'
-- 
