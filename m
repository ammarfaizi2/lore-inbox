Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265423AbUAJXOF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 18:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265473AbUAJXOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 18:14:05 -0500
Received: from stinkfoot.org ([65.75.25.34]:20096 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S265423AbUAJXOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 18:14:02 -0500
Message-ID: <40008745.4070109@stinkfoot.org>
Date: Sat, 10 Jan 2004 18:14:13 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031224
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: William Lee Irwin III <wli@holomorphy.com>
Subject: 2.6.1 and irq balancing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

I upgraded my server to 2.6.1, and I'm finding I'm saddled with only 
interrupting on CPU0 again. 2.6.0 does this as well. This is the 
Supermicro X5DPL-iGM-O (E7501 chipset), 2 Xeons@2.4ghz HT enabled. 
/proc/cpuinfo is normal as per HT, displaying 4 cpus.
2.4.2(3|4) exhibited this behaviour as well, until I applied patches 
from here: 
http://www.hardrock.org/kernel/2.4.23/irqbalance-2.4.23-jb.patch, et al.


            CPU0       CPU1       CPU2       CPU3
   0:    1572323          0          0          0    IO-APIC-edge  timer
   2:          0          0          0          0          XT-PIC  cascade
   3:      23520          0          0          0    IO-APIC-edge  serial
   8:          2          0          0          0    IO-APIC-edge  rtc
   9:          0          0          0          0   IO-APIC-level  acpi
  14:         10          0          0          0    IO-APIC-edge  ide0
  16:         30          0          0          0   IO-APIC-level  sym53c8xx
  22:       4162          0          0          0   IO-APIC-level  eth0
  48:       7798          0          0          0   IO-APIC-level  aic79xx
  49:       3385          0          0          0   IO-APIC-level  aic79xx
  54:      17062          0          0          0   IO-APIC-level  eth1
NMI:          0          0          0          0
LOC:    1572002    1572251    1572250    1572243
ERR:          0
MIS:          0


THey keyboard isn't working either, but we see the i8042..

serio: i8042 KBD port at 0x60,0x64 irq 1


-Ethan
