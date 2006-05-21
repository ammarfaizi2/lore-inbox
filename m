Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWEUNO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWEUNO0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 09:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWEUNO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 09:14:26 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:43163 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964868AbWEUNOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 09:14:25 -0400
Date: Sun, 21 May 2006 17:14:30 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ACRYPTO] New asynchronous crypto layer release.
Message-ID: <20060521131429.GA9789@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Sun, 21 May 2006 17:14:32 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New asynchronous crypto layer acrypto [1] release.
It includes new driver for HIFN 7955/7956 adapters,
VIA padlock driver, driver for CE-InfoSys FastCrypt PCI card equipped
with a SuperCrypt CE99C003B and
dm-crypt and IPsec ESP4 engines ported to acrypto.

Psec ESP4 transport mode benchmark (scp):
        2.6.16-1.2069_FC4smp -> vanilla 2.6.16-git: ~11.8 MB/s
	vanilla 2.6.16-git -> 2.6.16-1.2069_FC4smp: ~13.2 MB/s

	2.6.16-1.2069_FC4smp -> acrypto SW 2.6.16: ~12.6 MB/s
	acrypto SW 2.6.16 -> 2.6.16-1.2069_FC4smp: ~13.5 MB/s

IPsec benchmark with HIFN driver:
	2.6.16-1.2069_FC4smp -> vanilla 2.6.16-git: ~11.8 MB/s
	vanilla 2.6.16-git -> 2.6.16-1.2069_FC4smp: ~13.2 MB/s

	2.6.16-1.2069_FC4smp -> acrypto HIFN 2.6.16: ~13.2 MB/s
	acrypto HIFN 2.6.16 -> 2.6.16-1.2069_FC4smp: ~13.5 MB/s

As you might expect, CPU usage with HIFN driver and acrypto is noticebly
less, since that setup is CPU limited for stock synchronous kernel
setup (3Ghz P4 with HT enabled).
Above numbers drift with the time, especially when machine running
stock FC4 kernel overheats, and that numbers decrease to 12-13 MB/s.

One can find combined patchsets for 2.6.15 and 2.6.16 trees which
include acrypto with SW crypto provider, dm-crypt and IPsec engines
at acrypto homepage [1].

Credits.
Yakov Lerner for great testing and bug-hunting.
Michal Ludvig for original VIA padlock and fcrypt drivers.


Thank you.

1. Asynchronous crypto layer acrypto.
http://tservice.net.ru/~s0mbre/old/?section=projects&item=acrypto

-- 
	Evgeniy Polyakov
