Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbVINBRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbVINBRI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 21:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbVINBRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 21:17:07 -0400
Received: from juno.lps.ele.puc-rio.br ([139.82.40.34]:58788 "EHLO
	juno.lps.ele.puc-rio.br") by vger.kernel.org with ESMTP
	id S932544AbVINBRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 21:17:06 -0400
Message-ID: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br>
Date: Tue, 13 Sep 2005 22:17:12 -0300 (BRT)
Subject: libata sata_sil broken on 2.6.13.1
From: izvekov@lps.ele.puc-rio.br
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-6.FC2
X-Mailer: SquirrelMail/1.4.3a-6.FC2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, greetings to all

I have a SIL3112A sata controller, and it oopses on boot if a PATA hd is
connected to it thru a sata-to-pata bridge
(i dont know much about it, but its name is serillel 2 and ships with the
abit nf7-s 2.0 motherboard).
This happens on 2.6.13.1, but was fine under 2.6.12.6.
I couldnt get the full oops message, as the machine locks hard, but i
managed to copy what was on the screen to a piece of paper.

Here it is:

============
[<c01034b2>] common_interrupt+0x1a/0x20
[<c0122950>] __do_softirq+0x30/0x90
[<c0105181>] do_softirq+0x41/0x50
=============
[<c0122a65>] irq_exit+0x35/0x40
[<c0105075>] do_IRQ+0x45/0x60
[<c01034b2>] common_interrupt+0x1a/0x20
[<c010f544>] delay_tsc+0x14/0x20
[<c039fa6f>] ata_pio_complete+0x15f/0x220
[<c03a02c0>] ata_pio_task+0x0/0x80
[<c012e2a0>] worker_thread+0x200/0x2f0
[<c03a0270>] ata_pio_task+0x0/0x80
[<c0119960>] default_wake_function+0x0/0x20
[<c0119960>] default_wake_function+0x0/0x20
[<c012c0a0>] worker_thread+0x0/0x2f0
[<c0132948>] kthread+0xa8/0xe0
[<c01328a0>] kthread+0x0/0xe0
[<c0101395>] kernel_thread_helper+0x5/0x10
handlers:
[<c03a0cc0>] (ata_interrupt+0x0/0x120)
Disabling IRQ #11
ata2: dev 0 ATA, max UDMA/100, 39102336 sectors:
ata2(0): applying bridge limits

And the kernel dies here.

please disregard:
ata2 is slow to respond, please be patient
ata2 failed to respond (30 secs)
because that is probably a design flaw of the bridge. the SIL bios takes
very long to pass thru it if there is nothing connected to the PATA end of
the bridge aswell.

If there is anything else i can do to help, please ask.

And please CC me, as i am not subscribed.

Thanks in advance.


