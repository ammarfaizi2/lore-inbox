Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315379AbSF3TUb>; Sun, 30 Jun 2002 15:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSF3TUa>; Sun, 30 Jun 2002 15:20:30 -0400
Received: from esperi.demon.co.uk ([194.222.138.8]:53516 "EHLO
	esperi.demon.co.uk") by vger.kernel.org with ESMTP
	id <S315379AbSF3TU3>; Sun, 30 Jun 2002 15:20:29 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 (and maybe earlier versions) can't see my IDE disks where 2.2 can
X-Emacs: a real time environment for simulating molasses-based life forms.
From: Nix <nix@esperi.demon.co.uk>
Date: 30 Jun 2002 20:22:34 +0100
Message-ID: <871yao7erp.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Economic Science)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using a ten year old 486 as a firewall, with an aged transparent
2.5Mb Promise caching IDE controller managing a couple of fairly
bog-standard IDE disks (one a 420Mb 1989-vintage Western Digital of some
kind, the other a 1994-vintage 1Gb IBM disk). I can't find out the model
numbers without taking the machine to pieces, because even with 2.2.20
the (new) ide driver says

Jun 30 00:33:50 esperi kernel: hda: non-IDE drive, CHS=2047/16/63
Jun 30 00:33:50 esperi kernel: hdb: non-IDE drive, CHS=895/15/62
Jun 30 00:33:50 esperi kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

but then it finds the partitions OK:

Jun 30 00:33:50 esperi kernel: Partition check:
Jun 30 00:33:50 esperi kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4
Jun 30 00:33:50 esperi kernel:  hdb: hdb1 < hdb5 hdb6 hdb7 >

2.4 doesn't get anywhere near this far. It finds the IDE controller but
fails to find any of the attached drives, and panics because it can't
mount /.

When I try to force it with kernel parameters, viz `hda=2047,16,63
hdb=895,15,62', it says

hda6: bad access: block=2, count=2
end_request: I/O error, dev 03:06 (hda), sector 2

and then panics because it can't mount root.

I must admit to not knowing where to start debugging this one.

The old disk-only driver works OK with this machine, but it doesn't
support IRQ-based transfer that I can see, with the result that my
16450 UART is dropping incoming packets like confetti :((((

(log from the old driver starting up in 2.4:

Jun 30 13:00:44 esperi kernel: hda: 1007MB, CHS=2047/16/63 
Jun 30 13:00:44 esperi kernel: hdb: 406MB, CHS=895/15/62 
Jun 30 13:00:44 esperi kernel: Partition check: 
Jun 30 13:00:44 esperi kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 > hda4 
Jun 30 13:00:44 esperi kernel:  hdb: hdb1 < hdb5 hdb6 hdb7 > 

pretty uninformative, really.)


Anyone got any idea how I could start to debug this? I could really do
with a driver that supports IRQ on this machine...

-- 
`What happened?'
                 `Nick shipped buggy code!'
                                             `Oh, no dinner for him...'
