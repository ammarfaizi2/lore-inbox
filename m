Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbTKGWMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbTKGWLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:11:30 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:55727 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S264474AbTKGQs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 11:48:26 -0500
X-Sender-Authentication: net64
Date: Fri, 7 Nov 2003 17:48:24 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Bug Report: 2.4.23-pre9 / SIS chipset / sundance
Message-Id: <20031107174824.4853e437.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just experienced a problem with a configuration that is known to only work
with ACPI. It consists of:

P-III 1,4 GHz
Mainboard with SIS 630E chipset
Adaptec 29160 Controller
DLINK DFE-580 TX (four port card) (sundance driver)

A slightly different setup is known to work with 2.4.19 and ACPI patch. Problem
with this SIS chipset is interrupt sharing. If you do not use ACPI the box
freezes sometime.
The known-to-work setup is identical besides it contains a tulip-based four
port ethernet card (old DLINK cards).
We stress-tested the working box by NFS-copying data to the local hd over an
ethernet port that shares its interrupt with the aic.

The above failing setup with sundance driver results in network hanging, but no
other negative points. The network hang can be cured by "mii-tool -r <device>"
(restart autonegotiation). After that everything works well, until the next
hang.
During the network hang the shared interrupt (aic + ethernet) still counts up. 
Maybe the sundance driver just misses an interrupt and hangs, and restarting
autonegotiation resets some internals.

I can try whatever patch you like, this is no production setup.

Regards,
Stephan
