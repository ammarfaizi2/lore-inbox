Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263922AbUDVKnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbUDVKnB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 06:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbUDVKnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 06:43:01 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:23247 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263922AbUDVKm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 06:42:59 -0400
From: Chris Bainbridge <C.J.Bainbridge@ed.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: (yet another) probable GPL violation
Date: Thu, 22 Apr 2004 11:42:57 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404221142.57990.C.J.Bainbridge@ed.ac.uk>
X-OriginalArrivalTime: 22 Apr 2004 10:43:01.0210 (UTC) FILETIME=[956773A0:01C42856]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Inexq ISW054t is a 802.11g broadband router with 4 port switch. It's 
getting quite popular due to its low price. I suspect that it runs linux, yet 
comes with no mention of the GPL. I've emailed Inexq (the company formerly 
known as Unex) but they haven't replied. 

You can download the firmware from : ftp://ftp.inexq.com/Drivers/ISW054t.zip

The zip contains a file 
ISW054t-S1-200712T3.img which `file` identies as "PPCBoot image"

strings shows:
Uncompressing Linux...
Ok, booting the kernel.
UNEX-GISL-T-L2-200712T3_U.bin

Theres a gzip image at offset 0x2048 which unpacks to 1.8MB : 
dd if=ISW054t-S1-200712T3.img bs=8264 skip=1 |zcat > 
UNEX-GISL-T-L2-200712T3_U.bin

I've searched for the usual magic numbers but can't find the root fs. Any 
pointers would be appreciated. 

Some interesting things from the firmware:

It contains the dynamic ip software from http://www.no-ip.com
Networking is done by http://www.octotech.com/products-cyberwall.html. They 
offer NAT, firewalling, dhcp etc. as a linux module.
It contains this weird Moe line - 
http://lists.samba.org/archive/wireless/2002-November/002152.html
A USB stack from http://www.softconnex.com/
ISL3890 Prism 802.11g chipset driver - firmware starts at 'PACKPACKPACK'
The string "Linksys" appears 5 times (?)
Theres a hidden test html page at http://router/UE/Main
Contains Allegro-Software-RomPager embedded web server

This is the first embedded linux router I've heard of with a Prism 802.11g 
chipset. It'll be interesting to see if it can be turned into a 100% open 
source with the prism54 drivers. I haven't checked any of the other Inexq 
products, but if they use linux for this its likely that they've used it in 
other routers.
