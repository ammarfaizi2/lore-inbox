Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270386AbRHHH1U>; Wed, 8 Aug 2001 03:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270387AbRHHH1M>; Wed, 8 Aug 2001 03:27:12 -0400
Received: from david.siemens.de ([192.35.17.14]:17890 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id <S270386AbRHHH1B>;
	Wed, 8 Aug 2001 03:27:01 -0400
X-Envelope-Sender-Is: Andrej.Borsenkow@mow.siemens.ru (at relayer david.siemens.de)
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: linux-kernel@vger.kernel.org
Subject: RE: Persistent device numbers
Date: Wed, 8 Aug 2001 11:27:06 +0400
Message-ID: <000701c11fdb$874fd720$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
In-Reply-To: <E15SJbh-0000iJ-00@the-village.bc.nu>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



To summarize what I've got so far.

1. To answer the question - I try to solve a problem of persistent
device (in general sense, meaning scsi0, eth2, disk3 etc) naming :-) I
want to avoid, that rebooting with failing Ethernet card or plugging in
additional SCSI controller suddenly moves eth1 into eth0 or scsi0 to
scsi1. I want to make sure that a given physical device always is
referred to by the same name irrespectively of any other configuration
changes.

2. I generally agree that it is mostly user-space problem. With the
large if - *if* kernel provides unique physical device identification.
Currently it is not the case. Just review recent thread " How does
"alias ethX drivername" in modules.conf work?"
(http://www.uwsg.indiana.edu/hypermail/linux/kernel/0108.0/1230.html).
There is no way to assure that an Ethernet controller plugged into slot
3 of my PCI bus is always named eth2.

3. devfs does not help here. It provides consistent view of *logical*
namespace - but it changes nothing in how physical devices are mapped
into logical.

What Linux lacks is the ability to refer to devices by there unique path
(please, call it whatever you want, I just find it natural and it is
used in many systems). You may not have module loaded that controls card
in PCI slot 3 but you *do* know that you have a card there and that the
card is of type network (from PCI id). So, you can refer to this card
even if module is not loaded. What I basically suggest is to shift
logical number allocation from actual drivers into upper layer (PCI in
this case). Then SCSI/Ethernet/whatever drivers will get logical numbers
already assigned. And of course tool to assign these numbers belongs to
user space :-)

There are cases when it is not possible. Legacy ISA is an example. In
this case you have no way but reserve some numbers and assign them to
cards using IRQ/Port as it is currently. It seems doable.

-andrej
