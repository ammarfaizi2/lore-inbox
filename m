Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTJSRg5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 13:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTJSRg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 13:36:57 -0400
Received: from 66.Red-80-38-104.pooles.rima-tde.net ([80.38.104.66]:3456 "HELO
	fulanito.nisupu.com") by vger.kernel.org with SMTP id S261940AbTJSRgw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 13:36:52 -0400
Message-ID: <006b01c39667$f32211c0$0514a8c0@HUSH>
From: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
To: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Cc: <linux-kernel@vger.kernel.org>
References: <00b801c3955c$7e623100$0514a8c0@HUSH>    <48236.192.168.9.10.1066565636.squirrel@ncircle.nullnet.fi>    <006501c39660$cf306cf0$0514a8c0@HUSH> <40464.192.168.9.10.1066583818.squirrel@ncircle.nullnet.fi>
Subject: Re: HighPoint 374
Date: Sun, 19 Oct 2003 19:39:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Very interesting. The other type of errors I have received (the last time
> with 2.4.23-pre4) were:
>
> Sep 14 14:29:49 alderan kernel: hde: set_drive_speed_status: status=0xff {
> Busy }
> Sep 14 14:29:49 alderan kernel: blk: queue c0492188, I/O limit 4095Mb
> (mask 0xffffffff)

Same here.

> Currently my disk-drivers are made by 2*samsung (SV8004H) and
> 2*Samsung(SV1604N), in case that changes anything.

I'm using two seagates (different models), one Samsung and one Maxtor, this
happens in all 4.
I'm not using any kind of RAID.

>
> BTW. Have you noticed in what situation the lock up happens ?

If the filesystems are mounted read only it seems to run stable (even though
I do see those errors)....if I mount r/w, any write is likely to make the
system crash rather soon.

> What does /proc/interrupts show in your case ?

Using the HPT drivers:

           CPU0
  0:     118661          XT-PIC  timer
  1:         14          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:       2698          XT-PIC  eth1
  5:       1133          XT-PIC  hpt374
  7:          0          XT-PIC  usb-uhci
  8:          1          XT-PIC  rtc
  9:       1098          XT-PIC  usb-uhci, eth0
 12:         28          XT-PIC  PS/2 Mouse
 14:      69807          XT-PIC  ide0
 15:         54          XT-PIC  ide1
NMI:          0
ERR:          0

Using the regular kernel IDE drivers

           CPU0
  0:       9318          XT-PIC  timer
  1:         12          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:        151          XT-PIC  eth1
  5:        130          XT-PIC  ide2, ide3, ide4, ide5
  7:          0          XT-PIC  usb-uhci
  8:          1          XT-PIC  rtc
  9:        573          XT-PIC  usb-uhci, eth0
 12:         28          XT-PIC  PS/2 Mouse
 14:       9163          XT-PIC  ide0
 15:         54          XT-PIC  ide1
NMI:          0
ERR:          0

>
> And have you tried with ACPI on/off and io-apic on/off ?

No, to be honest I didn't even think of this. You think it could make a
difference? Given the fact that the card works correctly with the HPT
drivers, pretty much everything that does not relate directly to the IDE
drivers seems ruled out as the cause...



