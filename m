Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288356AbSAHVF4>; Tue, 8 Jan 2002 16:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288344AbSAHVFr>; Tue, 8 Jan 2002 16:05:47 -0500
Received: from cc5993-b.ensch1.ov.nl.home.com ([212.204.161.160]:19461 "HELO
	packetstorm.nu") by vger.kernel.org with SMTP id <S288356AbSAHVFc>;
	Tue, 8 Jan 2002 16:05:32 -0500
Reply-To: <alex@packetstorm.nu>
From: "Alex Scheele" <alex@packetstorm.nu>
To: "Andrew Morton" <akpm@zip.com.au>
Cc: <heckmann@hbe.ca>, "Lkml" <linux-kernel@vger.kernel.org>
Subject: RE: [problem captured] Re: cerberus on 2.4.17-rc2 UP
Date: Tue, 8 Jan 2002 22:05:24 +0100
Message-ID: <IOEMLDKDBECBHMIOCKODMECOCFAA.alex@packetstorm.nu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3C3B579D.7B8E534F@zip.com.au>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> 
> Alan Cox wrote:
> > 
> > > end_request: buffer-list destroyed
> > > hda1: bad access: block=12440, count=-8
> > > end_request: I/O error, dev 03:01 (hda), sector 12440
> > > hda1: bad access: block=12448, count=-16
> > 
> > That looks like a race in the IDE/block layer (or somewhere 
> above it maybe)
> > Someone trashed a request in progress.
> > 
> > > Is this a bug or could it be the hardware's fault? The 
> hardware is new lspci
> > 
> > Other people have reported it too. Its clearly a kernel race
> 
> Yes, I can generate it at will on two quite different IDE machines
> with the run-bash-shared-mapping script from
> http://www.zip.com.au/~akpm/ext3-tools.tar.gz
> 
> It's on my list of things-to-do, filed under "hard".  It even happens
> on uniprocessor, with unmask_irq=0.
> 
> Interestingly, I _think_ it only ever occurs against the
> swap device.  But I need to confirm this.  Marc, do you
> have swap on /dev/hda1?

I have had this problem on several machines to. But not only 
against the swap device. I have 1 machine with a SCSI disk as 
root disk /dev/sda1, the swap device is /dev/sda2. 
Then there is a 4 disk ide raid0 (software raid) mounted 
on /mnt and if i run it there i have the same problem.
This machine is a SMP machine, tho is has also happend
on UP machines.

Hope it helps.

--
	Alex (alex@packetstorm.nu)


