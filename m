Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261499AbSIZUcA>; Thu, 26 Sep 2002 16:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbSIZUcA>; Thu, 26 Sep 2002 16:32:00 -0400
Received: from rf.com.br ([200.206.17.114]:63749 "EHLO rf.com.br")
	by vger.kernel.org with ESMTP id <S261499AbSIZUb7>;
	Thu, 26 Sep 2002 16:31:59 -0400
Date: Thu, 26 Sep 2002 17:37:10 -0300
Message-Id: <200209262037.g8QKbAIt008284@rf.com.br>
From: "Joao S Veiga" <jsveiga_lkml@rf.com.br>
To: linux-kernel@vger.kernel.org
Subject: Re: Hangs in 2.4.19 and 2.4.20-pre5 (IDE-related?)
X-Mailer: Nwebmail 0.1.80
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I started getting similar hangs with a PII4X board and an old QUANTUM 
Pioneer SG 2.1A, around 2.4.18-10 (RH). Didn't happen with vanilla 2.4.18 
& before, still happened with vanilla 2.4.19.

I could reproduce it by writing big files to the disk (consistently if 
transfering them from the network - RTL8139, 100BaseT). Like you've 
described, the HDD LED remained lit.

Strangely, the machine kept "some" functionality: It's a firewall/NAT 
machine, and this kept working, hitting Return on an already opened shell 
brought the next line prompt, etc. Trying anything requiring disk access 
would hang. No core dumped, no log messages (of course, since the disk 
couldn't be written).

I ended up changing a BIOS setting : PCI Latency timer from 32 to 128 PCI 
clocks. (I've loaded the BIOS defaults, and "0" came up. Things got really 
worse, so just went the other way - didn't try intermediate values though).

It's working fine now. I'd just like to understand why. I suppose 
something got slower, but I couldn't notice (it's just a 
firewall/NAT/web/mailserver, and the outside link is just 64k).

If you have this setting on the BIOS, give it a try.

Joao
