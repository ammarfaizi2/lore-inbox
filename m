Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVAQVJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVAQVJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 16:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVAQVJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 16:09:33 -0500
Received: from base.access-lan.com ([217.8.143.195]:37608 "HELO Losen.lan")
	by vger.kernel.org with SMTP id S261427AbVAQVJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:09:17 -0500
From: omes <kernel@omes.org>
Reply-To: kernel@omes.org
To: linux-kernel@vger.kernel.org
Subject: Re: Mysterious Lag With SATA Maxtor 250GB 7200RPM 16MB Cache Under Linux using NFSv3 UDP
Date: Mon, 17 Jan 2005 22:09:00 +0100
User-Agent: KMail/1.6.2
References: <Pine.LNX.4.61.0501171459150.1821@p500> <200501172148.41252.Norbert@edusupport.nl> <Pine.LNX.4.61.0501171555550.1821@p500>
In-Reply-To: <Pine.LNX.4.61.0501171555550.1821@p500>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501172209.00325.kernel@omes.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same problem as you. At least our problems are much alike. I got 
two Western digital hard disks. One 120GB 7200RPM 2MB Cache IDE, and one 80GB 
7200 2MB Cache IDE. I get high loads when reading large files for some time, 
as well as when copying from one partition to another. All my partitions are 
in ext3, and i'm running 2.6.10.

hdparm tests resulted in normal readings however. And when just reading small 
files the system looks and feels normal.

What motherboard have you got?

Regards,
 -   omes
