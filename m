Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287929AbSABTfA>; Wed, 2 Jan 2002 14:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287927AbSABTeu>; Wed, 2 Jan 2002 14:34:50 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43530
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S287919AbSABTee>; Wed, 2 Jan 2002 14:34:34 -0500
Date: Wed, 2 Jan 2002 11:31:40 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Krzysztof Oledzki <ole@ans.pl>
cc: Brian <hiryuu@envisiongames.net>, linux-kernel@vger.kernel.org
Subject: Re: Two hdds on one channel - why so slow?
In-Reply-To: <Pine.LNX.4.33.0201021808490.9573-100000@dark.pcgames.pl>
Message-ID: <Pine.LNX.4.10.10201021052090.10050-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Brian,

This was true in the past and with many older drivers.  However when and
if the new driver I have is adpoted, it will make SCSI cry.  So please
stop polluting the issue.

Let me be as objective as I can be.

I built a special Mylex 3-channel raid 10 systems using 6 15K drive at
Ultra160.  Given that I was clever, I was able to push that system to read
and write at 170MB/sec.  I was very impressed by this performance, however
this was hardware raid, caching of 256MB, and 66/64 pci bus.  This was a
dual PIII w/ 2GB of EEC-Buffered-Registered.

Now I have managed to use two hosts w/ 4 channels no caching controller,
no hardware raid, 4 7200RPM drives and software raid 0.  I was able to
push 109MB/sec writing and 167MB/sec reading.

Also under a similar environment, I was able to, using a single card, 4
drives, not hardware-raid, no caching controller, reach 90MB/sec writing
and reading was about 78MB/sec.

Now lets adjust cost of componets and SCSI loses big.
Once there are 10K ATA drives in the market, and none exist that I know of
to date even in beta, then we can retest .

In the meantime here is another dose of reality.

http://www.tecchannel.de/hardware/817/index.html

Regards,

Andre Hedrick
Linux ATA Development

On Wed, 2 Jan 2002, Krzysztof Oledzki wrote:

> 
> 
> On Tue, 1 Jan 2002, Brian wrote:
> 
> > This is an inherent quirk (SCSI folks would say brain damage) in IDE.
> >
> > Only one drive on an IDE chain may be accessed at once and only one
> > request may go to that drive at a time.  Therefore, the maximum you could
> > hope for in that test is half speed on each.  Throw in the overhead of
> > continuously hopping between them and 12MB is no surprise.
> 
> So?!? This ATA100 and ATA133 standards do not make any sens? It is not
> possible to have more than 66 MB/sec with on drive and is seems that it is
> not possible to use more than ~30MB/sek of 100 or 133 MB/sec ATA100/133
> bus speed with two HDDs. Oh :(((
> 
> Another question - why ATA100/ATA66 HDDs are so slow with UDMA33?
> With new IBM 60 GB IC35L060AVER07-0 I have much more than 33 MB/sec with
> ATA100 and only 24 MB/sec with UDMA33 (Asus P2B with IntelBX). New 80GB Seagates
> (Baracuda IV) have the same problem.
> 
> Best regards,
> 
> 			Krzysztof Oledzki
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


