Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161291AbWASE0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161291AbWASE0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 23:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161293AbWASE0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 23:26:00 -0500
Received: from mailout1.pacific.net.au ([61.8.0.84]:7144 "EHLO
	mailout1.pacific.net.au") by vger.kernel.org with ESMTP
	id S1161291AbWASEZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 23:25:59 -0500
Date: Thu, 19 Jan 2006 15:25:37 +1100
Message-Id: <200601190425.k0J4PbGD024378@typhaon.pacific.net.au>
From: "David Luyer" <david@luyer.net>
To: LKML <linux-kernel@vger.kernel.org>, rick@linuxmafia.com
Subject: Resolution: ASUS A7V-E SE + Linux Kernel 2.6.15.1 + SATA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem -- 30 seconds for each disk IO operation, followed by
syslog messages such as:

  ata1: slow completion (cmd ef)
  ata2: slow completion (cmd ef)
  ata1: command 0x25 timeout, stat 0x50 host_stat 24
  ata2: command 0x25 timeout, stat 0x50 host_stat 24

The cause -- the ASUS A7V-E with the sata_via driver does not
receive interupts without ACPI enabled (yet another Via IRQ quirk,
or incomplete handing or the currently known quirks?).  Once ACPI
is enabled, the SATA works perfectly, on both a A7V-E SE and a
A7V-E Deluxe.

These VT8237R based boards use a VT6420 Serial ATA chip
(attention http://linuxmafia.com/faq/Hardware/sata.html maintainer!).

The next problems seem to be 64-bit regions being used for the
ethernet (SKGE) and Nvida 7800GTX on a 32-bit kernel causing
the drivers for these devices to refuse to load.

David.
-- 
David Luyer
Pacific Internet (Australia) Pty Ltd
Business card: http://www.luyer.net/bc.html
Important notice: http://www.pacific.net.au/disclaimer/
