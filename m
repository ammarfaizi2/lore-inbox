Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287936AbSABUQE>; Wed, 2 Jan 2002 15:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287942AbSABUPz>; Wed, 2 Jan 2002 15:15:55 -0500
Received: from ns.muni.cz ([147.251.4.33]:53421 "EHLO aragorn.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S287936AbSABUPp>;
	Wed, 2 Jan 2002 15:15:45 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: Re: IDE CDROM locks the system hard on media error
Message-ID: <3C336A6C.493BFD27@i.am>
Date: Wed, 2 Jan 2002 20:15:40 GMT
To: Stanislav Meduna <stano@meduna.org>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200112240930.fBO9U9b01874@meduna.org>
Mime-Version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8nfs i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stanislav Meduna wrote:
> 
> Hello,
> 
> I am catalogizing my set of CDs and so I have tortured my CD drive
> with a bunch of less-than-optimal CDs. I had two hard lockups
> most probably connected to problematic media.
> 
> The last message in log is
> 
>  kernel: scsi0: ERROR on channel 0, id 0, lun 0,
>    CDB: Request Sense 00 00 00 40 00
>  kernel: Current sd0b:00: sense key Medium Error
>  kernel: Additional sense indicates No seek complete
>  kernel:  I/O error: dev 0b:00, sector 504
>  kernel: ISOFS: unable to read i-node block
> 
> Shortly (but not immediately, the kernel tried a bit more to get
> some data from the drive) after that the system froze - not even
> SysRq worked.
>


Actually I've wanted to report the same problem - I even believe
I've already reported this long time ago in the dark ages when
everyone has been saying some stupid things about BP6...
Usualy reading CD-ROM && hdparm -t /dev/hda was quite easy way
to deadlock the whole system.

Now I would say that 2.4.17rc2 becames more stable but still I've
been faced with similar problem - I have tried to read damaged CD with
movie 
and this is part of log:

begin of errors - please notice the TIME values!

Dec 29 22:02:04 decibel kernel: hdc: cdrom_decode_status: error=0x30
Dec 29 22:02:13 decibel kernel: hdc: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Dec 29 22:02:13 decibel kernel: hdc: cdrom_decode_status: error=0x30
Dec 29 22:02:20 decibel kernel: hdc: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Dec 29 22:02:20 decibel kernel: hdc: cdrom_decode_status: error=0x30
Dec 29 22:02:27 decibel kernel: hdc: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Dec 29 22:02:27 decibel kernel: hdc: cdrom_decode_status: error=0x30
Dec 29 22:02:33 decibel kernel: hdc: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
Dec 29 22:02:33 decibel kernel: hdc: cdrom_decode_status: error=0x30
Dec 29 22:02:33 decibel kernel: hdc: DMA disabled
Dec 29 22:02:33 decibel kernel: hdc: ATAPI reset complete
...
Dec 29 22:03:19 decibel kernel: hdc: cdrom_decode_status: error=0x30
Dec 29 22:03:19 decibel kernel: hdc: ATAPI reset complete
Dec 29 22:03:19 decibel kernel: end_request: I/O error, dev 16:00 (hdc),
sector 321092
...
Dec 29 22:05:47 decibel kernel: hdc: ATAPI reset complete
Dec 29 22:05:47 decibel kernel: end_request: I/O error, dev 16:00 (hdc),
sector 321976Dec 29 22:08:37 decibel kernel: end_request: I/O error, dev
16:00 (hdc), sector 322416
Dec 29 22:08:43 decibel kernel: hdc: cdrom_decode_status: status=0x51 {
DriveReady SeekComplete Error }
...
Dec 29 22:08:59 decibel kernel: hdc: cdrom_decode_status: error=0x30
Dec 29 22:09:25 decibel kernel: SysRq : Emergency Sync
Dec 29 22:09:25 decibel kernel: Syncing device 21:41 ... OK
Dec 29 22:09:25 decibel kernel: Syncing device 21:46 ... OK
Dec 29 22:09:25 decibel kernel: Syncing device 21:47 ... OK
Dec 29 22:09:25 decibel kernel: Syncing device 16:00 ... OK
Dec 29 22:09:25 decibel kernel: Syncing device 03:05 ... OK
Dec 29 22:09:25 decibel kernel: Done.

deadlock here   after   'U' - reset button required


then again:

Dec 29 22:23:39 decibel kernel: hdc: cdrom_decode_status: error=0x30
Dec 29 22:23:39 decibel kernel: hdc: ATAPI reset complete
Dec 29 22:23:39 decibel kernel: end_request: I/O error, dev 16:00 (hdc),
sector 321980
...
Dec 29 22:28:10 decibel kernel: hdc: ATAPI reset complete
Dec 29 22:28:10 decibel kernel: end_request: I/O error, dev 16:00 (hdc),
sector 322420
...
Dec 29 22:29:30 decibel kernel: hdc: ATAPI reset complete
Dec 29 22:29:30 decibel kernel: end_request: I/O error, dev 16:00 (hdc),
sector 321980



And looping for loooong time without any progress here - around some
numbers.

I've tried then to use   'dd'  with conv=noerror  but I had
to skip error part manualy via skip simply because linux was unable
to make any progress here even after 10 minutes.

I guess my CD-ROM was in DMA mode initialy but after it switchies DMA of
the computer becomes almost unusable.


Another problem I would like to see solved one day - why just my machine
is completely unable while anacron does it's jobs ???
Why there couldn't be option in /proc to set limit for maximum amount of
RAM 
for caching filesystem ??? (like 30MB from my 128MB ram ?)

(I think I know better what I need that the Linux VM)

bye


kabi

