Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbSKZKWk>; Tue, 26 Nov 2002 05:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262506AbSKZKWk>; Tue, 26 Nov 2002 05:22:40 -0500
Received: from [212.129.2.130] ([212.129.2.130]:8339 "HELO
	frparex01.fr.tiscali.com") by vger.kernel.org with SMTP
	id <S262373AbSKZKWj> convert rfc822-to-8bit; Tue, 26 Nov 2002 05:22:39 -0500
content-class: urn:content-classes:message
Subject: Clock is suddently ticking too fast !  [Kernel 2.4.19-pre10-ac2, Intel]
MIME-Version: 1.0
Date: Tue, 26 Nov 2002 11:30:19 +0100
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <8B5E8461FFB6B44F85E3504A81AF3D9164591B@frparex01.fr.tiscali.com>
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Clock is suddently ticking too fast !  [Kernel 2.4.19-pre10-ac2, Intel]
Thread-Index: AcKVNsF4FmT7H/vQQl2N1/oXQtvUbw==
From: "Benoit GRANGE" <Benoit.GRANGE@fr.tiscali.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have encountered a problem on two of my servers (HP LH4, 2* Intel PIII) where suddently the clock starts crawling forward at 1.3 times the wall clock time. If I type "sleep 10" it only takes 7 seconds to complete...

The machine is running NTP, but NTP rapidly gives up, showing huge offsets and saying it lost sync.

This happens after some weeks of uptime, one host is running 2.4.17-5mdksmp (Mandrake) and the other 2.4.19-pre10-ac2.

I had a look and found that I think I receive too many clock interrupts. I took a log from an external machine like this:

[remotehost]$ ssh fastticker cat /proc/interrupts; sleep 10; ssh fastticker cat /proc/interrupts

And I have:

           CPU0       CPU1
  0:  215914067  215449650    IO-APIC-edge  timer
  1:      28039      28375    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:        390        230    IO-APIC-edge  serial
 12:      12296      13050    IO-APIC-edge  PS/2 Mouse
 14:          3          3    IO-APIC-edge  ide0
 16:    5369518    5358927   IO-APIC-level  megaraid
 17:  170715902  170692100   IO-APIC-level  eth0
 18:   74772730   74778444   IO-APIC-level  sym53c8xx, eth1
 19:   27010117   26978990   IO-APIC-level  eth2
NMI:          0          0
LOC:  430995876  430995838
ERR:          0
MIS:          0

[Sleep 10]

           CPU0       CPU1
  0:  215914648  215450467    IO-APIC-edge  timer
  1:      28039      28375    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:        390        230    IO-APIC-edge  serial
 12:      12296      13050    IO-APIC-edge  PS/2 Mouse
 14:          3          3    IO-APIC-edge  ide0
 16:    5369535    5358943   IO-APIC-level  megaraid
 17:  170716033  170692235   IO-APIC-level  eth0
 18:   74772883   74778620   IO-APIC-level  sym53c8xx, eth1
 19:   27010134   26979012   IO-APIC-level  eth2
NMI:          0          0
LOC:  430996937  430996899
ERR:          0
MIS:          0

echo "215914648+215450467-215914067-215449650" | bc -l
1398

I got 1398 timer interrupts during the approximate 10 seconds !

Is this a known problem of the kernel (or the hardware) ? Anything I can do ?

--
Benoit Grange
Tiscali France
