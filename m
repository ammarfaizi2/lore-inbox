Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265955AbUFTVuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUFTVuU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265957AbUFTVuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:50:20 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:13209 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S265955AbUFTVuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:50:06 -0400
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.4  (F2.72; T1.001; A1.62; B3.01; Q3.01)
Cc: "Ron Day" <ronmon@bellsouth.net>
References: <20040620121101.34274f68@mimi.ronmon.shacknet.nu>
Subject: Re: SCSI related hang on boot
In-Reply-To: <20040620121101.34274f68@mimi.ronmon.shacknet.nu>
To: linux-kernel@vger.kernel.org
Date: Sun, 20 Jun 2004 16:50:04 -0500
From: "Kai OM" <epimetreus@fastmail.fm>
X-Sasl-Enc: 6wkWBc+nh1de/k1JEMNFxQ 1087768204
Message-Id: <1087768204.30717.198812673@webmail.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got an LSIU160 controller, which means that it has two actual
controllers, an exterior and an interior one.
The exterior one is disabled in the controller's BIOS, because I have no
use for it.
The interior on is terminated immediately after the drive I have
connected to it.
I'm wondering if the driver is somehow ignoring(at least in my case)
fact that the disabled controller is, in fact, disabled, and is getting
thrown off because I never bothered to buy a terminator for it, when
it's not supposed to ever be active.
I'm not a SCSI expert, though, so I'm prolly wrong.

----- Original message -----
From: "Ron Day" <ronmon@bellsouth.net>
To: linux-kernel@vger.kernel.org
Date: Sun, 20 Jun 2004 12:11:01 -0400
Subject: Re: SCSI related hang on boot

Please CC me on this, since I'm not a list member.

I've been following this thread and hoping for an answer. The problem
I'm having, as well as my hardware, is very similar to this. 

For the record, my equipment:

ASUS A7M-266D, 2 x Athlon MP1800+, 1024MB ECC registered

Tekram DC-390U3W, Symbios Logic (LSI) 53c1010 chipset.
	Running for 2+ years with sym53c8xx_2 driver. It
	replaced a Fireport40 that ran for 2-3 years with
	the same driver and the earlier sym53c8xx (v1)
	with older/slower/smaller HDD's.

Bus0, terminated in-line after second HDD
2 x U160 HDD's, id 0 and 1 (2+ years running)

Bus1, terminated in-line at scanner
An internal Yamaha SCSI CD-RW, id 2 (3-4 years running)
A UMAX S-12 scanner, id 5 (8+ years running)

Everything goes as expected through sym0, where the
two HDD's reside, but problems arise at sym1. Compared
to successful dmesg output, it seems that the scanner
(and hence the termination for that bus) is not seen.

My conclusion is that sym2.1.18i works and sym2.1.18j
does not. I say this because I have made a copy of the 
drivers/scsi/sym53c8xx_2 directory from 2.6.5 (the latest
that I'm aware of with the .i drivers). By replacing the
files in current kernels with these, I have compiled and
run several newer versions sucessfully, the latest being
2.6.7, which I'm running now.

Rather than post everything here, I'll link to some files that should be
relevant.

The error (written down and typed in, no serial console):
http://ronmon.shacknet.nu/configs/scsi_boot_error

Output from a good dmesg (sym2.1.18.i driver):
http://ronmon.shacknet.nu/configs/dmesg_good-2.6.7-rc3

Brief system layout courtesy of phpsysinfo:
http://ronmon.shacknet.nu/phpsysinfo/

Output from 'lspci -vvx':
http://ronmon.shacknet.nu/configs/lspci-vvx
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
