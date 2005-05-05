Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVEEOpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVEEOpT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 10:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVEEOpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 10:45:19 -0400
Received: from firewall.miltope.com ([208.12.184.221]:26149 "EHLO
	smtp.miltope.com") by vger.kernel.org with ESMTP id S262115AbVEEOpF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 10:45:05 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Thu, 5 May 2005 09:45:36 -0500
Message-ID: <66F9227F7417874C8DB3CEB05772741712AC2F@MILEX0.Miltope.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Thread-Index: AcVQ5V+2vEy2Kq6JTsCCHviE8pMuPgAmtf0g
From: "Drew Winstel" <DWinstel@Miltope.com>
To: "Oskar Liljeblad" <oskar@osk.mine.nu>
Cc: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Bill Davidsen" <davidsen@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are interrupts errors serious? Can anyone tell? The error count was higher
> when I had a fifth PCI card in the computer (natsemi ethernet NIC).
> Could there be some kind of PCI card conflict? Maybe I should try to
> remove a few of them...

It's worth a shot. Just for the record, I haven't had any such errors on my
machine.
root@linux /proc # cat interrupts 
           CPU0       
  0:   46494411          XT-PIC  timer
  1:      13644          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:    1210194          XT-PIC  ohci_hcd, SiS SI7012
  7:         19          XT-PIC  parport0
  9:    3492898          XT-PIC  acpi, ohci_hcd, nvidia
 10:          0          XT-PIC  ohci_hcd
 11:      29194          XT-PIC  ehci_hcd, eth0
 12:     295381          XT-PIC  i8042
 14:     567754          XT-PIC  ide0
 15:         48          XT-PIC  ide1
NMI:          0 
ERR:          0
root@linux /proc # uptime
 09:38:16 up 12:54,  5 users,  load average: 0.08, 0.03, 0.03

> In other words, Athlon/Duron/K7 + HPET + Local APIC + IO-Apic
> (though I have tried with both XT-PIC and Local APIC, with same
> drift).

So much for that thought.  The kernel config is solid (as expected).

> And no, the clock drift occurs no matter if ntpd is running or not.
> It's having a very hard time to syncronize with the remote servers,
> because the clock drift is too high. (It also says somewhere in the
> NTP documentation that it doesn't handle too high clock drift.)

I just had an idea.  Using the old PDC20269 IDE driver, try repeating
your test to trigger clock drift.  While the test is in progress, run
hdparm (no need for -i) on both drives.  I wonder if it's dropping out
of DMA mode temporarily for no apparent reason.

Thanks,
Drew
