Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278200AbRJLXgf>; Fri, 12 Oct 2001 19:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278201AbRJLXgP>; Fri, 12 Oct 2001 19:36:15 -0400
Received: from siaar2ab.compuserve.com ([149.174.40.138]:29834 "EHLO
	siaar2ab.compuserve.com") by vger.kernel.org with ESMTP
	id <S278200AbRJLXgJ>; Fri, 12 Oct 2001 19:36:09 -0400
From: Signal9 <signal9@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: possible bug in VFS ?
Date: Sat, 13 Oct 2001 01:50:31 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="iso-8859-1"
MIME-Version: 1.0
Message-Id: <01101301503101.00295@apocalipsis>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 When i tried bestcrypt (a crypto-fs) with the new 2.4.12 kernel, i got a 
ooops when mounting a device. The oops was in this line:

(in bcrypt-0.8-6/mod/bc_dev24.c)

               root = current->fs->rootmnt;
               list_for_each(ptr, &root->mnt_list) {
                        mnt = list_entry(ptr, struct vfsmount, mnt_list);
                        sb = mnt ? mnt->mnt_sb : NULL;
                         if (NULL != sb && dev == sb->s_dev) <============
                                        mntget(mnt);
                }

 The oops was a pointer dereference to 0x9. I added some printk's to see the 
values of the pointers. I did see that in the last 'struct vfsmount' linked 
inside root->mnt_list, the mnt_sb field is '0x1', so when it tries to access 
sb->sb_dev it dereferences a pointer to 0x9. The field mnt_devname was NULL.

 ¿Is this a bug in the kernel or a bug in bestcrypt?

 Cheers,

 - Doing

PD: Please send replies with CC to me, since i'm not subscribed to the list :)
