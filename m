Return-Path: <linux-kernel-owner+w=401wt.eu-S1751797AbXAUXuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbXAUXuv (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 18:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbXAUXuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 18:50:50 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:45914 "EHLO
	relay02.mail-hub.dodo.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751797AbXAUXuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 18:50:50 -0500
X-Greylist: delayed 51875 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 18:50:49 EST
From: Grant Coady <grant_lkml@dodo.com.au>
To: Willy Tarreau <w@1wt.eu>
Cc: Grant Coady <gcoady.lk@gmail.com>, dann frazier <dannf@dannf.org>,
       Santiago Garcia Mantinan <manty@debian.org>,
       linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: problems with latest smbfs changes on 2.4.34 and security backports
Date: Mon, 22 Jan 2007 10:50:47 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <lpu7r2lbtpm5cui8v1qpuj2fb5k3vs6f4n@4ax.com>
References: <20070117100030.GA11251@clandestino.aytolacoruna.es> <20070117215519.GX24090@1wt.eu> <20070119010040.GR16053@colo> <20070120010544.GY26210@colo> <t1r7r2thimh3gpuhtfc9l3aehjdd6dqkp8@4ax.com> <20070121230321.GC2480@1wt.eu>
In-Reply-To: <20070121230321.GC2480@1wt.eu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2007 00:03:21 +0100, Willy Tarreau <w@1wt.eu> wrote:

>Hi Grant !
>
>On Mon, Jan 22, 2007 at 09:52:44AM +1100, Grant Coady wrote:
>> On Fri, 19 Jan 2007 18:05:44 -0700, dann frazier <dannf@dannf.org> wrote:
>> 
>> >On Thu, Jan 18, 2007 at 06:00:40PM -0700, dann frazier wrote:
>> >Ah, think I see the problem now:
>> >
>> >--- kernel-source-2.4.27.orig/fs/smbfs/proc.c	2007-01-19 17:53:57.247695476 -0700
>> >+++ kernel-source-2.4.27/fs/smbfs/proc.c	2007-01-19 17:49:07.480161733 -0700
>> >@@ -1997,7 +1997,7 @@
>> > 		fattr->f_mode = (server->mnt->dir_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | S_IFDIR;
>> > 	else if ( (server->mnt->flags & SMB_MOUNT_FMODE) &&
>> > 	          !(S_ISDIR(fattr->f_mode)) )
>> >-		fattr->f_mode = (server->mnt->file_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | S_IFREG;
>> >+		fattr->f_mode = (server->mnt->file_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | (fattr->f_mode & S_IFMT);
>> > 
>> > }
>> > 
>> client running 2.4.34 with above patch, server is running 2.6.19.2 to 
>> eliminate it from the problem space (hopefully ;) :
>> grant@sempro:/home/other$ uname -r
>> 2.4.34b
>> grant@sempro:/home/other$ ls -l
>> total 9
>> drwxr-xr-x 1 grant wheel 4096 2007-01-21 11:44 dir/
>> drwxr-xr-x 1 grant wheel 4096 2007-01-21 11:44 dirlink/
>> -rwxr-xr-x 1 grant wheel   15 2007-01-21 11:43 file*
>> -rwxr-xr-x 1 grant wheel   15 2007-01-21 11:43 filelink*
>
>It seems to me that there is a difference, because filelink now appears the
>same size as file. It's just as if we had hard links instead of symlinks.

Hi Willy,

No, those dir and files were created server-side, sorry I gave wrong 
impression, I still get on client side:

grant@sempro:/home/other$ uname -r
2.4.34b
grant@sempro:/home/other$ mkdir test
grant@sempro:/home/other$ ln -s test testlink
ln: creating symbolic link `testlink' to `test': Operation not permitted
grant@sempro:/home/other$ echo "this is also a test" > test/file
grant@sempro:/home/other$ ln -s test/file test2
ln: creating symbolic link `test2' to `test/file': Operation not permitted

trying to create symlinks.

No problems creating symlinks with 2.4.33.3.

Grant.
