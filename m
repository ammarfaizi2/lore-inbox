Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266337AbUBLLka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 06:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266344AbUBLLka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 06:40:30 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:51333 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266337AbUBLLk1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 06:40:27 -0500
From: "Peter Illmayer" <pete@jbo.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: Dual es1371 SB cards, unable to get 2nd card to work
Date: Thu, 12 Feb 2004 22:40:24 +1100
Message-ID: <000001c3f15d$04831d60$6401a8c0@sandman>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am unable to get the 2nd soundcard in my server to work.  I have read
as many threads as I can and am stumped. Any guidance would sincerely be
appreciated, I want to learn ! The first soundcard continues to work
fine.....

Configuration Information is as follow:
------------------------------------------------------------------------
-----------------------------
Kernel: 2.4.20-8smp (Redhat 9.0)

PCI devices: ie: lspci -v

00:08.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative SoundBlaster AudioPCI 128
        Flags: bus master, slow devsel, latency 104, IRQ 5
        I/O ports at 7800 [size=64]
        Capabilities: [dc] Power Management version 1

00:0a.0 Multimedia audio controller: Creative Labs ES1371
        Subsystem: Creative Labs: Unknown device 5938
        Flags: bus master, slow devsel, latency 104, IRQ 15
        I/O ports at 7840 [size=64]
        I/O ports at 7880 [size=32]
        Capabilities: [dc] Power Management version 2

Lsmod shows:
[root@server root]# lsmod
Module                  Size  Used by    Not tainted
es1371                 34920   0  (autoclean)
gameport                3508   0  (autoclean) [es1371]
ac97_codec             13768   0  (autoclean) [es1371]
soundcore               7044   8  (autoclean) [es1371]

I have created the following devices via the command

Mknod /dev/dsp2 c 14 35
Mknod /dev/dsp3 c 14 51

[root@server dev]# ls -al dsp*
crw-------    1 root     root      14,   3 Jan 30  2003 dsp
crw-------    1 root     root      14,  19 Jan 30  2003 dsp1
crw-------    1 root     root      14,  35 Feb 11 20:11 dsp2
crw-------    1 root     root      14,  51 Feb  9 21:35 dsp3
crw-------    1 root     root      14,  67 Feb  9 21:31 dsp4

I have added the following lines to /etc/modules.conf:

alias sound-slot-0 es1371
post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L
>/dev/null 2>&1 || :
pre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S
>/dev/null 2>&1 || :

alias sound-slot-2 es1371
post-install sound-slot-2 /bin/aumix-minimal -f /etc/.aumixrc1 -L
>/dev/null 2>&1 || :
pre-remove sound-slot-2 /bin/aumix-minimal -f /etc/.aumixrc1 -S
>/dev/null 2>&1 || :

------------------------------------------------------------------------
------------------------------

I am unable to play a wav file when doing:

Play -d /dev/dsp2 blah.wav , the machine sits there for the correct time
however no audio

Performing a dd to /dev/dsp, I get the following:


[root@server dev]# dd if=/dev/dsp2 | od -i
0000000  30840  30840  30840  30840  30840  30840  30840  30840
*
58+0 records in
58+0 records out

[root@server dev]

I have read the thread
http://www.ussg.iu.edu/hypermail/linux/kernel/0010.2/1137.html and tried
all of the suggestions however it doesn't work.  I apologise if this is
a lame question however I cant seem to get my head around it.

Many thanks in anticipation !

Peter....vk2yx





