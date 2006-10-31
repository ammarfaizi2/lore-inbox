Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161627AbWJaJS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161627AbWJaJS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161628AbWJaJS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:18:27 -0500
Received: from gw.leta.ru ([88.210.57.114]:17323 "EHLO gw.leta.ru")
	by vger.kernel.org with ESMTP id S1161627AbWJaJS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:18:26 -0500
X-Virus-Scanner: This message was checked by NOD32 Antivirus system
	NOD32 for Linux Mail Server.
	For more information on NOD32 Antivirus System,
	please, visit our website: http://www.nod32.com/.
Date: Tue, 31 Oct 2006 12:18:15 +0300
From: Pavel Fedin <sonic_amiga@rambler.ru>
X-Mailer: The Bat! (v3.80.06) Professional
Reply-To: Pavel Fedin <sonic_amiga@rambler.ru>
X-Priority: 3 (Normal)
Message-ID: <9335882.20061031121815@rambler.ru>
To: linux-kernel@vger.kernel.org
Subject: pcap misses packets - HELP!!!
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0138], Confidential/Release
  SMTP-Filter Version 2.0.0 [0124], KAS/Release
X-Spamtest-Info: Pass through
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, all!

 I need to sniff a email traffic on a heavily loaded network.
Currently i try to use dsniff package whose operation is based on
libpcap. There are problems related to packet loss. Some packets are
just not captured, this causes severe troubles (for example missing
FIN packet leads to abandoned connection tracking and memory leak).
Missing pieces of mails are also not good.
 This problem happens when more than one stream of large data is
transferred concurrently (for example we send more than one 2 mb
message via SMTP at the same moment). A friend of mine told that this
is known problem of pcap which addresses packet copying from kernel
space to user space.
 Are there any alternative solutions working in PROMISC mode (the
traffic is running between two machines which we can't modify by
project conditions and we have a third machine on this network with
an interface in PROMISC mode)? I've tried iptables ULOG target, but
this catches only UDP broadcasts despite i set PROMISC for the
interface using ifconfig.
 May be some cnahging sysctl values helps here? I've looked at the
kernel source and learned that dropping packets being captured depends
on socket input buffer size and something other in skbuff subsystem
(some conditions which are unclear to me).

-- 
Best regards,
 Pavel                          mailto:sonic_amiga@rambler.ru

