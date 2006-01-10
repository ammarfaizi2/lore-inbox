Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWAJLOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWAJLOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 06:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWAJLOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 06:14:43 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:47762 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751051AbWAJLOn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 06:14:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ohl98cVyBo/4javppctV3clU6DYtQbqVRZN5dbK1rfEHq7R8BYuE9MFZqgzQqOnV/CNo4Cx/wHxETIe4Ys23N9fMeRqoQ1VrsGi0sgubhBRWVTOU1ce1M6zOZmCItB72tThkXPuGp7gEfPzWkfMDKSmA5xAdDRFb2Y8u7mevvFQ=
Message-ID: <9a8748490601100314u26d4a566uc41a1912e410ea46@mail.gmail.com>
Date: Tue, 10 Jan 2006 12:14:42 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Although CONFIG_IRQBALANCE is enabled IRQ's don't seem to be balanced very well
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I enabled CONFIG_IRQBALANCE with 2.6.15 and 2.6.15-mm2 (which the
numbers below are from), and had expected that to evenly (or at least
close to evenly) balance IRQ's across the two CPU cores of my Athlon
X2 4400+. But as you can see below, CPU0 seems to be heavily favoured
- what's the reason for that and is it something I can improve upon?
Is it due to this being a Dual Core CPU and not two physically sepperate CPU's?
Do I need any userspace tools in addition to CONFIG_IRQBALANCE?

juhl@dragon:~$ date && cat /proc/interrupts
Tue Jan 10 11:20:33 CET 2006
           CPU0       CPU1
  0:    3818901      18920    IO-APIC-edge  timer
  1:       8398          7    IO-APIC-edge  i8042
  8:          0          1    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:     210259         11    IO-APIC-edge  i8042
 18:      12883          1   IO-APIC-level  eth0
 19:      15906        291   IO-APIC-level  aic7xxx
 20:       1284          1   IO-APIC-level  EMU10K1
NMI:          0          0
LOC:    3838143    3837641
ERR:          0
MIS:          0

juhl@dragon:~$ date && cat /proc/interrupts
Tue Jan 10 12:12:38 CET 2006
           CPU0       CPU1
  0:    6944246      18920    IO-APIC-edge  timer
  1:      11291          7    IO-APIC-edge  i8042
  8:          0          1    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:     393217         11    IO-APIC-edge  i8042
 18:      38690          1   IO-APIC-level  eth0
 19:     204122        291   IO-APIC-level  aic7xxx
 20:      10877          1   IO-APIC-level  EMU10K1
NMI:          0          0
LOC:    6963608    6963106
ERR:          0
MIS:          0


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
