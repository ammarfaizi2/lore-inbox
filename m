Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265396AbUHINf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbUHINf2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUHINf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:35:28 -0400
Received: from kwisatz.net1.nerim.net ([80.65.225.31]:14852 "EHLO
	www.rubis.org") by vger.kernel.org with ESMTP id S265396AbUHINfK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:35:10 -0400
Date: Mon, 9 Aug 2004 15:34:55 +0200
From: Stephane Jourdois <stephane@rubis.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Filip Van Raemdonck <filipvr@xs4all.be>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20040809133452.GA24530@diamant.rubis.org>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
	Filip Van Raemdonck <filipvr@xs4all.be>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040808191912.GA620@elf.ucw.cz> <1092003277.2773.45.camel@pegasus> <20040809095425.GA12667@debian> <1092046959.21815.15.camel@pegasus> <20040809120705.GA23073@diamant.rubis.org> <1092057843.21815.21.camel@pegasus>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1092057843.21815.21.camel@pegasus>
X-Operating-System: Linux 2.6.8-rc3-mm2
X-Send-From: diamant.tech.sitadelle.com
User-Agent: Mutt/1.5.6+20040803i
X-SA-Exim-Connect-IP: 213.223.184.193
X-SA-Exim-Mail-From: kwisatz@rubis.org
Subject: Re: 2.6.8-rc2-mm1: bluetooth broken?
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Report: * -4.9 BAYES_00 BODY: L'algorithme  =?ISO-8859-1?Q?=20Bay=E9sien?= a  =?ISO-8859-1?Q?=20=E9?=
	=?ISO-8859-1?Q?valu=E9?= la  =?ISO-8859-1?Q?=20probabilit=E9?= de spam entre 0 et 1%
	*      [score: 0.0000]
	*  0.5 AWL AWL: Auto-whitelist adjustment
X-SA-Exim-Version: 4.0 (built Sat, 24 Apr 2004 12:31:30 +0200)
X-SA-Exim-Scanned: Yes (on www.rubis.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 03:24:03PM +0200, Marcel Holtmann wrote:
> > > this is what I was thinking, because I always run the latest stuff from
> > > the Bitkeeper repository directly. Seems that there is something in the
> > > -mm patches that broke it. Can someone test the latest -mm and report if
> > > the Bluetooth subsystem is working or not?
> > 
> > Not working here since 2.6.8-rc2-mm2.
> > Works in 2.6.8-rc2-mm1.
> 
> I never used a -mm patch, so you must be a little bit more specific what
> is not working. What Bluetooth hardware are you using? Do the logfiles
> or dmesg include anything helpful?

I use a usb dongle, unfortunately included in my laptop, so I can't see
any serial number or anything.

lspci -v :
----
[..snip..]
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02) (prog-if 00 [UHCI])
        Subsystem: CLEVO/KAPOK Computer: Unknown device 0500
        Flags: bus master, medium devsel, latency 0, IRQ 193
        I/O ports at 1cc0 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02) (prog-if 00 [UHCI])
        Subsystem: CLEVO/KAPOK Computer: Unknown device 0500
        Flags: bus master, medium devsel, latency 0, IRQ 201
        I/O ports at 1ce0 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02) (prog-if 00 [UHCI])
        Subsystem: CLEVO/KAPOK Computer: Unknown device 0500
        Flags: bus master, medium devsel, latency 0, IRQ 185
        I/O ports at 2000 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02) (prog-if 00 [UHCI])
        Subsystem: CLEVO/KAPOK Computer: Unknown device 0500
        Flags: bus master, medium devsel, latency 0, IRQ 193
        I/O ports at 2020 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: CLEVO/KAPOK Computer: Unknown device 0500
        Flags: bus master, medium devsel, latency 0, IRQ 209
        Memory at e8000000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [20a0]
[..snip..]
----

I use it to communicate using HIDP with my Logitech MX900 mouse, which
works perfectly under 2.6.8-rc2-mm1, and no more since 2.6.8-rc2-mm2.

strace hidd --search :
---- 
[..snip..]
socket(PF_BLUETOOTH, SOCK_RAW, 6)       = 3
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 4
brk(0)                                  = 0x804d000
brk(0x806e000)                          = 0x806e000
brk(0)                                  = 0x806e000
ioctl(4, 0x800448d2, 0x804d008)         = 0
close(4)                                = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 4
ioctl(4, 0x800448d2, 0x804d008)         = 0
close(4)                                = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 4
ioctl(4, 0x800448d3, 0xbfffe940)        = -1 ENODEV (No such device)
close(4)                                = 0
fstat64(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7ea0000
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 4
ioctl(4, 0x800448d2, 0x804d008)         = 0
close(4)                                = 0
close(3)                                = 0
write(1, "Searching ...\n", 14Searching ...
)         = 14
munmap(0xb7ea0000, 4096)                = 0
----

I saw several lines as those in my dmesg :
----
usb 4-2: usbfs: USBDEVFS_CONTROL failed cmd hid2hci rqt 64 rq 0 len 0 ret -32
----

I'll try now to narrow which patch is broking things for me in -mm.
I'll post my results to this thread.

++

-- 
 ///  Stephane Jourdois         /"\  ASCII RIBBON CAMPAIGN \\\
(((    Ingénieur développement  \ /    AGAINST HTML MAIL    )))
 \\\   24 rue Cauchy             X                         ///
  \\\  75015  Paris             / \    +33 6 8643 3085    ///
