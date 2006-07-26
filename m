Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWGZHIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWGZHIe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 03:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWGZHIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 03:08:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:51500 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932498AbWGZHId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 03:08:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QZULsPj+eVLefyC7YTWNx1fBtQuzXfQ0HMyGXCGujt/7k8pNkMLp+f+RAhXX8FTW0S52VUtgnnKgrOY+54TY6vYMafjW+IVu1zbFJhCL/gyL0JLL+mQIa+3gsiK6xau3U/vbXpoY0CMJcq/48huauPfmZE0OMszzmKhs6klahA4=
Message-ID: <17d79880607260008p5879df5bka4c279f727e9fe31@mail.gmail.com>
Date: Wed, 26 Jul 2006 03:08:31 -0400
From: Allison <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Physical Memory Snapshot
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the answer. If I use this PCI device and say I want to
fetch only one page. Can I be sure that the DMA is atomic ? i.e when
the device uses the memory bus, there won't be any writes from the CPU
till the DMA transfer is complete ? or can the PCI DMA be interrupted
in between ?

thanks,
Allison


Stefan Richter wrote:
> Valdis.Kletnieks@vt.edu wrote:
> > On Tue, 18 Jul 2006 12:16:16 EDT, Allison said:
> >
> >> 2. How do I make sure that no updates take place in memory from the
> >> time I initiate the snapshot till it is done.
> >
> > Hint: If you're running a program to dump memory, it's going to be calling
> > I/O drivers and so on - and all this activity has to modify at least *some*
> > memory (unless you're on an architecture with a *really* deep register stack ;)
> > You can't ensure that *no* updates take place.  At best, you can minimize
> > the number of pages touched.
> >
> > For an example of the kind of hoops you need to jump through, I suggest a
> > careful reading of the 'suspend' and/or 'suspend2' source code - a large part
> > of that code is basically taking a snapshot of memory.
>
> This can be avoided by dumping the memory remotely via FireWire. All one
> needs is PCI and a FireWire card in both machines, the ohci1394 driver
> with default parameters loaded on the machine where you want to get the
> memory dump from, and a tool like "firescope" on the remote machine.
> http://www.linux1394.org/links.php
>
> Software on the remote node B is able to fetch data from the node A
> without _any_ software assistence on node A once A's FireWire controller
> was initialized in the default mode. (BTW, because of the security
> implications of this hardware feature, do not attach untrusted devices
> to your PC's FireWire port or do not load ohci1394 or load ohci1394 only
> with the parameter phys_dma=0.)
>
> > Also, you'll need to make sure that whatever software is running that
> > you're trying to snapshot is fairly tolerant of pauses - if you have a
> > disk that manages 20MBytes/second and you have 256M of memory, you're going
> > to be sitting there for 10 seconds. This can come as a surprise to programs
> > that were sleeping on a timer interrupt.. :)
>
> Of course the need to stop the program whose memory you want to debug
> during the whole time required for the dump remains with the FireWire
> method too. It can be alleviated if you only dump a small known range of
> physical addresses.
>
> You can get about 25 MB/s out of FireWire 400 if both machines run Linux
> (about 35 MB/s if you add a Windows, Mac OS, or OS X box as second or
> third box or use a tool like 1394commander to emulate a certain feature
> which is missing in Linux' FireWire drivers) but more if you have
> FireWire 800.
> --
> Stefan Richter
> -=====-=-==- -=== -====
> http://arcgraph.de/sr/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
