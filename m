Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSGQSVT>; Wed, 17 Jul 2002 14:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSGQSVS>; Wed, 17 Jul 2002 14:21:18 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:23315 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316397AbSGQSVR>;
	Wed, 17 Jul 2002 14:21:17 -0400
Date: Wed, 17 Jul 2002 11:23:05 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] LSM setup changes for 2.5.26
Message-ID: <20020717182305.GB9550@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These changesets contain some minor changes that are needed by the LSM
(lsm.immunix.org) patch, before we start to merge in the LSM patch
itself.  They move some structures out of a .c file and put them into a
.h file so other portions of the kernel can reference them.

Please pull from:  bk://lsm.bkbits.net/linus-2.5

These patches were created by Stephen Smalley <sds@tislabs.com> from the
main LSM tree.

If anyone has any questions about these changes, please let us know.

thanks,

greg k-h


 include/linux/msg.h |   29 +++++++++++++++++++++++++++++
 include/linux/shm.h |   13 +++++++++++++
 ipc/msg.c           |   34 ++++------------------------------
 ipc/sem.c           |    7 ++++---
 ipc/shm.c           |   21 +++++----------------
 5 files changed, 55 insertions(+), 49 deletions(-)

------

ChangeSet@1.639.1.2, 2002-07-15 12:53:35-07:00, greg@kroah.com
  LSM: move struct shmid_kernel out of ipc/shm.c to include/linux/shm.h
  
  Also move where we set sma->sem_perm.mode and .key to before ipc_addid() gets called.

 include/linux/shm.h |   13 +++++++++++++
 ipc/sem.c           |    7 ++++---
 ipc/shm.c           |   21 +++++----------------
 3 files changed, 22 insertions(+), 19 deletions(-)
------

ChangeSet@1.639.1.1, 2002-07-15 12:51:26-07:00, greg@kroah.com
  LSM: move the struct msg_msg and struct msg_queue definitions out of the msg.c file to the msg.h file
  
  Also move where the msg->q_perm.mode and .key values get set to before 
  ipc_addid() gets called to make placing a hook there easier.

 include/linux/msg.h |   29 +++++++++++++++++++++++++++++
 ipc/msg.c           |   34 ++++------------------------------
 2 files changed, 33 insertions(+), 30 deletions(-)
------
