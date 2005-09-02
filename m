Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbVIBUEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVIBUEs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVIBUEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:04:48 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:902 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750759AbVIBUEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:04:47 -0400
Subject: Re: IDE HPA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: pjones@redhat.com
Cc: "ATARAID (eg, Promise Fasttrak, Highpoint 370) related discussions" 
	<ataraid-list@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1125688483.31292.20.camel@localhost.localdomain>
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <1125419927.8276.32.camel@localhost.localdomain>
	 <87941b4c050830095111bf484e@mail.gmail.com>
	 <62b0912f0509020027212e6c42@mail.gmail.com>
	 <1125666332.30867.10.camel@localhost.localdomain>
	 <62b0912f05090206331d04afd3@mail.gmail.com>
	 <E1EBCdS-00064p-00@chiark.greenend.org.uk>
	 <62b0912f05090209242ad72321@mail.gmail.com>
	 <1125680712.30867.20.camel@localhost.localdomain>
	 <62b0912f05090210441d3fa248@mail.gmail.com>
	 <1125684567.31292.2.camel@localhost.localdomain>
	 <1125687557.30867.26.camel@localhost.localdomain>
	 <1125688483.31292.20.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Sep 2005 21:22:58 +0100
Message-Id: <1125692578.30867.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-02 at 15:14 -0400, Peter Jones wrote:
> Ugh.  So some BIOSes use it for legitimate reasons (like thinkpads), and
> some use it to work around BIOS bugs.  Great.

All are legitimate uses. The partition table tells you which.

> Mine didn't, but it does have an HPA.  Thankfully we weren't disabling
> it yet when I installed my laptop -- I know others who weren't so lucky.
> So this partitioning scheme hasn't always been the case...

You installed it on Red Hat 7 ? I think 7, may have been 6.x or earlier.
This behaviour goes back pretty much to the creation of the ATA spec for
HPA. In fact if it was that long ago IBM shipped it with Windows so it
did have a partition table!

> It really sounds better (to my naive mind, at least) to whitelist the
> known-broken BIOSes.

Not really practical. You'd have to list most older PC systems.

> Well, installers probably should be aware, yes -- that's why I mentioned
> userland interfaces to enabling/disabling.  But to me it still seems
> like we want to disable the HPA during installation and bootup, but only
> if your BIOS is doing things wrong.

"Wrong" is a poor term here.

If the system has a partition table that doesn't cover the post HPA area
and its about the right size we can be fairly sure the right choice is
to honour the HPA, if its a randomly different size its a fair bet the
disk got moved

If the partition table exceeds the no HPA area of disk but not the full
disk then its almost certainly right the HPA should be disabled post
boot. If it exceeds both its a raid 0 volume of some form...


