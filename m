Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbTIOItX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 04:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbTIOItX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 04:49:23 -0400
Received: from mail.vtc.edu.hk ([202.75.80.229]:58458 "EHLO pandora.vtc.edu.hk")
	by vger.kernel.org with ESMTP id S262342AbTIOItU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 04:49:20 -0400
Message-ID: <3F657CFD.96B5E974@vtc.edu.hk>
Date: Mon, 15 Sep 2003 16:49:02 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-20.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Debugging hard lockups (hardware?): Power Supply!
References: <3E8FC9FB.A030ACFB@vtc.edu.hk> <1049654048.1600.11.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Folks,

Alan Cox wrote:

> On Sul, 2003-04-06 at 07:32, Nick Urbanik wrote:
> > This machine locks up solid every few days.  Caps Lock, Num Lock, Scroll Lock do
> > not respond.  The NMI watchdog does not kick in.
>
> For the NMI watchdog to fail (if you have it enabled) requires pretty
> major disaster to have occurred since the NMI will be delivered through
> any kind of system hang
>
> > I guess hardware.  But memtest run exhaustively shows no problem.
>
> Memory errors normally generate "Oops" type lines rather than other
> stuff
>
> > I have six 80 G IDE disks, software RAID, LVM on top.  On Red Hat 8.0 and 9.
> >
> > Any hints on how to troubleshoot this (besides replacing motherboard and other
> > components I cannot afford to replace?)
>
> Is your PSU up to scratch for six disks ?

It seems that the 470W ToTheMax power supply was the problem, though I've not tested
for more than 17 hours yet.

Yesterday, after adding two disks to the motherboard IDE together with the new 3ware
7506-8 with 8 x 80G disks (a total of 10 disks), the 3ware RAID 5 unit refused to
rebuild.  Then I noticed that many dma timeout messages appeared in the logs for all
the disks.  I promptly shut the system down, took my little boy Linus for a walk to
the fabled Golden Shopping Center and bought an Antec 550W supply, plus a few more
case fans.  The 3ware RAID5 unit, and also the kernel md RAID1 built nicely.  So far
no dma_intr messages have appeared (and it has not locked up).

I wish I had changed the power supply before buying the 3ware card so that I could
find out whether the Si680 cards were okay or not!  HK$135 * 3 <<< HK$3800 (comparing
price of 3 Si680 cards with one 3ware 7506-8).  Unfortunately the disks cannot be
moved from the 3ware back to the Si680s without another mighty backup and restore.

> > /dev/md3:
> >  Timing buffer-cache reads:   128 MB in  0.35 seconds =365.71 MB/sec
> >  Timing buffered disk reads:  64 MB in 21.93 seconds =  2.92 MB/sec
> > (last horribly. slow; get zillions of lines in syslog saying stuff like:
> > Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 0 --> 4096
> > Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 0 --> 1024
> > Apr  6 14:08:50 nicksbox kernel: raid5: switching cache buffer size, 1024 -->
>
> Im not sure what this one indicates actually
>
> > Any pointers to web sites, information that may help, any hints, suggestions,
> > ideas,... all most welcome.  Actually, if replacing the motherboard would fix
> > it, I'd do it, but I cannot guess why it should help; Asus motherboards have
> > always been good to me before.
>
> Your choice of components looks fine, its all stuff I trust, even if the
> ethernet card is not good for performance it ought to be fine in
> general. If it is a faulty part most likely its a one off fault.
>
> Which bits of the system are not being used (sound, video, network ?)

--
Nick Urbanik   RHCE                               nicku(at)vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8713          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24



