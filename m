Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVJMKxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVJMKxw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 06:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbVJMKxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 06:53:52 -0400
Received: from 36-71-dsl.ipact.nl ([84.35.71.36]:39592 "EHLO
	office.scorpion.nl") by vger.kernel.org with ESMTP id S1750853AbVJMKxw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 06:53:52 -0400
Message-ID: <025d01c5cfe4$5889b4c0$3d64880a@speedy>
Reply-To: "Christiaan den Besten" <chris@scorpion.nl>
From: "Christiaan den Besten" <chris@scorpion.nl>
To: "Pauli Borodulin" <pauli.borodulin@uta.fi>
Cc: <linux-kernel@vger.kernel.org>
References: <049f01c5b215$91e7c4b0$3d64880a@speedy> <434E3A86.4030509@uta.fi>
Subject: Re: Machine dies under heavy I/O or network-access ..?
Date: Thu, 13 Oct 2005 12:53:29 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-KM95-MailScanner: Found to be clean
X-MailScanner-From: chris@scorpion.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Our situation has cleared up a little bit. Our Areca Raid-controller had troubles with Maxtor SATA disks and died eventually. They 
fixed this in a new firmware release (at least, we are testing that right now ...).

I have been playing with sysctl.conf as well:

---
# 5s will give us between 200 and 260Mb dirty buffer ...
vm.dirty_background_ratio = 5
vm.dirty_ratio = 75
---

By keeping the dirty buffer somewhat lower (250M) it seems to be preventing the system from using too much memory. If I recall 
correct I have seen 'some' assertions, but never fatal anymore.

bye,
Chris

----- Original Message ----- 
From: "Pauli Borodulin" <pauli.borodulin@uta.fi>
To: "Christiaan den Besten" <chris@scorpion.nl>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, October 13, 2005 12:44 PM
Subject: Re: Machine dies under heavy I/O or network-access ..?

Christiaan den Besten wrote:
> [...]
> Today I noticed the following assertion in dmesg:
> ---
> e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
> KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (279)
> KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c
> (148)
> ---
> [...]

I upgraded ten of our servers to 2.6.13.3 on tuesday and noticed today
that the following assertations were in one server's dmesg:

KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (279)
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (151)

This server has e1000 NIC just like most of the servers I upgraded. The
difference in our situation is that the server which logged the
assertions is still running fine. Previous kernel version on the servers
was 2.6.12.2 and it was used over 90 days without any problems.


Br,
-- 
Pauli Borodulin <pauli.borodulin@uta.fi>
Systems Analyst, tel. +358 3 3551 7892
Computer Centre / Room B4179
University of Tampere, Finland 

