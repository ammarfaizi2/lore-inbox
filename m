Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSDXHpa>; Wed, 24 Apr 2002 03:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290818AbSDXHpa>; Wed, 24 Apr 2002 03:45:30 -0400
Received: from mail.bmlv.gv.at ([193.171.152.34]:61409 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S290593AbSDXHp2>;
	Wed, 24 Apr 2002 03:45:28 -0400
Message-Id: <3.0.6.32.20020424094915.0092a210@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Wed, 24 Apr 2002 09:49:15 +0200
To: linux-kernel@vger.kernel.org
From: "Ph. Marek" <marek@bmlv.gv.at>
Subject: Re: [PATCH] open files in kjournald & all other kernel threads
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody.

As this problem becomes more and more a general kernel-thread problem I'm
taking the ext3-mailing list out of the CC.


So far I didn't get an answer to why all kernel threads get the files of
init, so I'll make my own conclusions.

As with my tries yesterday where I've discovered that keventd oopses (in
exec_usermodehelper, if I remember correctly) if I insert comments in
sched.c like this:
          exit_fs(current);       /* current->fs->count--; */
/*
          fs = init_task.fs;
          current->fs = fs;
          atomic_inc(&fs->count); 
*/
          exit_files(current);
/*        
	   current->files = init_task.files;
          atomic_inc(&current->files->count); 
*/

So I expect that keventd needs a valid ->files structure.
Is it ok to create a single structure (empty), which all kernel threads use?
Or are there side-effects?


BTW on my system keventd, ksoftirq, kswapd, bdflush, kupdated and khupd all
have /dev/initctl left open. (I patched scsi_eh_* and kjournald, so these
don't).


Thanks & regards,

Phil


