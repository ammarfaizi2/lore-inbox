Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbSJTS65>; Sun, 20 Oct 2002 14:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264021AbSJTS64>; Sun, 20 Oct 2002 14:58:56 -0400
Received: from ns1.system-techniques.com ([199.33.245.254]:65241 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S264010AbSJTS6z>; Sun, 20 Oct 2002 14:58:55 -0400
Date: Sun, 20 Oct 2002 15:02:50 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: davidsen <root@tmr.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: NCR adaptor doesn't see devices (was: 2.5.43 aic7xxx segfault)
In-Reply-To: <Pine.LNX.3.96.1021020143039.452A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0210201436260.9763-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Bill ,

On Sun, 20 Oct 2002, Bill Davidsen wrote:
> No, the sym-anything seems to be for the newer chopsets, and not the old
> ncr825. I believe I tried 2.5.38 or so with that driver and it couldn't
> find a device it liked. I'll try building that module again, but it didn't
> work and I thought it might be causing a problem trying.
	Iirc ,  Gerard said that the Sym-2 is for all chipsets again .
	see: linux/drivers/scsi/sym53c8xx_2/Documentation.txt
	The ncr53c8xx was the original driver that he produced .  Then
	came the sym53c8xx version which was NOT for the older chips
	supported by the ncr53c8xx.c .

> Also note that the driver inserts and fails twice (see dmesg) which is not
> intuitive to me.
	Yes , I noted them below using a grep of your document .  It
	appears that the SYM53c8xx driver gets loaded   THEN the
	ncr53c8xx attempts to load & of course conflicts with the
	SYM53c8xx .  These two drivers can not co-exist ,  Without very
	special care as to how they get loaded or some such .
	I still highly recommend the sym2 driver rather than either of
	the two being loaded .  But if it won't recognise the drives ...
		Hth ,  JimL

--
       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

dmesg-2.5.43-mm2p1:227:sym53c8xx: at PCI bus 0, device 9, function 0
dmesg-2.5.43-mm2p1:228:sym53c8xx: not initializing, device not supported
...
dmesg-2.5.43-mm2p1:279:ncr53c8xx: at PCI bus 0, device 9, function 0
dmesg-2.5.43-mm2p1:280:ncr53c8xx: 53c825 detected
dmesg-2.5.43-mm2p1:281:ncr53c825-0: rev 0x2 on pci bus 0 device 9 function 0 irq 9
dmesg-2.5.43-mm2p1:282:ncr53c825-0: ID 7, Fast-10, Parity Checking
dmesg-2.5.43-mm2p1:283:scsi1 : ncr53c8xx-3.4.3b-20010512
dmesg-2.5.43-mm2p1:284:ncr53c825-0-<2,*>: target did not report SYNC.
...
dmesg-2.5.43-mm2p1:293:ncr53c825-0: releasing host resources
dmesg-2.5.43-mm2p1:294:ncr53c825-0: resetting chip
dmesg-2.5.43-mm2p1:295:ncr53c825-0: host resources successfully released
...
dmesg-2.5.43-mm2p1:303:ncr53c8xx: at PCI bus 0, device 9, function 0
dmesg-2.5.43-mm2p1:304:ncr53c8xx: 53c825 detected
dmesg-2.5.43-mm2p1:305:ncr53c825-0: rev 0x2 on pci bus 0 device 9 function 0 irq 9
dmesg-2.5.43-mm2p1:306:ncr53c825-0: ID 7, Fast-10, Parity Checking
dmesg-2.5.43-mm2p1:307:scsi1 : ncr53c8xx-3.4.3b-20010512
dmesg-2.5.43-mm2p1:308:ncr53c825-0-<2,*>: target did not report SYNC.
...
dmesg-2.5.43-mm2p1:311:ncr53c825-0: releasing host resources
dmesg-2.5.43-mm2p1:312:ncr53c825-0: resetting chip
dmesg-2.5.43-mm2p1:313:ncr53c825-0: host resources successfully released

