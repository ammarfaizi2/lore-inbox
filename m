Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269376AbTCDLF3>; Tue, 4 Mar 2003 06:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269378AbTCDLF3>; Tue, 4 Mar 2003 06:05:29 -0500
Received: from [66.70.28.20] ([66.70.28.20]:25868 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S269376AbTCDLF2>; Tue, 4 Mar 2003 06:05:28 -0500
Date: Tue, 4 Mar 2003 12:16:22 +0100
From: DervishD <raul@pleyades.net>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: jw schultz <jw@pegasys.ws>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Message-ID: <20030304111622.GC42@DervishD>
References: <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DB2CA.32539D41@daimi.au.dk> <buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DCB89.9086582F@daimi.au.dk> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030227092121.GG15254@pegasys.ws> <20030302130430.GI45@DervishD> <3E621235.2C0CD785@daimi.au.dk> <20030303010409.GA3206@pegasys.ws> <3E634916.6AE643EB@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E634916.6AE643EB@daimi.au.dk>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Kasper and J.W. :)

 Kasper Dupont dixit:
> As long as these options is not yet stored in the kernel, we
> need /etc/mtab. The question is how to get them into the kernel.

    That was my first question. Certainly there should be a way to
tell the kernel those options, but... Do we really need them. As you
said, those options (the user options) are used by mount itself, so
the kernel doesn't need to know them. If we are concerned by the
'user' option, that allows normal users to mount and umount
filesystems, and that option is not in the syscall, I think that it
should be done with other approach. See below.

> Before we can get rid of /etc/mtab we need to agree on how
> to solve those problems. There might be other cases I don't
> know about, where /etc/mtab contains special values.

    In the case of normal users mounting and umounting filesystems,
this could be done throught the use of capabilities, I think. And
surely better methods exist. If we could tell the kernel that some
user 'a' mounted filesystem 'f', then at umount time the umount
syscall will only success if root or 'a' umounts 'f'. The question is
if we can tell it to the kernel. The mount syscall maybe? Maybe a VFS
flag just for this purpose (that seems to be very important). Other
user flats like the permissions, etc... are merely informative and
that info is present in /etc/fstab anyway (usually).

    The loopback issue is more a problem of consistency, I think.

    Raúl
