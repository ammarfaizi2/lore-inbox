Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262876AbUJ1KYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbUJ1KYS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUJ1KTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:19:38 -0400
Received: from mail.parbin.co.uk ([213.162.111.160]:60130 "EHLO
	mail.parbin.co.uk") by vger.kernel.org with ESMTP id S262909AbUJ1KLg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:11:36 -0400
Subject: PCI->APIC IRQ transform -> 267 ?
From: Robert Clark <lkml@ratty.org.uk>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-9zjOHHyrbKGzCd2RtgCY"
Message-Id: <1098958286.6342.63.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Thu, 28 Oct 2004 11:11:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9zjOHHyrbKGzCd2RtgCY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I'm getting this with 2.4.27 (SMP):

PCI: Using IRQ router PIIX [8086/25a1] at 00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P0) -> 18
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B2,I4,P0) -> 27
PCI->APIC IRQ transform: (B3,I4,P0) -> 267
PCI->APIC IRQ transform: (B3,I5,P0) -> 25
PCI->APIC IRQ transform: (B4,I4,P0) -> 267
PCI->APIC IRQ transform: (B4,I4,P1) -> 267
PCI->APIC IRQ transform: (B4,I6,P0) -> 26
PCI->APIC IRQ transform: (B4,I6,P1) -> 27
PCI->APIC IRQ transform: (B5,I9,P0) -> 17
PCI->APIC IRQ transform: (B5,I10,P0) -> 19

  The devices which are being assigned 267 are Ethernet ports and return
error SIOCSIFFLAGS when I try and configure them with ifconfig. Devices
(B4,I6,P0) & (B4,I6,P1) (also Ethernet ports) can be configured with
ifconfig but don't receive any interrupts (according to
/proc/interrupts) and don't work. Devices (B5,I10,P0) & (B3,I5,P0) (more
Ethernet ports) work fine.

  I've tried various combinations of ACPI, APIC & hyperthreading
disabled & enabled but without any luck and I've run out of ideas for
debugging this. Can anyone help?

  The board is a Supermicro P4SCT+II with a 3.2GHz P4 (with
hyperthreading). The devices which are being affected are both PCI-X
Ethernet cards:

Intel PRO/1000MT 4-port Ethernet card (PCI-ID 8086:101D Rev 1)
Intel PRO/100S   2-port Ethernet card (PCI-ID 8086:1229 Rev D)

  I've attached some dmesg info and an lspci -v.

	Robert

--=-9zjOHHyrbKGzCd2RtgCY
Content-Description: dmesg
Content-Type: application/x-gzip
Content-Disposition: attachment; filename=dmesg-2.4.27.txt.gz
Content-Transfer-Encoding: base64

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
oD3tX6iQO+joJQAA

--=-9zjOHHyrbKGzCd2RtgCY
Content-Description: lspci
Content-Type: application/x-gzip
Content-Disposition: attachment; filename=lspci.txt.gz
Content-Transfer-Encoding: base64

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
lSB+mnUvc/fr9LHzP2I6CBoQIAAA

--=-9zjOHHyrbKGzCd2RtgCY--
