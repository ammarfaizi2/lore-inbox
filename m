Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbUCKBxB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 20:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbUCKBvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 20:51:44 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:18644 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262941AbUCKBt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 20:49:26 -0500
Message-ID: <404FC557.25F573@linuxgang.com>
Date: Thu, 11 Mar 2004 02:48:07 +0100
From: Thomas Duda <td@linuxgang.com>
X-Mailer: Mozilla 4.78 [de] (Windows NT 5.0; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To: axboe@suse.de
CC: olaf@cbk.poznan.pl, linux-kernel@vger.kernel.org, degger@fhm.edu
Subject: Re: 2.6.3 BUG - can't write DVD-RAM - reported as write-protected
References: <1078434953.1961.13.camel@venus.local.navi.pl> <20040305082350.GO31750@suse.de> <1078487159.3300.23.camel@venus.local.navi.pl> <20040307105911.GH23525@suse.de> <1078819165.1525.1.camel@venus.local.navi.pl> <20040309091221.GV23525@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:8fb5c08e9d3e0ca75490a362ed67cd35
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

to me this seems to be a problem with dvdram drives connected to a scsi
hba.
I've got exactly the same software setup based on 2.6.2 on 3 systems
with
a dvdram drive. One is a Panasonic LFD-201 (SCSI), another one is a
Panasonic
LFD-521 (IDE), the third is an LG-4020B (IDE).

The SCSI LFD-201 is connected to an Adaptec 7890. There is no way I can
use it to write data. A mount always happens read-only. Even though "Can
write DVD-RAM" is reported in /proc/sys/dev/cdrom/info.

Another phenomen: mkfs.ext2 /dev/scd0 runs as usual. No errors or any
other messages. The drive led lightens up. However - the dvdram doesn't
have
an ext2 fs afterwards. If I do a tune2fs -c 0 -t 0 /dev/scd0 it tells me
"bad superblock".

The 2 IDE dvdram drives in the other machines perform the task as
expected.

If I take the dvdram out of the scsi drive into the ide drives, format
it with mkfs.ext2, put it back into the scsi drive, then I see an ext2
fs
on it.

Just for clarification: They all workfine with all their speced out
capabilities
with plain Suse 9.0 out-of-the-box! (off-course with ide-scsi, kernel
2.4.21-192)

To me this looks like a problem in 2.6.2/3 with scsi connected dvdram
drives only..?
So may be the problem lies not in the cdrom stuff but in interfacing
that to the 
scsi layer..?

As a remark: I noticed that /proc/sys/dev/cdrom/info doesn't report
anything
related to dvd-rw nor dvd+rw write capabilites for the ide based LG
GSA-4040B
or the Panasonic LFD-521E (dvd-rw only!). Is this intentional?

regs

td


Jens Axboe schrieb:
> 
> On Tue, Mar 09 2004, Olaf Fr?czyk wrote:
> > On Sun, 2004-03-07 at 11:59, Jens Axboe wrote:
> > > On Fri, Mar 05 2004, Olaf Fr?czyk wrote:
> > > > On Fri, 2004-03-05 at 09:23, Jens Axboe wrote:
> > > > > On Thu, Mar 04 2004, Olaf Fr?czyk wrote:
> > > > > > Hi,
> > > > > > I switched to 2.6.3 from 2.4.x serie.
> > > > > > When I mount DVD-RAM it is mounted read-only:
> > > > > >
> > > > > > [root@venus olaf]# mount /dev/dvdram /mnt/dvdram
> > > > > > mount: block device /dev/dvdram is write-protected, mounting read-only
> > > > > > [root@venus olaf]#
> > > > > >
> > > > > > In 2.4 it is mounted correctly as read-write.
> > > > > >
> > > > > > Drive: Panasonic LF-201, reported in Linux as:
> > > > > > MATSHITA        DVD-RAM LF-D200         A120
> > > > > >
> > > > > > SCSI controller: Adaptec 2940U2W
> > > > >
> > > > > What does cat /proc/sys/dev/cdrom/info say? Do you get any kernel
> > > > > messages in dmesg when the rw mount fails?
> > > >
> > > > I get nothing in /var/log/dmesg and in /var/log/messages
> > > > In /proc/sys/dev/cdrom/info I get:
> > > > [olaf@venus olaf]$ cat /proc/sys/dev/cdrom/info
> > > > CD-ROM information, Id: cdrom.c 3.20 2003/12/17
> > > >
> > > > drive name:             sr1     sr0     hdc
> > > > drive speed:            0       16      44
> > > > drive # of slots:       1       1       1
> > > > Can close tray:         1       1       1
> > > > Can open tray:          1       1       1
> > > > Can lock tray:          1       1       1
> > > > Can change speed:       1       1       1
> > > > Can select disk:        0       0       0
> > > > Can read multisession:  1       1       1
> > > > Can read MCN:           1       1       1
> > > > Reports media changed:  1       1       1
> > > > Can play audio:         1       1       1
> > > > Can write CD-R:         0       1       1
> > > > Can write CD-RW:        0       1       1
> > > > Can read DVD:           1       0       0
> > > > Can write DVD-R:        0       0       0
> > > > Can write DVD-RAM:      1       0       0
> > > > Can read MRW:           0       0       1
> > > > Can write MRW:          0       0       1
> > > >
> > > > The one I'm mounting is /dev/scd1.
> > > > As there is capablity to write-protect DVD-RAM disk (like a 1.44"
> > > > Floppy), I think that the linux kernel interprets some message from
> > > > device in wrong way.
> > >
> > > Please repeat with this patch applied and send back the results, thanks.
> > >
> > > ===== drivers/cdrom/cdrom.c 1.48 vs edited =====
> > > --- 1.48/drivers/cdrom/cdrom.c      Mon Feb  9 21:58:21 2004
> > > +++ edited/drivers/cdrom/cdrom.c    Sun Mar  7 11:58:40 2004
> > > @@ -645,9 +645,12 @@
> > >  {
> > >     disc_information di;
> > >
> > > -   if (cdrom_get_disc_info(cdi, &di))
> > > +   if (cdrom_get_disc_info(cdi, &di)) {
> > > +           printk("cdrom: read di failed\n");
> > >             return 0;
> > > +   }
> > >
> > > +   printk("cdrom: erasable: %d\n", di.erasable);
> > >     return di.erasable;
> > >  }
> > >
> > I get:
> > cdrom: read di failed
> 
> Can you try to instrument drivers/cdrom/cdrom.c:cdrom_get_disc_info()
> and find out where it fails? Change the cgc.quiet = 1 to a = 0 in there
> as well (that alone might be enough to pin point the problem).
> 
> --
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

