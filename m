Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316955AbSEWRFE>; Thu, 23 May 2002 13:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316958AbSEWRFD>; Thu, 23 May 2002 13:05:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37385 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316955AbSEWRFC>; Thu, 23 May 2002 13:05:02 -0400
Date: Thu, 23 May 2002 18:04:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ian Molton <spyro@armlinux.org>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: RFC - named loop devices...
Message-ID: <20020523180453.E29960@flint.arm.linux.org.uk>
In-Reply-To: <20020521015517.609d5516.spyro@armlinux.org> <200205211409.g4LE9HY31513@Port.imtp.ilyichevsk.odessa.ua> <20020523180105.141af04b.spyro@armlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2002 at 06:01:05PM +0100, Ian Molton wrote:
> On Tue, 21 May 2002 17:11:34 -0200
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
> 
> > > I was wondering if a solution to this would be to introduce 'named'
> > > loopback devices.
> 
> > Have no time to think about this now, but will test any patches -
> > I want /etc/mtab -> /proc/mounts to become standard practice
> 
> me too. :-)

/proc/mounts and /etc/mtab contain different information.  /etc/mtab can
contain what ever information a user space app needs.  /proc/mount can't.
See the following as a perfect example, specifically the automount and
NFS entries.

Also, remember that mount uses /etc/mtab to perform synchronisation
between two concurrent mount requests for the same device/resource.

/etc/mtab:

/dev/hda3 / ext2 rw,noatime 0 0
proc /proc proc rw 0 0
pts /dev/pts devpts rw,gid=5,mode=620 0 0
/dev/hda4 /usr ext2 rw,noatime 0 0
/dev/hda5 /var ext2 rw,noatime 0 0
/dev/hda7 /usr/src ext2 rw 0 0
/dev/hda1 /mnt/adfs adfs rw,gid=501,ownmask=770,othmask=077 0 0
automount(pid440) /net/flint autofs rw,fd=5,pgrp=440,minproto=2,maxproto=3 0 0
automount(pid474) /net/sturm autofs rw,fd=5,pgrp=474,minproto=2,maxproto=3 0 0
automount(pid504) /net/tika autofs rw,fd=5,pgrp=504,minproto=2,maxproto=3 0 0
flint:/home/users /net/flint/users nfs rw,rsize=4096,wsize=4096,timeo=10,retrans=4,addr=195.xx.xxx.xx 0 0
tika:/usr/src/v2.5 /net/tika/v2.5 nfs rw,rsize=4096,wsize=4096,timeo=10,retrans=4,addr=195.xx.xxx.xx 0 0

/proc/mounts:

/dev/root / ext2 rw,noatime 0 0
/proc /proc proc rw 0 0
pts /dev/pts devpts rw 0 0
/dev/hda4 /usr ext2 rw,noatime 0 0
/dev/hda5 /var ext2 rw,noatime 0 0
/dev/hda7 /usr/src ext2 rw 0 0
/dev/hda1 /mnt/adfs adfs rw 0 0
automount(pid440) /net/flint autofs rw 0 0
automount(pid474) /net/sturm autofs rw 0 0
automount(pid504) /net/tika autofs rw 0 0
flint:/home/users /net/flint/users nfs rw,v2,rsize=4096,wsize=4096,hard,udp,lock,addr=flint 0 0
tika:/usr/src/v2.5 /net/tika/v2.5 nfs rw,v2,rsize=4096,wsize=4096,hard,udp,lock,addr=tika 0 0


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

