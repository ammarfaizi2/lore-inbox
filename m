Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129633AbQJZXH3>; Thu, 26 Oct 2000 19:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130370AbQJZXHL>; Thu, 26 Oct 2000 19:07:11 -0400
Received: from [211.58.56.18] ([211.58.56.18]:48099 "EHLO mo3.hananet.net")
	by vger.kernel.org with ESMTP id <S129633AbQJZXHE>;
	Thu, 26 Oct 2000 19:07:04 -0400
Date: Fri, 27 Oct 2000 08:06:47 +0900 (KST)
From: Byeong-ryeol Kim <jinbo21@hananet.net>
Reply-To: Byeong-ryeol Kim <jinbo21@hananet.net>
To: Klaus Naumann <kernel@mgnet.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: QLOGIC Fibre Channel init
In-Reply-To: <39F8221E.6FE5F25E@mgnet.de>
Message-ID: <Pine.LNX.4.21.0010270737160.21026-100000@progress.plw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2000, Klaus Naumann wrote:

> Byeong-ryeol Kim wrote:
> > 
> > On Thu, 26 Oct 2000, Klaus Naumann wrote:
> > 
> > > I was having some little trouble with the QLOGIC Fibre Channel SCSI
> > > cards.
> > > The issue is, that I have a box with an internal SCSI controller/disk
> > > and a QLOGIC card which is connected to an external RAID. The probelm
> > > is, that the internal disk is my root disk but is the second in the
> > > chain (sdb) after bootup. This gives a lot of problems, because it's
> > > impossible to get the system to boot (LILO isn't working).
> > > Since I've modified the hosts.c it's working perfectly (at least the
> > > order is better now). Patch is attached.
> > > Can anyone give a comment on that please ?
> > ....
> > 
> > Hello,
> > Your patch would be good, but there is another simple method.
> > Did you happen to make the BIOS of Qlogic FC adapter enable to
> > boot the machine?
> > If so, while POST, timely hit 'Ctrl + Q', and disable boot
> > ability in BIOS setting of it.
> 
> No, I have the bios of the controller disabled.
> The problem with that is that on boot up (for lilo) the internal disk
> is disk number one. But when I'm in the system and want to install lilo
> it's disk number two - that's what lilo is complaining about on boot up.
> (By spewing out an L and a 01 01 01 01 and so on).
> Activating the bios of the QLOGIC (to make the internal disk appear
> to be the 2nd one on bootup) didn't solve the problem too - I simply
> got a message saying I should insert a system disk ;)
....

Aha, I forgot to describe about making qlogic drivers as a module.
While I had been setting and testing SAN switch(Brocade, Gadzoox),
RAID with Qlogic 2100(or 2200A), I had the same experience that you 
described in the previous mail, and solved the problem by patching 
drivers/scsi/hosts.c as you did. It was a good solution.
But, I became aware of the convenience and flexibility of modular 
drivers(or initrd) in this case.
Because, I thought, whenever I do the same test or benchmarking, 
rebooting the system each is terrible. 
In that method, I experienced no problem such that you described 
in the previous E-mail.

-- 
 "Where there is a will, there is a way."  jinbo21@hananet.net
  For the future of you and me!            hitel: jinbo21

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
