Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbULZOdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbULZOdY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 09:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbULZOdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 09:33:22 -0500
Received: from 36-71-dsl.ipact.nl ([84.35.71.36]:18108 "EHLO
	office.scorpion.nl") by vger.kernel.org with ESMTP id S261657AbULZOcn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 09:32:43 -0500
Message-ID: <41CECB71.1050601@scorpion.nl>
Date: Sun, 26 Dec 2004 15:32:17 +0100
From: Christiaan den Besten <chris@scorpion.nl>
Reply-To: chris@scorpion.nl
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IPSEC traffic duplicated on interface.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-KM95-MailScanner: Found to be clean
X-MailScanner-From: chris@scorpion.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all !

Not really sure this is a kernel, or a netfilter issue, but posting anyway.

After trying to determine the 'overhead' of my ipsec traffic, I hit a 
rather annoying 'feature'.

(Using racoon ipsec with default debian-kernels 2.6.x kernels, but issue 
was with 2.4 as well if i remember correctly.)

Traffic on the outgoing interface (eth0) shows both the encapsulated as 
well as the non-encapsulated packets.

--- (tcpdump -i eth0 -n ) ---
15:24:20.003088 IP 172.20.40.45.45707 > 10.136.100.1.48193: . 
297216:298592(1376) ack 1 win 5792 <nop,nop,timestamp 920412777 2654747912>
15:24:20.005095 IP 130.161.82.9 > 84.35.71.36: 
ESP(spi=0x080d4f70,seq=0x1de7c)
15:24:20.005095 IP 172.20.40.45.45707 > 10.136.100.1.48193: . 
298592:299968(1376) ack 1 win 5792 <nop,nop,timestamp 920412777 2654747912>
15:24:20.005223 IP 84.35.71.36 > 130.161.82.9: 
ESP(spi=0x0451e539,seq=0xee8e)
---

Using default tools a la 'iptraf' count them both, so it would look like 
my adsl-line is doing 11Mbit :)

Is there any way to prevent the kernel from showing the data inside the 
tunnel ? (172.20.40.45 <> 10.136.100.1 is the tunneled traffic).

bye,
Chris
