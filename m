Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbTB0MsK>; Thu, 27 Feb 2003 07:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbTB0MsK>; Thu, 27 Feb 2003 07:48:10 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:26130 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264875AbTB0MsJ>; Thu, 27 Feb 2003 07:48:09 -0500
Message-Id: <200302271251.h1RCpas29798@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: jw schultz <jw@pegasys.ws>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Date: Thu, 27 Feb 2003 14:48:33 +0200
X-Mailer: KMail [version 1.3.2]
References: <20030219112111.GD130@DervishD> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030227092121.GG15254@pegasys.ws>
In-Reply-To: <20030227092121.GG15254@pegasys.ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 February 2003 11:21, jw schultz wrote:
> On Thu, Feb 27, 2003 at 05:42:30PM +0900, Miles Bader wrote:
> > Kasper Dupont <kasperd@daimi.au.dk> writes:
> > > > Yes.  On some systems, /var and /tmp are the _only_ read-write
> > > > filesystems.
> > >
> > > OK, but then on such a system with my approach it would be
> > > possible to make /mtab.d a symlink pointing to somewhere under
> > > /var.
> >
> > ... you could do the same with /etc/mtab.
> >
> > In fact since /etc is almost guaranteed to be on the same
> > filesystem as /, it seems like "/mtab.d" offers zero advantages
> > over just /etc/mtab -- the case where /etc/mtab is the most
> > annoying is when /etc is R/O, but this almost always means that /
> > will be R/O, making /mtab.d useless too.
>
> If you netboot /etc as its own filesystem make sense.  Why
> duplicate the rest of root just for /etc.  /etc, /var and
> /tmp are the only filesystems that have much reason to be
> unique to a system; all others are easily sharable and most
> others read-only.

This is my netboot root fs, it is shared across all workstations
(NB: .local is "mount --bind"ed to workstation-private directory):

# ls -la /
drwxr-xr-x   6 root     root         4096 Mar 12  2002 .local
drwxr-xr-x  15 root     root         4096 Feb 14 11:12 .share
dr-xr-xr-x   2 root     root         4096 Jan 16 14:29 bin
dr-xr-xr-x  20 root     root         1024 Feb  4 13:23 boot
drwxr-xr-x   1 root     root            0 Jan  1  1970 dev
drwxr-xr-x   3 root     root         4096 Jan 16 14:29 lib
dr-xr-xr-x  68 root     root            0 Feb 27 15:42 proc
lrwxrwxrwx   1 root     root            3 Oct 24 15:20 sbin -> bin
lrwxrwxrwx   1 root     root           12 Nov 12  2001 root -> /.share/root
lrwxrwxrwx   1 root     root           12 Nov 12  2001 home -> /.share/home
lrwxrwxrwx   1 root     root           11 Nov 12  2001 usr -> /.share/usr
lrwxrwxrwx   1 root     root           11 Nov 12  2001 mnt -> /.local/mnt
lrwxrwxrwx   1 root     root           11 Jun  7  2002 etc -> /.local/etc
lrwxrwxrwx   1 root     root           11 Nov 12  2001 tmp -> /.local/tmp
lrwxrwxrwx   1 root     root           11 Nov 12  2001 var -> /.local/var
--
vda
