Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289895AbSAOOto>; Tue, 15 Jan 2002 09:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289840AbSAOOtf>; Tue, 15 Jan 2002 09:49:35 -0500
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:39387 "EHLO
	mailhost.uni-koblenz.de") by vger.kernel.org with ESMTP
	id <S289881AbSAOOtZ>; Tue, 15 Jan 2002 09:49:25 -0500
Message-Id: <200201151449.g0FEnML15252@bliss.uni-koblenz.de>
Content-Type: text/plain; charset=US-ASCII
From: Rainer Krienke <krienke@uni-koblenz.de>
Organization: Uni Koblenz
To: linux-kernel@vger.kernel.org
Subject: 2.4.17: Hardwired limit of parallel nfs mounts 
Date: Tue, 15 Jan 2002 15:49:22 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to everyone,

I have a question regarding the maximal number of NFS-mounts in Kernel 2.4.17 
(on a i686 box running suse7.3).  I found out that this number is hardwired 
in the kernel in linux/fs/super.c in the bitmap unnamed_dev_in_use.  
Since we have put all the data of our users (~4000) on several central NFS 
servers it happens sometimes that eg. the mailserver (running linux) has to 
mount several hundred home directories by autofs e.g. when users are reading 
Mail by POP/IMAP. In this sense the limit of 256 is quite small. Even when I 
set the expiration time of autofs to a quite small value it happens sometimes 
that autfs cannot mount  home directories since the mtable is currently full 
(errno: EINVAL).  

To change the limit I simply replaced the limit of 256 by 1024 in super.c. In 
this situation I can mount about 800 NFS-directories at the same time and 
then the kernel complains in /var/log/messages:
....
automount[861]: attempting to mount entry /home/anotheruser
Jan 15 09:03:11 bris kernel: RPC: Can't bind to reserved port (98).
Jan 15 09:03:11 bris kernel: NFS: cannot create RPC transport.
Jan 15 09:03:11 bris kernel: nfs warning: mount version older than kernel
Jan 15 09:03:11 bris kernel: RPC: Can't bind to reserved port (98).
Jan 15 09:03:11 bris kernel: NFS: cannot create RPC transport.

Nothing serious  happens, exept that I cannot mount more NFS-Dirs until 
autofs has expired some of the ones previously mounted. 
Does anyone know why this happens? Do I have to change anything else of the 
kernel to allow a number of about 1024 NFS-mounts at the same time? 

Wouldnt it be generally a good idea to raise this limit or to make the value 
configurable in any way? Why does this limit still exist anyway? 

Thanks to all
Rainer
--
---------------------------------------------------------------------
Rainer Krienke                     krienke@uni-koblenz.de
Universitaet Koblenz, 		   http://www.uni-koblenz.de/~krienke
Rechenzentrum,                     Voice: +49 261 287 - 1312
Rheinau 1, 56075 Koblenz, Germany  Fax:   +49 261 287 - 1001312
---------------------------------------------------------------------
