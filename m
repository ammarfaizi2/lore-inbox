Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTHTVTS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 17:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbTHTVTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 17:19:18 -0400
Received: from main.gmane.org ([80.91.224.249]:14304 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262232AbTHTVTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 17:19:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Gecius <jens@gecius.de>
Subject: 2.6.0-test3 smp irq balance
Date: Wed, 20 Aug 2003 23:03:57 +0200
Message-ID: <878yporqgy.fsf@maniac.gecius.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Rational FORTRAN,
 i386-debian-linux)
Cancel-Lock: sha1:MJI1MkkHiqnBHv68Y1NRc/fLBcc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

having switched to 2.6.0-t3 to test some of the new features, I
noticed more framedrops from bttv. sometimes the system feels a little
sluggish, although i expected the opposite.

trying to track down the "problem" I stumbled across this:

jens@maniac:/usr/src/linux$ cat /proc/interrupts
           CPU0       CPU1       
  0:   91133739         29    IO-APIC-edge  timer
  1:      43765          1    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  4:     774189          0    IO-APIC-edge  serial
  5:    9337660          1   IO-APIC-level  ohci1394, uhci-hcd, uhci-hcd
  8:          4          0    IO-APIC-edge  rtc
  9:   15340458          1   IO-APIC-level  Ensoniq AudioPCI, eth1
 10:    1233326          5   IO-APIC-level  ide3, eth0
 11:   21436308          1   IO-APIC-level  nvidia, bttv0
 14:     884901          0    IO-APIC-edge  ide0
 15:        126          2    IO-APIC-edge  ide1
NMI:          0          0 
LOC:   91137709   91138393 
ERR:          0
MIS:         12

irqs seem not to be distributed between cpus, having one to handle all
(even while building kernel on both cpus (according to gkrell), the
numbers for the second cpu don't change.

i could post any needed information (hopefully). The bootup process
did not show anything raising questions to me.

any hints?

-- 
Tschoe,                http://gecius.de/gpg-key.txt - Fingerprint:
 Jens                  1AAB 67A2 1068 77CA 6B0A  41A4 18D4 A89B 28D0 F097

