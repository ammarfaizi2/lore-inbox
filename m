Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130736AbRBJMeN>; Sat, 10 Feb 2001 07:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131089AbRBJMdw>; Sat, 10 Feb 2001 07:33:52 -0500
Received: from ip164-218.fli-ykh.psinet.ne.jp ([210.129.164.218]:4294 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S130615AbRBJMdq>;
	Sat, 10 Feb 2001 07:33:46 -0500
Message-ID: <3A85351A.54BA3E7C@yk.rim.or.jp>
Date: Sat, 10 Feb 2001 21:33:30 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: rgooch@atnf.csiro.au, linux-kernel@vger.kernel.org
Subject: devfs: "cd" device not showing up initially. [Fwd: Scan past lun 7 in 
 2.4.0]
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(Below is a partially edited quote of an e-mail I sent
to linux-scsi mailing list.)

I have begun using devfs for about a couple of weeks now and
thank you for the great addition to linux.
Now I am happy to see the device names on the
scsi chain which won't be changed just because
I add/delete a device.

However, I noticed that there seems to be a subtle interaction of
devfs (+devfsd) and
the device names that appear under luns for
a scsi chain.

Namely the name "generic" or "disc" seem to
exist from the start (after bootup), but
the entry "cd" doesn't exist until I do something
about accessing the CD somehow.
(It seems that I fail the initial
attempt to mount due to the missing name.)


> Below is the more detailed problem about devfs
> name recognition thing.
> Has anyone seen something like this before?
>
> I am not entirely sure where to report this.
> (It might as well be the scsi system problem...)
> Help will be appreciated where to send the bug reports, etc..
> (Forwarding will be fine.)
>
> Happy Hacking,
>
> Chiaki
>
> ---
> I use Debian GNU/Linux, kernel 2.4.1.
> ishikawa@duron$ uname -a
> Linux duron 2.4.1 #18 Fri Feb 9 02:18:50 JST 2001 i686 unknown
>
> I have enabled devfs and installed devfsd.
>
> devfs is mounted at the boot time.
> Kernel command line: devfs=mount root=/dev/sda6 ro
> scsihosts=sym53c8xx:tmscsim BOOT_IMAGE=241.ey2
>
> devfs related message lines from dmesg:
> dmesg | grep -i devfs
> Kernel command line: devfs=mount root=/dev/sda6 ro
> scsihosts=sym53c8xx:tmscsim BOOT_IMAGE=241.ey2
> devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
> devfs: boot_options: 0x0
> Mounted devfs on /dev
>
> I have observed an anomaly in device listing
> when done by "ls".
>
> I have a couple of CD devices on
> a SCSI chain.
> In the following listing,
> the device at host1/bus0/target6 is a 7 lun
> CD changer device.
> The device at target5 is a two lun CD/PD (PD
> seems to be recognized as optical device of some sort, i.e. an optical
> disc.
> Lun 0 for this combo is used for PD (disc).
> Lun 1 for this compo is used for CD.
>
> Please note that on the first try, ls didn't show any "cd" entry for
> the said devices.  For comparison purposes,
> look specifically at target6/lun0.
>
> However, after playing with legacy names and
> cd into one of the device directories,
> the "cd" entries show up.
> See the ls listing under target6/lun0.
>
> Is this normal?
> I thought the entry for "cd" should be there from the beginning.
>
> NOTE: Come to think of it since "disc" is present for
> (id 5, lun 0) PD (disc) device from the start,
> this problem may be present only for CD devices.
>
> >From typescript :
>

(Please be advised that the mailer may
mungle long lines.)

>
> ishikawa@duron$ ls /dev/scsi/host1
> ./  ../  bus0/
> ishikawa@duron$ ls /dev/scsi/host1/bus0
> ./  ../  target5/  target6/
> ishikawa@duron$ ls /dev/scsi/host1/bus0/target5
> ./  ../  lun0/  lun1/
> ishikawa@duron$ ls /dev/scsi/host1/bus0/target5/lun0    <== "disc" is there.
>
> ./  ../  disc  generic
> ishikawa@duron$ ls /dev/scsi/host1/bus0/target5/lun1    <== CD device. No
> "cd".
> ./  ../  generic
> ishikawa@duron$ ls -l /dev/scsi/host1/bus0/target6
>  0
> drwxr-xr-x    1 root     root            0 Jan  1  1970 ./
> drwxr-xr-x    1 root     root            0 Jan  1  1970 ../
> drwxr-xr-x    1 root     root            0 Jan  1  1970 lun0/
> drwxr-xr-x    1 root     root            0 Jan  1  1970 lun1/
> drwxr-xr-x    1 root     root            0 Jan  1  1970 lun2/
> drwxr-xr-x    1 root     root            0 Jan  1  1970 lun3/
> drwxr-xr-x    1 root     root            0 Jan  1  1970 lun4/
> drwxr-xr-x    1 root     root            0 Jan  1  1970 lun5/
> drwxr-xr-x    1 root     root            0 Jan  1  1970 lun6/
> ishikawa@duron$ ls -l /dev/scsi/host1/bus0/target6/lun0
>  0
> drwxr-xr-x    1 root     root            0 Jan  1  1970 ./
> drwxr-xr-x    1 root     root            0 Jan  1  1970 ../
> crw-------    1 root     root      21,   3 Jan  1  1970 generic
> ishikawa@duron$ ls -l /dev/scsi/host1/bus0/target6/lun1
>  0
> drwxr-xr-x    1 root     root            0 Jan  1  1970 ./
> drwxr-xr-x    1 root     root            0 Jan  1  1970 ../
> crw-------    1 root     root      21,   4 Jan  1  1970 generic
> ishikawa@duron$
> ishikawa@duron$ echo "Have you noticed that no CD entries are found above?"
>
> Have you noticed that no CD entries are found above?
> ishikawa@duron$
> ishikawa@duron$ ls -l /dev/scsi/host1/bus0/target6/lun6
>  0
> drwxr-xr-x    1 root     root            0 Jan  1  1970 ./
> drwxr-xr-x    1 root     root            0 Jan  1  1970 ../
> crw-------    1 root     root      21,   9 Jan  1  1970 generic
> ishikawa@duron$
> ishikawa@duron$ echo "However, now I do something using the copatibility
> device names."
> However, now I do something using the copatibility device names.
> ishikawa@duron$
> ishikawa@duron$
> ishikawa@duron$
> ishikawa@duron$ ls -l /dev/scd*
> lr-xr-xr-x    1 root     root            3 Feb  9  2001 /dev/scd0 -> sr0
> lr-xr-xr-x    1 root     root            3 Feb  9  2001 /dev/scd1 -> sr1
> lr-xr-xr-x    1 root     root            3 Feb  9  2001 /dev/scd2 -> sr2
> lr-xr-xr-x    1 root     root            3 Feb  9  2001 /dev/scd3 -> sr3
> lr-xr-xr-x    1 root     root            3 Feb  9  2001 /dev/scd4 -> sr4
> lr-xr-xr-x    1 root     root            3 Feb  9  2001 /dev/scd5 -> sr5
> lr-xr-xr-x    1 root     root            3 Feb  9  2001 /dev/scd6 -> sr6
> lr-xr-xr-x    1 root     root            3 Feb  9  2001 /dev/scd7 -> sr7
> ishikawa@duron$ ls -l /dev/sr*
> lr-xr-xr-x    1 root     root           31 Feb  9 13:09 /dev/sr0 ->
> scsi/host1/bus0/target5/lun1/cd
> lr-xr-xr-x    1 root     root           31 Feb  9 13:09 /dev/sr1 ->
> scsi/host1/bus0/target6/lun0/cd
> lr-xr-xr-x    1 root     root           31 Feb  9 13:09 /dev/sr2 ->
> scsi/host1/bus0/target6/lun1/cd
> lr-xr-xr-x    1 root     root           31 Feb  9 13:09 /dev/sr3 ->
> scsi/host1/bus0/target6/lun2/cd
> lr-xr-xr-x    1 root     root           31 Feb  9 13:09 /dev/sr4 ->
> scsi/host1/bus0/target6/lun3/cd
> lr-xr-xr-x    1 root     root           31 Feb  9 13:09 /dev/sr5 ->
> scsi/host1/bus0/target6/lun4/cd
> lr-xr-xr-x    1 root     root           31 Feb  9 13:09 /dev/sr6 ->
> scsi/host1/bus0/target6/lun5/cd
> lr-xr-xr-x    1 root     root           31 Feb  9 13:09 /dev/sr7 ->
> scsi/host1/bus0/target6/lun6/cd
>
> ishikawa@duron$ cd /dev/scsi/host1/bus0/target6/lun0
> ishikawa@duron$ ls -l
>  0
> drwxr-xr-x    1 root     root            0 Jan  1  1970 ./
> drwxr-xr-x    1 root     root            0 Jan  1  1970 ../
> brw-rw----    1 root     cdrom     11,   1 Jan  1  1970 cd         <== CD
> device!
> crw-------    1 root     root      21,   3 Jan  1  1970 generic
> ishikawa@duron$
> ishikawa@duron$ echo "Am I missing something?"
> Am I missing something?
> ishikawa@duron$
>
> COMMENT:
> Come to think of accessing the symlinks probably
> had no bearing on the behavior change. Maybe "cd" ing to
> the device directory made a difference.
> Changing directory to the larget lun0 might have triggered
> some sort of device registration.
> But I think this is strange.
> Devfs ought to have done it in advance at the startup time.
>
> I am using Debian GNU/Linux
> Kernel 2.4.1 (+ a patch that floated on the linux-scsi.)
>
> devfsd and related init scripts
> is from the Debian  unstable distribution.
>
>

Is it possible that the accessing the CD using the
compatibility device name /dev/sr* forced
the creation of the "cd" device name?

I consider the possibility of module loading. Both SCSI CD and
SCSI generic (sg) are modules now.
I checked /etc/devfs/devfs.conf (experimental Debian package
puts the config file here! ) has the following line:

    LOOKUP  .*              MODLOAD

So the module autoloading ought to work. ("generic" exists
somehow from the start.)

I admit that not many people have scsi CD changers
and so these problems may not show up often enough to be noticed.
I was trying to test some CD access functions and then I realized this
anomaly.

Happy Hacking,

Chiaki


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
