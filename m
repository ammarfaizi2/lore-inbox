Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317705AbSGPABI>; Mon, 15 Jul 2002 20:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317707AbSGPABH>; Mon, 15 Jul 2002 20:01:07 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:14607 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317705AbSGPABH>;
	Mon, 15 Jul 2002 20:01:07 -0400
Date: Mon, 15 Jul 2002 17:03:11 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] LSM setup changes for 2.5.25
Message-ID: <20020716000311.GC32262@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020715093021.B26472@figure1.int.wirex.com>
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

ChangeSet@1.641, 2002-07-15 12:53:35-07:00, greg@kroah.com
  LSM: move struct shmid_kernel out of ipc/shm.c to include/linux/shm.h
  
  Also move where we set sma->sem_perm.mode and .key to before ipc_addid() gets called.

 include/linux/shm.h |   13 +++++++++++++
 ipc/sem.c           |    7 ++++---
 ipc/shm.c           |   21 +++++----------------
 3 files changed, 22 insertions(+), 19 deletions(-)
------

ChangeSet@1.640, 2002-07-15 12:51:26-07:00, greg@kroah.com
  LSM: move the struct msg_msg and struct msg_queue definitions out of the msg.c file to the msg.h file
  
  Also move where the msg->q_perm.mode and .key values get set to before 
  ipc_addid() gets called to make placing a hook there easier.

 include/linux/msg.h |   29 +++++++++++++++++++++++++++++
 ipc/msg.c           |   34 ++++------------------------------
 2 files changed, 33 insertions(+), 30 deletions(-)
------

