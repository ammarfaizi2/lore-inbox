Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312393AbSDJKbj>; Wed, 10 Apr 2002 06:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312489AbSDJKbi>; Wed, 10 Apr 2002 06:31:38 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:17670 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312393AbSDJKbh>; Wed, 10 Apr 2002 06:31:37 -0400
Message-Id: <200204101028.g3AAS2X05866@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Sean Hunter <sean@dev.sportingbet.com>,
        Geoffrey Gallaway <geoffeg@sin.sloth.org>
Subject: Re: Ramdisks and tmpfs problems
Date: Wed, 10 Apr 2002 13:31:14 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020409144639.A14678@sin.sloth.org> <20020410084505.A4493@dev.sportingbet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 April 2002 05:45, Sean Hunter wrote:
> On Tue, Apr 09, 2002 at 02:46:39PM -0400, Geoffrey Gallaway wrote:
> > So no go with ram disks (this is kernel 2.4.18 on a 3 gig RAM dual PIII
> > 1gig, BTW). So now to try tmpfs. Since I need to copy the existing files
> > in /etc off to tmpfs I have to create a "temporary" tmpfs, copy /etc off
> > to it then create another tmpfs on top of the existing /etc and copy from
> > the "temporary" tempfs back to the new /etc. I came up with the following
> > commands:
> > mount -w -n -t tmpfs -o defaults tmpfs /mnt
> > cp -axf /etc /mnt
> > mount -w -t tmpfs -o defaults tmpfs /etc
> > cp -axf /mnt/etc/* /etc/
> > umount /mnt
> > # -- Reapeat for /var and /tmp --
>
> Wouldn't this be easier?
>
> mount -t tmpfs none /dev/shm
> cp -axf /etc/* !$
> mount --bind /dev/shm /etc

/dev is for devices, why do you use it for mounting filesystems?
I use /mnt/xxx or custom top-level dirs for mounts.

For example, I have /.share mounted to common NFS storage,
/.local mount --bind'ed to local (i.e. per-workstation) storage,
/mnt/auto is for automounter (local disk access, SMB etc)
and symlinks:
/usr -> /.share/usr
/home -> /.share/home
...
/tmp -> /.local/tmp
/var -> /.local/var
...

This works just fine for me.
--
vda
