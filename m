Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbVKZQcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbVKZQcS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 11:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbVKZQcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 11:32:17 -0500
Received: from drugphish.ch ([69.55.226.176]:64413 "EHLO www.drugphish.ch")
	by vger.kernel.org with ESMTP id S1422660AbVKZQcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 11:32:17 -0500
Message-ID: <43888E0C.8070806@drugphish.ch>
Date: Sat, 26 Nov 2005 17:32:12 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Thunderbird 1.4.1 (X11/20051006)
MIME-Version: 1.0
To: Andreas Haumer <andreas@xss.co.at>
Cc: Willy Tarreau <willy@w.ods.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4.31 + aic79xx] SCSI error: Infinite interrupt loop, INTSTAT
 = 0
References: <43838ECC.5060204@xss.co.at> <20051124053952.GI11266@alpha.home.local> <4385BA96.1080804@xss.co.at> <20051124232210.GB23855@alpha.home.local> <438882C6.20402@xss.co.at>
In-Reply-To: <438882C6.20402@xss.co.at>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Yesterday the new LSI Logic hostadapters arrived. I replaced the
> Adaptec 29320 controllers with the new LSI boards and did various
> tests.
> 
> Executive summary: with the LSI controllers everything works fine!

During the past 2 years we have also changed our HW configuration
regarding SCSI from Adaptec to LSI. Always patching the kernel (2.2.x
and 2.4.x) with gibbs' code was too cumbersome and on top of that we
experienced similar interrupts and I/O aborts. Not being too familiar
with indepth SCSI technology we had to go with what proved (seemed) to
work more reliable in the long term, which were LSI based SCSI controllers.

> 01:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 08)
> 01:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 08)

[...]

> Fusion MPT base driver 2.05.16
> Copyright (c) 1999-2004 LSI Logic Corporation
> mptbase: Initiating ioc0 bringup
> ioc0: 53C1030: Capabilities={Initiator}
> mptbase: Initiating ioc1 bringup
> ioc1: 53C1030: Capabilities={Initiator}
> mptbase: 2 MPT adapters found, 2 installed.
> Fusion MPT SCSI Host driver 2.05.16
> scsi2 : ioc0: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=222, IRQ=28
> scsi3 : ioc1: LSI53C1030, FwRev=01030a00h, Ports=1, MaxQ=222, IRQ=29
>   Vendor: IFT       Model: A16U-G2421        Rev: 342A
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> blk: queue f7ae9018, I/O limit 4294967295Mb (mask 0xffffffffffffffff)
>   Vendor: IFT       Model: A16U-G2421        Rev: 342A
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> blk: queue f723de18, I/O limit 4294967295Mb (mask 0xffffffffffffffff)

[...]

> I will have this particular hardware setup available for
> testing for about two or three days (until end of next Tuesday).
> If anyone wants me to try any patches for the aic79xx driver in
> this timeframe I'm willing to do so if time permits.

More related to LSI, but would you be willing to try following for me
and report back (in private, since this is getting off-topic), please:

http://www.drugphish.ch/~ratz/mpt-status/mpt-status-1.1.4.tar.bz2

And if it does not compile on your 2.4.x system, use the following patch:

http://www.drugphish.ch/~ratz/mpt-status/mpt-status-1.1.4-fix-compilation-on-2.4.x-1.diff

It should allow you to do basic HW raid monitoring on LSI-53C1030 chipsets.

Thanks and good luck,
Roberto Nibali, ratz
-- 
echo
'[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
