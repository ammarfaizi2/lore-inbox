Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269778AbRIDXAd>; Tue, 4 Sep 2001 19:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269786AbRIDXAN>; Tue, 4 Sep 2001 19:00:13 -0400
Received: from [209.38.98.99] ([209.38.98.99]:63675 "EHLO srvr201.castmark.com")
	by vger.kernel.org with ESMTP id <S269778AbRIDXAL>;
	Tue, 4 Sep 2001 19:00:11 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Fred <fred@arkansaswebs.com>
To: =?iso-8859-1?q?J=F6rn=20Nettingsmeier?= 
	<nettings@folkwang-hochschule.de>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.8-ac11 lockup when burning cds
Date: Tue, 4 Sep 2001 18:00:16 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <3B922604.A8E3EB5F@folkwang-hochschule.de> <01090312400502.21988@bits.linuxball> <3B93C884.DA5CBE3D@folkwang-hochschule.de>
In-Reply-To: <3B93C884.DA5CBE3D@folkwang-hochschule.de>
Cc: =?iso-8859-1?q?G=E9rard=20Roudier?= <groudier@free.fr>,
        "C. Linus Hicks" <lhicks@nc.rr.com>
MIME-Version: 1.0
Message-Id: <01090418001603.14864@bits.linuxball>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you two should compare notes
another SMP machine can't burn CD's?

see the messages below, the first is reposted from a different email
__________________________________________________
 _________________________________________________ 
On Tuesday 04 September 2001 04:17 pm, Gérard Roudier wrote:
> On 4 Sep 2001, C. Linus Hicks wrote:
> > I have been unsuccessful trying to burn a CD-R since upgrading my
> > computer and I'm not sure where to go with this. I decided to try here.
> > I suspect a problem with the SYM53C8xx driver, and I think there may
> > also be additional problems elsewhere. My old system worked. It was:
> >
> > RedHat 7.0 with 2.2.19 kernel
> > ASUS P2B-DS (440BX chipset) with 2 600MHz Intel processors
> > On-board Adaptec AIC-7890 with the new aic7xxx driver
> > Add-on Adaptec 2940 PCI adapter (narrow devices attached here)
> > Yamaha CRW6416S CD writer
> >
> > My new system:
> >
> > RedHat 7.1 with 2.4.8-ac11 kernel
> > Tyan Thunder HEsl S2567 (ServerWorks chipset) with 2 1000MHz Intel
> > processors
> > On-board LSI 53C1010-66 (running at 33MHz) dual channel SCSI
> > Add-on LSI21003 with 53C1010-33 (narrow devices here)
> > SYM53C8xx driver
> > Yamaha CRW2100S CD writer
> >
> > I looked for problem reports with the 2100S and didn't see any, rather
> > several reports that it worked okay. I updated the firmware to the
> > latest - 1.0N and it didn't help.
> >
> > I have tried several versions of cdrecord including the latest 1.11a05
> > with associated tools to no avail.
> >
> > When I try burning a CD, sometimes I get errors and sometimes it appears
> > to work. When I try to mount a CD-R that burned successfully in a
> > Toshiba DVD-ROM drive, I get errors like this:
> >
> > [root@lh2 /root]# mount /mnt/cdrom
> > mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
> >        or too many mounted file systems
> > [root@lh2 /root]#
> >
> > And in /var/log/messages:
> >
> > Sep  4 16:31:18 LH2 kernel: sym53c1010-33-1:4: ERROR (0:18) (1-21-0)
> > (10/30) @ (script 8e8:110007c1).
> > Sep  4 16:31:18 LH2 kernel: sym53c1010-33-1: script cmd = 88080000
> > Sep  4 16:31:18 LH2 kernel: sym53c1010-33-1: regdump: da 10 c0 30 47 10
> > 04 0e 80 01 84 21 80 01 01 00 00 b0 d6 37 08 00 00 00.
> > Sep  4 16:31:18 LH2 kernel: sym53c1010-33-1: ctest4/sist original
> > 0x8/0x18  mod: 0x18/0x0
> > Sep  4 16:31:18 LH2 kernel: sym53c1010-33-1: restart (scsi reset).
> > Sep  4 16:31:18 LH2 kernel: sym53c1010-33-1: handling phase mismatch
> > from SCRIPTS.
> > Sep  4 16:31:18 LH2 kernel: sym53c1010-33-1: Downloading SCSI SCRIPTS.
> > Sep  4 16:31:20 LH2 kernel: sym53c1010-33-1-<4,*>: FAST-20 SCSI 20.0
> > MB/s (50.0 ns, offset 16)
> > Sep  4 16:31:20 LH2 kernel:  I/O error: dev 0b:00, sector 68
> > Sep  4 16:31:20 LH2 kernel: isofs_read_super: bread failed, dev=0b:00,
> > iso_blknum=17, block=17
> >
> > I tried replacing the LSI21003 with a 2940 and burned a CD-R. The
> > process went smoothly with no errors reported.
>
> The ERROR (0:18) thing indicates a SCSI GROSS ERROR problem. In other
> words, the controller is seing a severe transport error on the SCSI BUS.
> This is often due to a SCSI BUS problem. Decreasing the data throughput
> can make the problem less likely to happen, but this is obviously a poor
> workaround.
>
> Could you check the synchronous data parameters negotiated with the
> Adaptec. If speed is lower than 20 MB/s and/or offset is lower than 16,
> then we may well just be comparing oranges and apples.
>
> > I mounted the burned CD
> > in the Toshiba successfully and listed the contents. I did not think to
> > verify the CD with the mastered file. I then switched back to the
> > LSI21003 and tried to mount the burned CD-R. I got:
>
> Hmmm... If you just hot-switch the device then the breakage seems normal.
> Can I assume you didn't do so ?:)
>
> > [root@lh2 /root]# mount /mnt/cdrom
> > mount: Not a directory
> > [root@lh2 /root]#
> >
> > And in /var/log/messages:
> >
> > Sep  4 15:15:47 LH2 kernel: scsi : aborting command due to timeout : pid
> > 0, scsi1, channel 0, id 4, lun 0 Read (10) 00 00 00 00 1c 00 00 01 00
> > Sep  4 15:15:47 LH2 kernel: sym53c8xx_abort: pid=0 serial_number=149685
> > serial_number_at_timeout=149685
> > Sep  4 15:15:48 LH2 kernel: SCSI host 1 abort (pid 0) timed out -
> > resetting
> > Sep  4 15:15:48 LH2 kernel: SCSI bus is being reset for host 1 channel
> > 0.
> > Sep  4 15:15:48 LH2 kernel: sym53c8xx_reset: pid=0 reset_flags=2
> > serial_number=149685 serial_number_at_timeout=149685
> > Sep  4 15:15:48 LH2 kernel: sym53c1010-33-1: restart (scsi reset).
> > Sep  4 15:15:48 LH2 kernel: sym53c1010-33-1: handling phase mismatch
> > from SCRIPTS.
> > Sep  4 15:15:48 LH2 kernel: sym53c1010-33-1: Downloading SCSI SCRIPTS.
> > Sep  4 15:15:48 LH2 kernel: sym53c1010-33-1-<4,*>: FAST-20 SCSI 20.0
> > MB/s (50.0 ns, offset 16)
> > Sep  4 15:15:48 LH2 kernel: Device 0b:00 not ready.
> > Sep  4 15:15:48 LH2 kernel:  I/O error: dev 0b:00, sector 112
> > Sep  4 15:15:49 LH2 kernel: ISOFS: unable to read i-node block
> > Sep  4 15:15:49 LH2 kernel: Device 0b:00 not ready.
> > Sep  4 15:15:49 LH2 kernel:  I/O error: dev 0b:00, sector 128
> > Sep  4 15:15:49 LH2 kernel: ISOFS: unable to read i-node block
> >
> > Any help would be appreciated, and if anyone needs additional
> > information I will be glad to do what I can.
>
> I suggest you to define some lower data speed in the NVRAM and see if it
> makes differences. OTOH, if the Adaptec is using a different (assumed
> lower) speed you may give a try with the C1010-33 at the same speed.
> You may let me know the results.
>
> Regards,
>   Gérard.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

 _________________________________________________ 
