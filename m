Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTGAKks (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 06:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTGAKks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 06:40:48 -0400
Received: from westhill.hyglo.com ([62.119.43.37]:25793 "EHLO
	westhill.hyglo.com") by vger.kernel.org with ESMTP id S262013AbTGAKkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 06:40:46 -0400
Message-ID: <3F016888.2080306@hyglo.com>
Date: Tue, 01 Jul 2003 12:55:04 +0200
From: Peter Enderborg <pme@hyglo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>
Subject: Procfs open hook bug.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jul 2003 10:55:07.0346 (UTC) FILETIME=[3BF10320:01C33FBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have done this little patch for the procfs_example.c

diff procfs_example.c 
kernels/linux-2.4.20/Documentation/DocBook/procfs_example.c
87,91d86
< static int open_qp(struct inode * inode, struct file * file)
< {
<   printk("Open my node %p %p \n",inode,file);
<   return -EINVAL;
< }
180c175
<       foo_file->proc_fops->open=open_qp;
---
 >

And when loading this module. The procfs gets broken. I get EINVAL for 
open on
/proc/meminfo and all other procfs info. Why? Should procfs inodes don't 
have full
filesematics? And it don't help to unload the module.

Strange. And a look in generic.c in fs/proc/

static struct file_operations proc_file_operations = {
    llseek:        proc_file_lseek,
    read:        proc_file_read,
    write:        proc_file_write,
};

Is this saying that we can not have the other fops on procfs inodes? No 
ioctl,open ?

