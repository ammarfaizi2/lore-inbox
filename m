Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVK3WoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVK3WoZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 17:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVK3WoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 17:44:25 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:59604 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751174AbVK3WoY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 17:44:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ofjTydSeDaywa6zs7E4a+6x5KbdYLSftNJ4+iH+qE6HyAu3XhNbtbqNNTazgiRumNXywGLfH5PEMLCiDiZMXnMUFy0Wlo1qLpYWawh7WJVrFMqyMRUJIHj5ZoW3krVLvssjE2FTxJiRMQrLPYA7vUH9gy6Whg90hrOPdaax1r5U=
Message-ID: <9a8748490511301444h49bfd8f0r55150951ed5ebc2b@mail.gmail.com>
Date: Wed, 30 Nov 2005 23:44:23 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: art@usfltd.com
Subject: Re: SCSI adaptec 19160 speed - 2.6.14-rt13 - Q for scsi experts
Cc: linux-kernel@vger.kernel.org, lsorense@csclub.uwaterloo.ca
In-Reply-To: <200511301617.AA133431912@usfltd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511301617.AA133431912@usfltd.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/05, art <art@usfltd.com> wrote:
> Re: SCSI adaptec 19160 speed - 2.6.14-rt13 - Q for scsi experts
>
> On Tue, Nov 29, 2005 at 07:36:44PM -0600, art wrote:
[snip]
> > >
> > > # hdparm -tT /dev/sdb
> > > /dev/sdb:
> > > Timing cached reads:   2316 MB in  2.00 seconds = 1157.90 MB/sec
> > > Timing buffered disk reads:  268 MB in  3.00 seconds =  89.26 MB/sec
> > > # hdparm -tT /dev/sdc
> > >
> > > /dev/sdc:
> > > Timing cached reads:   2512 MB in  2.00 seconds = 1255.49 MB/sec
> > > Timing buffered disk reads:  268 MB in  3.00 seconds =  89.32 MB/sec
> > >
> > > # hdparm -tT /dev/sdb & hdparm -tT /dev/sdc &
> > > [1] 3314
> > > [2] 3315
> > >
> > > /dev/sdb:
> > > /dev/sdc:
> > > Timing cached reads:    Timing cached reads:   1228 MB in  2.00 seconds = 613.88 MB/sec
> > > 1316 MB in  1.99 seconds = 659.73 MB/sec
> > > Timing buffered disk reads:   Timing buffered disk reads:
> > > 174 MB in  3.00 seconds =  57.91 MB/sec
> > > 170 MB in  3.05 seconds =  55.75 MB/sec
> > > ------------------------------------------------------------------------------------------
> > >
> > > pci is 66Mhz theoretical throuhput ~ 250MB/s
>
> And pci at 33mhz can do 130MB/s or so.  With a bit over overhead those
> numbers sure look awful close to what a 33mhz pci bus can handle.
>
> > > controller adaptec asc-19160
> > > discs are 146GB-15krpm-cheetah
> > >
> > > one disc transfer 89MB/s
> > >
> > > adaptec speed with 2 disc on one channel = 57.91+55.75 = 113.66MB/s
> > >
> > > 71% of 160MB/s channel speed i expected ~90%
> > >
> > > any clue?
>
> PCI bus not at 66mhz perhaps?  Is it an add in card on onboard?  I
> wonder if a pci bus that supports 66mhz has to drop everything to 33mhz
> if any of the cards installed are 33mhz only.  Having never tried I
> don't know.
>
> Len Sorensen
>
> --------------------------------------------------------------
> --------------------------------------------------------------
>
> # /sbin/lspci -v
>
> 02:00.0 SCSI storage controller: Adaptec AIC-7892B U160/m (rev 02)
>         Subsystem: Adaptec 19160 Ultra160 SCSI Controller
>         Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
>         BIST result: 00
>         I/O ports at a000 [disabled] [size=256]
>         Memory at e302a000 (64-bit, non-prefetchable) [size=4K]
>         [virtual] Expansion ROM at 50000000 [disabled] [size=128K]
>         Capabilities: [dc] Power Management version 2
>
> 02:02.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [EHCI])
>         Subsystem: Belkin Root Hub
>         Flags: bus master, medium devsel, latency 32, IRQ 16
>         Memory at e3028000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [40] Power Management version 2
>
> 02:04.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
>         Subsystem: Adaptec: Unknown device 0030
>         Flags: bus master, medium devsel, latency 32, IRQ 16
>         Memory at e302b000 (32-bit, non-prefetchable) [size=2K]
>         Memory at e3020000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [44] Power Management version 2
>
>
> 3 cards on same 16-int  Adaptec 19160 at 66Mhz
> but---33Mhz ieee1394a ---- subsystem: Adaptec ???
>

Hmm, seeing your mail got me thinking about how my own disks perform

# lspci -v
00:0b.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160N Ultra160 SCSI Controller
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 5
        BIST result: 00
        I/O ports at 9800 [disabled] [size=256]
        Memory at e3000000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 30000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

about the disk (10K RPM IBM UltraStar) from dmesg :

[   43.387178]   Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
[   43.406176]   Type:   Direct-Access                      ANSI SCSI
revision: 03
[   43.424651] scsi0:A:6:0: Tagged Queuing enabled.  Depth 200
[   43.442952]  target0:0:6: Beginning Domain Validation
[   43.464011]  target0:0:6: wide asynchronous.
[   43.486866]  target0:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns,
offset 63)
[   43.514788]  target0:0:6: Ending Domain Validation
[   45.584696] SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
[   45.604490] SCSI device sda: drive cache: write back
[   45.623781] SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
[   45.643575] SCSI device sda: drive cache: write back
[   45.661953]  sda: sda1 sda2 sda3 sda4
[   45.691968] sd 0:0:6:0: Attached scsi disk sda

# hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   904 MB in  2.00 seconds = 451.17 MB/sec
 Timing buffered disk reads:   84 MB in  3.05 seconds =  27.52 MB/sec


Not exactely impressive numbers here...


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
