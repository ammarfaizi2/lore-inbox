Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317674AbSGaDPl>; Tue, 30 Jul 2002 23:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317691AbSGaDPl>; Tue, 30 Jul 2002 23:15:41 -0400
Received: from smtprelay7.dc2.adelphia.net ([64.8.50.39]:56810 "EHLO
	smtprelay7.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S317674AbSGaDPk>; Tue, 30 Jul 2002 23:15:40 -0400
Message-ID: <004501c23841$03265a30$6a01a8c0@wa1hco>
From: "jeff millar" <wa1hco@adelphia.net>
To: "Bill Davidsen" <davidsen@tmr.com>,
       "Jakob Oestergaard" <jakob@unthought.net>
Cc: "Kernel mailing list" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020730223102.6974A-100000@gatekeeper.tmr.com>
Subject: Re: RAID problems
Date: Tue, 30 Jul 2002 23:18:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Bill Davidsen" <davidsen@tmr.com>
To: "Jakob Oestergaard" <jakob@unthought.net>
Cc: "Kernel mailing list" <linux-kernel@vger.kernel.org>
Sent: Tuesday, July 30, 2002 10:46 PM
Subject: Re: RAID problems


> On Tue, 30 Jul 2002, Jakob Oestergaard wrote:
>
> > On Tue, Jul 30, 2002 at 01:25:37PM -0400, Bill Davidsen wrote:
>
> > > Why does no one seem surprised that one drive failed and the system
marked
> > > four bad instead of using the spare in the first place? That's a more
> > > interesting question.
> >
> > As stated in the above URL (no shit, really!), this can happen for
> > example if some device hangs the SCSI bus.
>
> I think you misread my comment, it was not "why doesn't the documentation
> say this" but rather "why does software RAID have this problem?" I know
> this can happen in theory, but it seems that the docs imply that this
> isn't a surprise in practice. I've been running systems with SCSI RAID and
> hardware controllers since 1989 (or maybe 1990), I've got EMC and HDS
> boxes, aaraid and ipc controllers, Promise and CMC(??) on system boards,
> and a number of systems running software RAID. And of all the drive
> failures I've had, exactly one had more than one drive fail, and that was
> in a power {something} issue which took out multiple drives and system
> boards on many systems.
>
> I just surprised that the software RAID doesn't have better luck with
> this, I don't see any magic other than maybe a bus reset the firmware
> would be doing, and I'm wondering why this seems to be common with Linux.
> Or am I misreading the frequency with which it happens?
>
> > Did *anyone* read that section ?!?   ;)
> >
> > If someone feels the explanation there could be better, please just send
> > the better explanation to me and it will get in.  Really, this section
> > is one of the few sections that I did *not* update in the HOWTO, because
> > I really felt that it was still both adequate (since no-one has demanded
> > elaboration) and correct.
>
> Thye words are clear, I'm surprised at the behaviour. Yes, I know that's
> not your thing.
>
> --
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.

In the 3 weeks since installing Linux software raid-5 (3 x 80 GB), I had to
reinitialize the raid devices twice (mkraid --force)...once due to an abrupt
shutdown and once due to some weird ATA/ATAPI/drive problem that caused a
disk to begin "clicking" spasmodically...and left the raid array all out of
whack..

Linux software raid seems very fragile and very scary to recover.  I feel a
much stronger need for backup with raid than without it.

Raid needs an automatic way to maintain device synchronization.  Why should
I have to...
    manually examine the device data (lsraid)
    find two devices that match
    mark the others failed in /etc/raidtab
    reinitialize the raid devices...putting all data at risk
    hot add the "failed" device
    wait for it to recover (hours)
    change /etc/raidtab again
    retest everything

This is 10 times worse that e2fsck and much more error prone.  The file
system guru's worked hard on journalling to minimize this kind of risk.

jeff

