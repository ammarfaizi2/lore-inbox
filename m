Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267036AbRGMLbD>; Fri, 13 Jul 2001 07:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267040AbRGMLax>; Fri, 13 Jul 2001 07:30:53 -0400
Received: from smtp3.libero.it ([193.70.192.53]:12697 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S267036AbRGMLan>;
	Fri, 13 Jul 2001 07:30:43 -0400
Message-ID: <3B4EDBCE.D2AEAD16@alsa-project.org>
Date: Fri, 13 Jul 2001 13:30:22 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, nfs-devel@linux.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: [NFS] [PATCH] Bug in NFS
In-Reply-To: <3B4E93E9.F6506CC0@alsa-project.org> <15182.48923.214510.180434@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> On Friday July 13, abramo@alsa-project.org wrote:
> >
> > I have found a bug in NFSv2.
> >
> > [root@igor /tmp]# mount igor:/u u
> > [root@igor /tmp]# cd u
> > [root@igor u]# umask 000
> > [root@igor u]# ls -l q
> > ls: q: File o directory inesistente
> > [root@igor u]# touch q
> > [root@igor u]# ls -l q
> > -rw-r--r--    1 root     root            0 lug 13 07:56 q
> >
> > This seems to be caused by use of unitialized current->fs->umask via
> > vfs_create called by nfsd_create.
> >
> 
> Hmmm..  I think there is more here than immediately meets the eye.
> 
> current->fs->umask is initialised, to 0, in include/linux/fs_struct.h
> The "INIT_FS" define is used to set the initial value of the fs_struct
> (see arch/i386/kernel/init_task.c - other archs are the same).
> The third field here is the umask field.
> 
> This is the fs_struct for init, and for every kernel thread that call
> daemonise, as the nfsd threads do ever since 2.4.3pre5 or there abouts.
> 
> If the umask for nfsd is getting set to 022, as it would appear from
> your experiment, then either:
>   - your init process is setting it, or
>   - you are using some odd architecture that doesn't use INIT_FS
> 
> So: what init program are you running, what architecture, any other
> patches, anything else that might explain why your machine is
> different from mine.  Because on mine, the touched file gets the right
> permissions.

I've seen that on several systems with the following characteristics:

- Torvalds linux-2.4.6, Torvalds linux-2.4.4, linux-2.4.4+xfs from sgi
- nfsd compiled as a module (I suppose this make the difference we see)
- stock redhat-7.1 with updates applied

$ rpm -qf /sbin/init
SysVinit-2.78-17

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
