Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbQKFJlP>; Mon, 6 Nov 2000 04:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129724AbQKFJk4>; Mon, 6 Nov 2000 04:40:56 -0500
Received: from bastion.power-x.co.uk ([62.232.19.201]:10757 "EHLO
	bastion.power-x.co.uk") by vger.kernel.org with ESMTP
	id <S129207AbQKFJkw>; Mon, 6 Nov 2000 04:40:52 -0500
Date: Mon, 6 Nov 2000 09:40:50 +0000 (GMT)
From: "Dr. David Gilbert" <dg@px.uk.com>
To: linux-kernel@vger.kernel.org
Subject: Dual Xeon, MTRR problem still there?
Message-ID: <Pine.LNX.4.21.0011060936200.24579-100000@springhead.px.uk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  While my friendly dual Xeon machine now appears to be pretty fast, I
notice that the NMI counter is still incrementing like topsy; this
presumably means that there is still something dodgy going on.
A hdparm -t seems to be giving respectable values, so I am not quite sure
where the time/performance is going:

/proc/mtrr shows the following

reg00: base=0xf9f00000 (3999MB), size=   1MB: uncachable, count=1
reg01: base=0xfa000000 (4000MB), size=  32MB: uncachable, count=1
reg02: base=0xfc000000 (4032MB), size=  64MB: uncachable, count=1
reg03: base=0x00000000 (   0MB), size=4096MB: write-back, count=1
reg04: base=0x100000000 (4096MB), size=  64MB: write-back, count=1
reg05: base=0x104000000 (4160MB), size=  32MB: write-back, count=1
reg06: base=0x106000000 (4192MB), size=   1MB: write-back, count=1

Here are two /proc/interrupts straight after each other:

           CPU0       CPU1       
  0:   14047275   17655700    IO-APIC-edge  timer
  1:         73         37    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  9:          0          0    IO-APIC-edge  acpi
 12:       1196        928    IO-APIC-edge  PS/2 Mouse
 13:          0          0          XT-PIC  fpu
 20:     226485     240634   IO-APIC-level  eth0
 56:         14         16   IO-APIC-level  sym53c8xx
 57:      52554      55135   IO-APIC-level  sym53c8xx
 58:         15         12   IO-APIC-level  sym53c8xx
NMI:   31702796   31702796 
LOC:   31702834   31702833 
ERR:          0

           CPU0       CPU1       
  0:   14047328   17655766    IO-APIC-edge  timer
  1:         73         37    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  9:          0          0    IO-APIC-edge  acpi
 12:       1196        928    IO-APIC-edge  PS/2 Mouse
 13:          0          0          XT-PIC  fpu
 20:     226496     240646   IO-APIC-level  eth0
 56:         14         16   IO-APIC-level  sym53c8xx
 57:      52554      55135   IO-APIC-level  sym53c8xx
 58:         15         12   IO-APIC-level  sym53c8xx
NMI:   31702915   31702915 
LOC:   31702953   31702952 
ERR:          0

Thats 2.4.0-test10 with last weeks patch.

Dave
-- 
/------------------------------------------------------------------\
| Dr. David Alan Gilbert | Work:dg@px.uk.com +44-161-286-2000 Ex258|
| -------- G7FHJ --------|---------------------------------------- |
| Home: dave@treblig.org            http://www.treblig.org         |
\------------------------------------------------------------------/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
