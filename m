Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbUDZPOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUDZPOr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 11:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUDZPOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 11:14:46 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:14855 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262425AbUDZPOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 11:14:37 -0400
To: "Mirko Caserta" <mirko@mcaserta.com>
Cc: "Linux Kernel ML" <linux-kernel@vger.kernel.org>
Subject: Re: 8139too not working in 2.6
References: <opr62ahdvlpsnffn@mail.mcaserta.com>
	<87oeperj4y.fsf@devron.myhome.or.jp>
	<opr62jbzk9psnffn@mail.mcaserta.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 27 Apr 2004 00:14:29 +0900
In-Reply-To: <opr62jbzk9psnffn@mail.mcaserta.com>
Message-ID: <878ygirctm.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mirko Caserta" <mirko@mcaserta.com> writes:

> Anyway, it doesn't look like an irq problem to me. It looks more like
> a  wrong detection of the TX triggering level in the driver.

In interrupts-2.6.6-rc2-mm2-broken-out,

           CPU0       CPU1       
  0:     103394         48    IO-APIC-edge  timer
  1:        157          0    IO-APIC-edge  i8042
  5:          2          1    IO-APIC-edge  eth0
                              ^^^^^^^^^^^^-- wrong
  8:          2          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 11:          3          1    IO-APIC-edge  i91u
 12:         87          0    IO-APIC-edge  i8042
 14:       1068          2    IO-APIC-edge  ide0
 15:        953          1    IO-APIC-edge  ide1

The above must be IO-APIC-level.
And the following is interesting one.

    ACPI: ACPI tables contain no PCI IRQ routing entries
    PCI: Invalid ACPI-PCI IRQ routing table
    PCI: Probing PCI hardware
    PCI: Using IRQ router default [1106/3091] at 0000:00:00.0
    PCI BIOS passed nonexistent PCI bus 0!
    PCI BIOS passed nonexistent PCI bus 0!
    PCI BIOS passed nonexistent PCI bus 0!
    PCI BIOS passed nonexistent PCI bus 0!
    PCI BIOS passed nonexistent PCI bus 0!
    PCI BIOS passed nonexistent PCI bus 1!
    PCI BIOS passed nonexistent PCI bus 0!

Um.. can you try "pci=noacpi" or "acpi=off"?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
