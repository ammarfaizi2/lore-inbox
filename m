Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136108AbRD0QXX>; Fri, 27 Apr 2001 12:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136109AbRD0QXN>; Fri, 27 Apr 2001 12:23:13 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:44004 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S136108AbRD0QW6>; Fri, 27 Apr 2001 12:22:58 -0400
Date: Fri, 27 Apr 2001 10:22:49 -0600
Message-Id: <200104271622.f3RGMn703075@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: AJ Lewis <lewis@sistina.com>
Cc: Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: devfs and /proc/ide/hda
In-Reply-To: <20010427110935.C1632@sistina.com>
In-Reply-To: <3A9CCA76.3E6AB93A@optushome.com.au>
	<20010228161023.A19929@win.tue.nl>
	<20010301084133.C16667@sistina.com>
	<87snkov3uk.fsf@mose.informatik.uni-tuebingen.de>
	<20010427110935.C1632@sistina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AJ Lewis writes:
> 
> --CblX+4bnyfN0pR09
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Thu, Mar 08, 2001 at 01:32:03PM +0100, Goswin Brederlow wrote:
> >      > What it should do is change based on whether devfs is mounted
> >      > or not.  It doesn't make *any* sense to have
> >      > /dev/ide/host0/foo/bar in your /proc/partitions entries if you
> >      > aren't mounting devfs.  The /proc/partitions entry is the only
> >      > way I know of for something like LVM to determine which devices
> >      > to scan for Volume Groups.  If you can't read /proc/partitions,
> >      > it has to attempt to scan all block devices it recognizes,
> >      > regardless of whether they are actually on the system or not.
> >      > This can take several minutes.
> >=20
> > First:
> >=20
> > % cat /proc/partitions=20
> > major minor  #blocks  name
> >=20
> >    3     0   20010816 ide/host0/bus0/target0/lun0/disc
> >    3     1     192748 ide/host0/bus0/target0/lun0/part1
> >    3     2     249007 ide/host0/bus0/target0/lun0/part2
> >    3     3          1 ide/host0/bus0/target0/lun0/part3
> >    3     5     289138 ide/host0/bus0/target0/lun0/part5
> >    3     6    1951866 ide/host0/bus0/target0/lun0/part6
> >    3     7     979933 ide/host0/bus0/target0/lun0/part7
> >    3     8   16346106 ide/host0/bus0/target0/lun0/part8
> >   33     0   80043264 ide/host2/bus0/target0/lun0/disc
> >   33     1   80035798 ide/host2/bus0/target0/lun0/part1
> >=20
> > So its already right.
> 
> Only if devfs is mounted.  That's my point.  Maybe it's an corner
> case to have devfs compiled into the kernel, but not mounted, and so
> we can just ignore this, but it seems to me that /proc/partitions
> should reflect which /dev system is currently running.

I consider it a corner case. There isn't really an alternative.
Firstly, it would be really messy to magically change the output of
/proc/partitions depending on whether devfs was mounted. Secondly,
just because it's mounted doesn't mean it's mounted on /dev, so it's
still easy to get wrong.

> > Secondly with devfs, why not just scan all /dev/discs/?
> >=20
> > % ls -l /dev/discs=20
> > total 0
> > lr-xr-xr-x    1 root     root           30 Jan  1  1970 disc0 -> ../ide/h=
> ost0/bus0/target0/lun0/
> > lr-xr-xr-x    1 root     root           30 Jan  1  1970 disc1 -> ../ide/h=
> ost2/bus0/target0/lun0/
> >=20
> > Also if lvm opens all known devices by way of /dev/whatever while
> > scanning, it will only find existing devices there with devfs.
> 
> Yeah, as long as devfs is running, that makes sense.

If you want a really robust solution, have your tool scan
/proc/filesystems and see if devfs is available. If not, scan
/proc/partitions. If devfs is available, then create a temporary mount
point and mount it there, then scan $mntpoint/discs.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
