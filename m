Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291766AbSBAOcu>; Fri, 1 Feb 2002 09:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291769AbSBAOcj>; Fri, 1 Feb 2002 09:32:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28423 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291768AbSBAOcV>; Fri, 1 Feb 2002 09:32:21 -0500
Subject: Re: [ANNOUNCE] LVM reimplementation ready for beta testing
To: arjanv@redhat.com (Arjan van de Ven)
Date: Fri, 1 Feb 2002 14:44:24 +0000 (GMT)
Cc: thornber@fib011235813.fsnet.co.uk (Joe Thornber),
        arjanv@redhat.com (Arjan van de Ven), lvm-devel@sistina.com,
        Jim@mcdee.net (Jim McDonald), adilger@turbolabs.com (Andreas Dilger),
        linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
        evms-devel@lists.sourceforge.net
In-Reply-To: <20020201051251.B10893@devserv.devel.redhat.com> from "Arjan van de Ven" at Feb 01, 2002 05:12:51 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WevQ-0005H0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But "flushes all pending io" is *far* from trivial. there's no current
> kernel functionality for this, so you'll have to do "weird shit" that will
> break easy and often.
> 
> Also "suspending" is rather dangerous because it can deadlock the machine
> (think about the VM needing to write back dirty data on this LV in order to
>  make memory available for your move)...

I don't think you need to suspend I/O except momentarily. I don't use LVM and
while I can't resize volumes I migrate them like this

	mdhotadd /dev/md1 /dev/newvolume

[wait for it to resync]

	mdhotremove /dev/md1 /dev/oldvolume

the situation here seems analogous. You never need to suspend I/O to the
volume until you actually kill it, by which time you can just skip the write
to the dead volume.

(The above procedure with ext3 does btw make a great backup system 8))

Alan