On Monday 03 September 2001 01:14 pm, Jörn Nettingsmeier wrote:
> thanks for your help, fred.
> i will browse the archive again.
>
> and as soon as my new Xfree runs smoothly, i'll have a go at the
> kernel again.
>
> regards,
>
> jörn
>
> Fred wrote:
> > I have read quite a few messages about SMP machines locking up.
> > I believe that a few patches are available for these things, but you'd
> > have to go back to the archive to find out more.
> >
> > Fred
> >
> >  _________________________________________________
> >
> > On Monday 03 September 2001 09:25 am, Jörn Nettingsmeier wrote:
> > > Fred wrote:
> > > > burning on 2.4.9-ac5 works fine for me with
> > > > amd 500
> > > > 12x ide cdrw
> > > > 256MB ram
> > > > ali mainboard
> > > >
> > > > what's your hardware config?
> > >
> > > #cdrecord -scanbus
> > > Cdrecord 1.9 (i686-suse-linux) Copyright (C) 1995-2000 Jörg
> > > Schilling
> > > Linux sg driver version: 3.1.20
> > > Using libscg version 'schily-0.1'
> > > scsibus0:
> > >         0,0,0     0) 'IBM     ' 'DCAS-34330W     ' 'S65A' Disk
> > >         0,2,0     2) 'TOSHIBA ' 'CD-ROM XM-6201TA' '1037' Removable
> > > CD-ROM
> > > scsibus2:
> > >         2,0,0   200) 'PHILIPS ' 'CDD3610 CD-R/RW ' '2.02' Removable
> > > CD-ROM
> > >
> > > there is another pci scsi adaptor (a symbios) for my scanner, but i
> > > only load the module on demand, and it wasn't loaded when the lockup
> > > occured.
> > >
> > > i see you are running UP, perhaps it's a SMP related problem ?
> > >
> > > will try playing with some debug options and linus' release...
