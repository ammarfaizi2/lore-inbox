Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131510AbQKNWty>; Tue, 14 Nov 2000 17:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131546AbQKNWto>; Tue, 14 Nov 2000 17:49:44 -0500
Received: from et-gw.etinc.com ([207.252.1.2]:30212 "EHLO etinc.com")
	by vger.kernel.org with ESMTP id <S131510AbQKNWtg>;
	Tue, 14 Nov 2000 17:49:36 -0500
Message-Id: <5.0.0.25.0.20001114171416.01f7b8f0@mail.etinc.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Tue, 14 Nov 2000 17:18:25 -0500
To: <michael@pmcl.ph.utexas.edu>, "Allen, David B" <David.B.Allen@chase.com>
From: Dennis <dennis@etinc.com>
Subject: RE: intel etherpro100 on 2.2.18p21 vs 2.2.18p17
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011111111390.18876-100000@pmcl.ph.utexas.e
 du>
In-Reply-To: <93BA6BFC5E48D4118A8200508B6BBC4924AB7A@sf1-mail01.hamquist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:15 PM 11/11/2000, michael@pmcl.ph.utexas.edu wrote:
>We have the SUPER 370DL3 SuperMicro boards w/ the integrated Intel NIC,
>unfortunately a warm boot does not help.  The problem also seems to happen
>when I turn on the alias ip feature in the kernel under network options.
>
>
>On Fri, 10 Nov 2000, Allen, David B wrote:
>
> > FWIW, I have a dual-proc SuperMicro motherboard P3DM3 with integrated
> > Adaptec SCSI and Intel 8255x built-in NIC.
> >
> > Sometimes on a cold boot I get the "kernel: eth0: card reports no RX
> > buffers" that repeats, but if I follow it with a warm boot the message
> > doesn't appear (even on subsequent warm boots).  So this is definitely
> > reproducible, but it doesn't happen every time.
> >
> > I can't offer much more than that, but at least you know you're not the 
> only
> > one experiencing this.
> >

There is a flaw in the eepro100 driver that apparently doesnt initialise 
something properly. The problem is exasperated by the fact that the 
eepro100 driver doesn handle the buffer problem properly. We've corrected 
it by (effectively) resetting the card (by calling close and then open) 
when the first out of resources event occurs. Its not elegant, but it seems 
to work.

We have identical hardware with dual boot disks (linux and freebsd) and the 
problem only occurs with linux, and it only seems to occur with  linux. Of 
course on the DLE supermicro boards FreeBSD complains about an unsupport 
PHY, so there is no joy in mudville no matter what you do :-)

Dennis

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
