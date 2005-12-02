Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932722AbVLBLAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbVLBLAN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 06:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbVLBLAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 06:00:12 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:13254 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S932237AbVLBLAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 06:00:11 -0500
Message-ID: <00f801c5f72e$df2e58c0$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Cc: <linux-kernel@vger.kernel.org>
References: <016c01c5f6cc$0e28e6d0$0400a8c0@dcccs> <1133481721.9597.37.camel@lade.trondhjem.org>
Subject: Re: 2.6.15-rc3: adduser: unable to lock password file
Date: Fri, 2 Dec 2005 11:55:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

----- Original Message ----- 
From: "Trond Myklebust" <trond.myklebust@fys.uio.no>
To: "JaniD++" <djani22@dynamicweb.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Friday, December 02, 2005 1:02 AM
Subject: Re: 2.6.15-rc3: adduser: unable to lock password file


> On Thu, 2005-12-01 at 23:47 +0100, JaniD++ wrote:
> > Hello, list,
> >
> > I get this after upgrade from 2.6.14.2
> >
> > [root@dy-xeon-1 etc]# adduser someuser
> > adduser: unable to lock password file
> > [root@dy-xeon-1 etc]#
> >
> > I use nfsroot!
>
> I'm seeing no trouble with locking on 2.6.15-rc3 (with or without the
> -onolock option). Could you please use 'strace' to get a dump of what
> adduser is failing on?

OK, i will try it, if i can.... (this is a productive online system, maybe
next reboot)

There is some additional info:

[root@dy-xeon-1 root]# mount
192.168.0.1://NFS/ROOT-BASE/ on / type nfs
(rw,hard,rsize=8192,wsize=8192,timeo=5,retrans=0,actimeo=1)
none on /proc type proc (rw,noexec,nosuid,nodev)
192.168.2.100://DY_SYSTEM on /mnt/DY_SYSTEM type nfs
(rw,hard,rsize=16384,wsize=8192,timeo=5,retrans=0,actimeo=1,addr=192.168.2.1
00)
192.168.2.100://MAIL_STORE on /mnt/mail_store type nfs
(rw,hard,rsize=16384,wsize=8192,timeo=5,retrans=0,actimeo=1,noac,addr=192.16
8.2.100)
none on /dev/pts type devpts (rw,gid=5,mode=620)
none on /dev/shm type tmpfs (rw)
none on /sys type sysfs (rw)
none on /dev/cpuset type cpuset (rw)
/dev/md10 on /mnt/md10 type xfs
(rw,noexec,nosuid,nodev,dirsync,_netdev,noatime,osyncisdsync,noalign)
/dev/md31 on /mnt/md0 type xfs
(rw,noexec,nosuid,nodev,dirsync,_netdev,noatime,osyncisdsync,noalign)

The etc is on /  (the first line.)

After i change the kernel from 2.6.14.2 to 2.6.15-rc3, my system starts to
send error messages about user-existing.
First i starts to search the problem, and finally tracked down to kernel.
(I try to reboot with 15-rc3 and run adduser BEFORE all other service or
script, and the issue is the same.
Than i reboot back to 2.6.14.2, and the error message is gone!)

The adduser sends messages "unable to lock password file", and
sometime -usually first exec- "unable to lock shadow file".

If i know correctly, the nfsroot is only works with NFS v2.
Do you have try it with NFS or exactly on NFSROOT?

On the next reboot, i will try strace....


Cheers,

Janos

>
> Cheers,
>  Trond
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

