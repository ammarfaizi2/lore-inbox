Return-Path: <linux-kernel-owner+w=401wt.eu-S1750907AbXATXrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbXATXrV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 18:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbXATXrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 18:47:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:40458 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbXATXrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 18:47:20 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WhAIxyyU6kM/nx6HRYwfFCCWSva0A3ATw5yEO46yA77RbxJRrke0y1y62nQIFOhr41LS5OX/HGspoX0/eRdpGy1gPoSM8XpHdqzE7174uE4Ok08v51eD3k7MtAnsYEHg5zCB4SihXIuldKi+H0T78r/oy/KNONuDFUv0faWAfUY=
Message-ID: <8355959a0701201547x137d7897t528bcee2538f1369@mail.gmail.com>
Date: Sun, 21 Jan 2007 05:17:18 +0530
From: "Sunil Naidu" <akula2.shark@gmail.com>
To: "Tim Schmielau" <tim@physik3.uni-rostock.de>
Subject: Re: Abysmal disk performance, how to debug?
Cc: "=?ISO-8859-1?Q?Ismail_D=F6nm?=" <ismail@pardus.org.tr>,
       "Willy Tarreau" <w@1wt.eu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0701202252550.24255@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200701201920.54620.ismail@pardus.org.tr>
	 <20070120174503.GZ24090@1wt.eu>
	 <200701201952.54714.ismail@pardus.org.tr>
	 <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de>
	 <8355959a0701201312r9a3aac4ufd151ca18ef7e64e@mail.gmail.com>
	 <Pine.LNX.4.63.0701202252550.24255@gockel.physik3.uni-rostock.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/07, Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> Yes. You have a faster Disk that writes about 45 MB/s. But I am not sure I
> understand what you want to know?

I got these results with a customized 2.6.20-rc5.

[sukhoi@Typhoon kernel]$ uname -a
Linux Typhoon 2.6.20-rc5-Topol-M #1 SMP Sun Jan 21 04:35:28 IST 2007
i686 i686 i386 GNU/Linux


> > [sukhoi@Typhoon ~]$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024; time
> > sync
> > 1024+0 records in
> > 1024+0 records out
> > 1073741824 bytes (1.1 GB) copied, 19.5007 seconds, 55.1 MB/s
> >
> > real    0m20.439s
> > user    0m0.004s
> > sys     0m4.535s
> >
> > real    0m4.625s
> > user    0m0.000s
> > sys     0m0.125s

[sukhoi@Typhoon kernel]$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024; time
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 22.7749 seconds, 47.1 MB/s

real    0m24.541s
user    0m0.005s
sys     0m3.899s

real    0m0.000s
user    0m0.000s
sys     0m0.000s

> >
> > [sukhoi@Typhoon ~]$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024 | sync
> > 1024+0 records in
> > 1024+0 records out
> > 1073741824 bytes (1.1 GB) copied, 20.8707 seconds, 51.4 MB/s
> >
> > real    0m22.449s
> > user    0m0.002s
> > sys     0m4.922s

[sukhoi@Typhoon kernel]$ time dd if=/dev/zero of=/tmp/1GB bs=1M
count=1024 | sync
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 19.8685 seconds, 54.0 MB/s

real    0m21.373s
user    0m0.003s
sys     0m3.859s

> > Linux used here is not 2.6.20-rc5, but it's a FC6 2.6.19 binary. Shall
> > post the results with 2.6.20-rc5.
> >
> > BTW, does the results vary with a customized kernel (configured w.r.t
> > Processor & Hardware) than a generic kernel like FC6?
>
> I'd guess the kernel won't make much of a difference as the time is
> mostly determined by RAM and disk speeds.

There is some deviation in the results between these 2 kernels. Is
this acceptable?

> > Are there any other such test cases?
>
> Well, what do you want to find out? Anyways, I am in no way expert in the
> field of benchmarking.

I would be trying to benchmark the results on my machines in this
fashion (overclocking experiment):-

Disk Types                                       Machine
                            RAM

SATA 1.5 GBPS  - 160 GB           P4-HT-3.0 GHz
   2x1GB Corsair
SATA 3.0 GBPS  -  320 GB          P4-HT-3.0 GHz
   2x1GB Corsair

SATA 1.5 GBPS  -  160 GB           P4-HT-3.0 GHz
   2x1GB OCZ
SATA 3.0 GBPS  -   320 GB           P4-HT-3.0 GHz
    2x1GB OCZ

SATA 1.5 GBPS  -  160 GB              P4-HT-3.0 GHz
    2x1GB Supertalent
SATA 3.0 GBPS  -   320 GB             P4-HT-3.0 GHz
    2x1GB Supertalent

SATA 1.5 GBPS  -  160 GB             P4-HT-3.0 GHz
    2x1GB Hynix
SATA 3.0 GBPS  -   320 GB            P4-HT-3.0 GHz
     2x1GB Hynix

Boards here would be used are Intel based 915, 965, and 975.

Would be happy to know more test cases - for RAM/Disk/Processor Frequency

And, I don't work for any magazine, writing a review ;-)

>
> Tim

Thanks,

~Akula2
