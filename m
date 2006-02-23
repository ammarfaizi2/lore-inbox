Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWBWQwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWBWQwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWBWQwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:52:14 -0500
Received: from penguin.cohaesio.net ([212.97.129.34]:6113 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP id S1751436AbWBWQwO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:52:14 -0500
Subject: [PATCH] Let DAC960 supply entropy to random pool
From: "Anders K. Pedersen" <akp@cohaesio.com>
To: Dave Olien <dmo@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-Heq8ZNakql8FZMedkwcH"
Organization: Cohaesio A/S
Message-Id: <1140713078.16199.25.camel@homer.cohaesio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 23 Feb 2006 17:44:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Heq8ZNakql8FZMedkwcH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

We have a couple of servers with Mylex RAID controllers (handled by the
DAC960 block device driver). There's normally no keyboard or mouse
attached, and neither the DAC960 nor the NIC driver (e100) provides
entropy to the random pool, so it was impossible to get any data from
/dev/random.

The patch below lets the DAC960 IRQ provide entropy to the random pool,
and after applying this (to 2.6.15.4), /dev/random is able to provide
data on these servers. I fear, that my mailer may line wrap the patch,
so it is also attached to this mail.

--- drivers/block/DAC960.c~	2006-02-23 16:34:47.000000000 +0100
+++ drivers/block/DAC960.c	2006-02-23 16:34:47.000000000 +0100
@@ -3024,7 +3024,7 @@ DAC960_DetectController(struct pci_dev *
      Acquire shared access to the IRQ Channel.
   */
   IRQ_Channel = PCI_Device->irq;
-  if (request_irq(IRQ_Channel, InterruptHandler, SA_SHIRQ,
+  if (request_irq(IRQ_Channel, InterruptHandler,
SA_SHIRQ|SA_SAMPLE_RANDOM,
 		      Controller->FullModelName, Controller) < 0)
   {
 	DAC960_Error("Unable to acquire IRQ Channel %d for Controller at\n",

-- 
Med venlig hilsen - Best regards

Anders K. Pedersen
Network Engineer

--=-Heq8ZNakql8FZMedkwcH
Content-Disposition: attachment; filename=DAC960.random.patch
Content-Type: text/x-patch; name=DAC960.random.patch; charset=ISO-8859-15
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvYmxvY2svREFDOTYwLmN+CTIwMDYtMDItMjMgMTY6MzQ6NDcuMDAwMDAwMDAw
ICswMTAwDQorKysgZHJpdmVycy9ibG9jay9EQUM5NjAuYwkyMDA2LTAyLTIzIDE2OjM0OjQ3LjAw
MDAwMDAwMCArMDEwMA0KQEAgLTMwMjQsNyArMzAyNCw3IEBAIERBQzk2MF9EZXRlY3RDb250cm9s
bGVyKHN0cnVjdCBwY2lfZGV2ICoNCiAgICAgIEFjcXVpcmUgc2hhcmVkIGFjY2VzcyB0byB0aGUg
SVJRIENoYW5uZWwuDQogICAqLw0KICAgSVJRX0NoYW5uZWwgPSBQQ0lfRGV2aWNlLT5pcnE7DQot
ICBpZiAocmVxdWVzdF9pcnEoSVJRX0NoYW5uZWwsIEludGVycnVwdEhhbmRsZXIsIFNBX1NISVJR
LA0KKyAgaWYgKHJlcXVlc3RfaXJxKElSUV9DaGFubmVsLCBJbnRlcnJ1cHRIYW5kbGVyLCBTQV9T
SElSUXxTQV9TQU1QTEVfUkFORE9NLA0KIAkJICAgICAgQ29udHJvbGxlci0+RnVsbE1vZGVsTmFt
ZSwgQ29udHJvbGxlcikgPCAwKQ0KICAgew0KIAlEQUM5NjBfRXJyb3IoIlVuYWJsZSB0byBhY3F1
aXJlIElSUSBDaGFubmVsICVkIGZvciBDb250cm9sbGVyIGF0XG4iLA0K

--=-Heq8ZNakql8FZMedkwcH--
