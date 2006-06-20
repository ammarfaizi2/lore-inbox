Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWFTKTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWFTKTs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWFTKTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:19:48 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:2178 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932564AbWFTKTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:19:47 -0400
Date: Tue, 20 Jun 2006 12:19:46 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Jean-Daniel Pauget <jd@disjunkt.com>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       bert hubert <bert.hubert@netherlabs.nl>, george@mvista.com
Subject: Re: Linux 2.6.17: PM-Timer bug warning?
Message-ID: <20060620101946.GA32658@rhlx01.fht-esslingen.de>
References: <20060620100800.GB5040@disjunkt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620100800.GB5040@disjunkt.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CC'ing further interested parties - sorry, a bit late in the discussion]

Hi,

On Tue, Jun 20, 2006 at 12:08:00PM +0200, Jean-Daniel Pauget wrote:
>     On Tue Jun 20, 2006 at 08:41:45 Andreas Mohr wrote :
> 
> >    OGAWA Hirofumi initially posted a test app:
> >
> >    http://marc.theaimsgroup.com/?l=linux-kernel&m=114297656924494&w=2
> >
> >    and there were lots of PM-Timer abandon triple-read optimization
> >    LKML discussions quite recently where one can read on that topic...
> >
> >    Thanks for your testing help, it's very important!
> 
>     fine !
>     though my hardware is in the gray list, it didn't trigger the bug with 
>     OGAWA's test.

[dual P4 Xeon board]

Interesting, so it likely isn't buggy.

Could you give lspci -v -v or so (to let us see chipset and revisions)?

Oh wait, you already did:

| 00:00.0 Host bridge: Intel Corporation E7505 Memory Controller Hub (rev 03)
| 00:01.0 PCI bridge: Intel Corporation E7505/E7205 PCI-to-AGP Bridge (rev 03)
| 00:02.0 PCI bridge: Intel Corporation E7505 Hub Interface B PCI-to-PCI Bridge
| +(rev 03)
| 00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
| +USB UHCI Controller
| #1 (rev 01)
| 00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
| +USB UHCI Controller
| #2 (rev 01)
| 00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
| +USB UHCI Controller
| #3 (rev 01)
| 00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI
| +Controller (rev 01)
| 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 81)
| 00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL (ICH4/ICH4-L) LPC Interface
| +Bridge (rev 01)
| 00:1f.1 IDE interface: Intel Corporation 82801DB (ICH4) IDE Controller (rev 01)
| 00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus
| +Controller (rev 01)
| 00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM
| +(ICH4/ICH4-L/ICH4-M) AC'97
| Audio Controller (rev 01)


>     but now, how and to whom should I report ?

We need to enhance current kernel to whitelist this chipset revision
somehow. Or at least put a note there that this revision is ok, too
(to wait some more time for further evidence/revisions to appear).

>     about using other clocksource(s), where should we dig for ?

You mean e.g. the clock=tsc boot parameter?

Andreas Mohr
