Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315547AbSGANLm>; Mon, 1 Jul 2002 09:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315593AbSGANLl>; Mon, 1 Jul 2002 09:11:41 -0400
Received: from unthought.net ([212.97.129.24]:21471 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S315547AbSGANLl>;
	Mon, 1 Jul 2002 09:11:41 -0400
Date: Mon, 1 Jul 2002 15:14:07 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Subject: NFS-root NFS mouting problem
Message-ID: <20020701131407.GA19843@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm trying to net-boot a system (root NFS) here, but I run into trouble
mounting NFS filesystems *after* the root filesystem has been mounted
(over NFS).

Both server and client are 2.4.18 on i686 - everything works great if I
boot from a disk and mount the home filesystem via. NFS.

Booting the client via. pxelinux, the following happens:
*) Kernel loads, gets IP, ...
*) / is mounted (rw) via NFS
*) Init-scripts start running, brings up eth0, lo, portmapper, syslog,
NFS locking services, all is ok...
*) Init-scripts attempt to mount the home filesystem from the server,
just like it would if booting from the disk. This fails with the
following errors:
--------------------------
Mounting NFS filesystems:  exec: Stale NFS handle
mount: Stale NFS handle
exec: Stale NFS handle

touch: creating '/var/lock/subsys/netfs': Stale NFS handle

Mounting other filesystems:  exec: Stale NFS handle
dup2: Bad file descriptor
exec: Stale NFS handle
--------------------------

I tried net-booting to single-user mode, which works perfectly well.
Then, mounting *any* NFS filesystem will lock the system with stale NFS
handles again.

The *really* interesting thing is, that after one such failed attempt, I
must re-start the NFS *server*, otherwise the client gets a "Root-NFS
server returned error -13 while mounting /netboot/falcon"...  But I
suppose this problem will go away with the first one.

Anything I can try ?   Any ideas ?  Need more information ?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
