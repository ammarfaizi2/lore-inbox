Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTLPKbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 05:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTLPKbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 05:31:05 -0500
Received: from mail.mediaways.net ([193.189.224.113]:62699 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S261299AbTLPKbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 05:31:03 -0500
Subject: crypto-loop + highmen -> random crashes in -test11
From: Soeren Sonnenburg <kernel@nn7.de>
To: akpm@osdl.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: 20031215223438.196295a8.akpm@osdl.org
Content-Type: text/plain
Message-Id: <1071570648.3528.50.camel@localhost>
Mime-Version: 1.0
Date: Tue, 16 Dec 2003 11:30:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I get random crashes/corruption/ init kills when I use cryptoloop on
this highmem enabled ppc machine.

Applying the loop-* patches at
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test10/2.6.0-test10-mm1/broken-out

seem to fix this problem (at least I did not get any crash due to
cryptoloop in the last 2 days)

Steps to reproduce:

dd if=/dev/zero of=/file bs=1M count=100
losetup -e blowfish /dev/loop0 /file
Password:
mkfs -t ext3 /dev/loop0
mount /dev/loop0 /mnt
cd /mnt  
dd if=/dev/zero of=bla

gives you nice unpredictable crashes.


Soeren

