Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265651AbUAHRRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265653AbUAHRRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:17:43 -0500
Received: from intra.cyclades.com ([64.186.161.6]:37867 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265651AbUAHRRk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:17:40 -0500
Date: Thu, 8 Jan 2004 15:03:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: martin f krafft <madduck@madduck.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: stability problems with 2.4.24/Software RAID/ext3
In-Reply-To: <20040108151225.GA11740@piper.madduck.net>
Message-ID: <Pine.LNX.4.58L.0401081452490.30956@logos.cnet>
References: <20040108151225.GA11740@piper.madduck.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Jan 2004, martin f krafft wrote:

> Hi all,
>
> I operate a groupware server which is giving me a very hard time.
> It's an AMD Athlon XP 3000+ with 1Gb of RAM, and four 7200 UPM IDE
> harddrives, two attached to the primary channels of the onboard
> controller, and two to the primary channels of a Promise 20269 EIDE
> controller. The kernel is a 2.4.24 with the configuration I placed
> here:
>   ftp://ftp.madduck.net/scratch/config-2.4.24-gaia.gz
>
> The system is configured with 7 Software-RAID and three swap partitions:
>
>   md1:  /boot      (ext3) RAID 1 spanning hda1 and hdc1
>   md5:  /          (ext3) RAID 5 hda5/hdc5/hde5 with hdg5 as a spare
>   md6:  /usr       (ext3) RAID 5 hda6/hdc6/hde6 with hdg6 as a spare
>   md7:  /var       (ext3) RAID 5 hda7/hdc7/hde7 with hdg7 as a spare
>   md8:  /usr/local (ext3) RAID 5 hda8/hdc8/hde8 with hdg8 as a spare
>   md9:  /home      (ext3) RAID 5 hda9/hdc9/hde9 with hdg9 as a spare
>   md10: /tmp       (ext3) RAID 5 hda10/hdc10/hde10 with hdg10 as a spare
>
>   hda2 holds a non-RAID rescue system with RAID 1/5 supporrt
>
>   hdc2, hde2, hdg2 are swap partitions of 256 Mb each.
>
>   hde1 and hdg1 are unused.
>
> The individial harddisks are identically tweaked with hdparm:
>
>   hdparm -A1 -B255 -c1 -d1 -p -u0 -W0 -Xudma6 /dev/hd{a,c,e,g}
>
> See the end of this mail for details.
>
> The system experiences severe stability problems, which I relate to
> the filesystem, RAID, or controller code, because it's reproducible
> with excessive disk operations. E.g., doing something like
>
>   rsync -a --exclude /tmp / /tmp/dump

<snip>

> Interestingly, just now, the machine crashed differently. `vmstat 1`
> was still running, but new processes could not be started, after the
> kernel reported a lot of oopses in user-space processes (e.g. rsync,
> top, zsh), as well as some of the kjournald oopses like above.
> I have included the footprint of the user-space program oopses
> further down. `vmstat 1` was happily printing the following away,
> when the system was already unusable. The b > 127 value is
> interesting, as it has been continuously increasing (well, in
> a non-decreasing way) after a certain point, and somewhere on the
> way, the system reached the state of agnosia.
>
>  0 127  2  16124  10304  43004 682188   0   0     0     0  109     7   0   0 100
>  0 127  2  16124  10304  43004 682188   0   0     0     0  111     5   0   0 100
>  0 127  2  16124  10304  43004 682188   0   0     0     0  114     9   0   0 100
>  0 127  2  16124  10304  43004 682188   0   0     0     0  111     5   0   0 100
>  0 127  2  16124  10304  43004 682188   0   0     0     0  115     9   0   0 100
>  0 128  2  16124  10420  43004 682060   0   0     0     0  119    12   0   0 100
>  0 128  2  16124  10420  43004 682060   0   0     0     0  122    11   0   0 100
>
> Apart from these panics and hangups, the system also randomly issues
> segfaults to processes, or reports a kernel oops. These take the
> following form:

Hi Martin,

I can't help you much, but I believe your problem might be related to
faulty hardware. Have you checked if the memory OK ?

Try disabling DMA on the Promise?
