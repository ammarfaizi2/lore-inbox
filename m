Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbSLOXBc>; Sun, 15 Dec 2002 18:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbSLOXBc>; Sun, 15 Dec 2002 18:01:32 -0500
Received: from mx1.mail.ru ([194.67.57.11]:22791 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id <S263215AbSLOXBb>;
	Sun, 15 Dec 2002 18:01:31 -0500
Message-ID: <001701c2a48f$4b7606e0$a9043ac3@r66.ru>
From: "Ilya Teterin" <alienhard@mail.ru>
To: <linux-kernel@vger.kernel.org>
Subject: arp poisoning immunity
Date: Mon, 16 Dec 2002 04:11:26 +0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here is a patch (URL: http://securitylab.ru/_tools/antidote2.diff.gz) for
linux kernel (2.4.18 and .19 tested) to resisting ARP spoofing (improves LAN
security). Comments are welcome.

If applied, it brings a new sysctl parameter:

net.ipv4.neigh.<interface name>.arp_antidote

that defines kernel behaviour when changes in correspondence between MAC
and IP are detected.

Parameter value 0 corresponds standart behaviour, ARP cache will be
silently updated.

Value=1..3 corresponds "verification" behaviour. Kernel will send ARP
request to test if there is a host at "old" MAC address. If such
response received it lets us know than one IP pretends to have
several MAC addresses at one moment, that probably caused by ARP spoof
attack.

Value=1 - just report attack and ignore spoofing attempt.
Value=2 - ARP cache record will be marked as "static" to prevent attacks
in future.
Value=3 - ARP cache record will be marked as "banned", no data will be
delivered to attacked IP anymore, untill system administrator unban
ARP record updating it manually.