On Monday 17 January 2005 21:56, you wrote:
> Yes, only with NFS.
>
> On Mon, 17 Jan 2005, Norbert van Nobelen wrote:
> > Only with NFS? I have a raid array of the same discs and the system just
> > sometimes seems to hang completely (for a second or less) and then to go
> > on again at a normal speed (110MB/s).
> > I am running a SuSE 9.1 stock kernel (2.6.5-7.111-smp) on that machine.
> >
> > On Monday 17 January 2005 21:06, you wrote:
> >> When writing to or from the drive via NFS, after 1GB or 2GB, it "feels"
> >> like the system slows to a crawl, the mouse gets very slow, almost like
> >> one is burning a CD at 52X under PIO mode.  I originally had this disk
> >> in my main system with an Intel ICH5 chipset (ABIT IC7-G mobo) and a
> >> Pentium 4 2.6GHZ w/HT and I could not believe the hit the system took
> >> when writing over NFS.
> >>
> >> I put the drive on its own controller in another box to see if I could
> >> replicate the problem.  The drive is on a Promise 150TX2 Plus
> >> controller. When writing locally on the disk, there is no problem.  When
> >> writing to or from the drive over NFS, the system becomes _very_ slow,
> >> df -h lags, the system slows almost to a halt.  I check /proc/interrupts
> >> and
> >> /var/log/messages but no errors result.
> >>
> >> There is some type of system bottleneck when using NFS with this drive.
> >>
> >> All the file systems are XFS on all systems.
> >> Can anyone offer any suggestions?
> >> I cannot explain or find the cause of this.
> >>
> >> All systems are running 2.6.10.
> >>
> >> I have an excerpt of both using dd if=/dev/zero of=file.img (locally)
> >> and from a remote computer (on a full duplex gigabit network)
> >>
> >> Locally: dd if=/dev/zero of=out.img
> >>
> >> vmstat output:
> >>
> >> procs -----------memory---------- ---swap-- -----io---- --system--
> >> ----cpu----
> >>   r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us
> >> sy id wa
> >>   1  0    412   4928      0 662612    0    0     0     0 1065   285 16
> >> 84 0  0
> >>   1  0    412   4608      0 662556    0    0     0 78932 1148   250 14
> >> 86 0  0
> >>   1  0    412   4672      0 662868    0    0     0    13 1068   274 16
> >> 84 0  0
> >>   1  0    412   5120      0 661644    0    0     0 78928 1116   245 13
> >> 87 0  0
> >>   1  0    412   4460      0 663020    0    0     0     0 1098   254 15
> >> 85 0  0
> >>   1  0    412   5376      0 660936    0    0     0 78932 1073   279 14
> >> 86 0  0
> >>   1  0    412   5376      0 662124    0    0     0    17 1147   267 18
> >> 82 0  0
> >>   2  0    412   5376      0 661580    0    0    44 31901 1052   286 15
> >> 85 0  0
> >>   1  0    412   5440      0 661740    0    0    48 47048 1168   265 15
> >> 85 0  0
> >>   1  0    412   5312      0 662152    0    0     4    14 1048   260 16
> >> 84 0  0
> >>   1  0    412   4664      0 662196    0    0     4 78941 1143   282 15
> >> 85 0  0
> >>   2  0    412   4600      0 662932    0    0     0     0 1104   251 14
> >> 86 0  0
> >>   1  0    412   5048      0 661448    0    0     0 78954 1111   269 16
> >> 84 0  0
> >>   1  0    412   5368      0 662120    0    0     0     0 1140   250 17
> >> 83 0  0
> >>   1  0    412   5432      0 660648    0    0     0 78928 1075   260 16
> >> 84 0  0
> >>   1  0    412   5176      0 662224    0    0     4     0 1217   266 14
> >> 86 0  0
> >>   1  0    412   5432      0 662104    0    0     0     0 1078   274 16
> >> 84 0  0
> >>   1  0    412   4984      0 662084    0    0     0 78932 1189   245 12
> >> 88 0  0
> >>   1  0    412   5440      0 662012    0    0     0    13 1080   271 17
> >> 83 0  0
> >>   1  0    412   5440      0 661168    0    0     0 78928 1109   242 14
> >> 86 0  0
> >>   1  0    412   5248      0 662232    0    0     0     0 1104   270 13
> >> 87 0  0
> >>
> >> Remotely (writing over NFS, using NFS v3, not using direct I/O)
> >>
> >> vmstat output:
> >>
> >> procs -----------memory---------- ---swap-- -----io---- --system--
> >> ----cpu----
> >>   r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us
> >> sy id wa
> >>   1  0    596   4624      0 662460    0    0     0   448 4037  1099  1
> >> 99 0  0
> >>   1  0    596   4796      0 661564    0    0     0 96067 2877   788  1
> >> 75 0 24
> >>   0  0    596   5496      0 661692    0    0     0   160 2297   517  0
> >> 44 56  0
> >>   1  0    596   4824      0 662840    0    0    24   633 3896  1147  1
> >> 98 1  0
> >>   1  0    596   4696      0 662536    0    0     0   416 3987  1075  1
> >> 99 0  0
> >>   1  0    596   4892      0 662344    0    0     0   448 3746  1142  0
> >> 99 1  0
> >>   0  0    596   5868      0 660468    0    0     0 96064 3550   973  1
> >> 97 1  1
> >>   2  0    596   4600      0 663328    0    0     0   318 3390   823  1
> >> 71 28  0
> >>   1  0    596   5432      0 662336    0    0     0   448 3872  1066  0
> >> 100 0  0
> >>   1  0    596   5360      0 661888    0    0     0   453 3951  1144  1
> >> 99 0  0
> >>   1  0    596   4936      0 661568    0    0     0 94225 2942   726  0
> >> 75 7 18
> >>   1  0    596   4528      0 662944    0    0     0   259 2984   738  1
> >> 64 35  0
> >>   1  0    596   5368      0 661864    0    0     8   639 4234  1116  1
> >> 99 0  0
> >>   2  0    596   5368      0 662140    0    0     0   448 3919  1086  0
> >> 100 0  0
> >>   0  0    596   5512      0 662860    0    0     4   256 2747   650  0
> >> 56 43  1
> >>   0  0    596   5520      0 662860    0    0     0     0 1061   144  3 
> >> 2 95  0
> >>   1  0    596   4688      0 663404    0    0     0    64 1455   312  0
> >> 13 87  0
> >>   1  0    596   5324      0 661964   32    0    40 96489 3325   921  1
> >> 88 11  0
> >>   1  0    596   4656      0 662852   24    0   144  1093 2228   650  1
> >> 38 58  3
> >>   1  0    596   4592      0 662648    0    0     0   448 3852  1098  0
> >> 99 1  0
> >>   1  0    596   5304      0 662232    0    0     0   448 3972  1100  1
> >> 99 0  0
> >>
> >> -
> >> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> >> in the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> Please read the FAQ at  http://www.tux.org/lkml/
