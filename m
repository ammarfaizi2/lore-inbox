Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264624AbTFELvs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 07:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbTFELvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 07:51:48 -0400
Received: from smtp03.uc3m.es ([163.117.136.123]:51985 "EHLO smtp.uc3m.es")
	by vger.kernel.org with ESMTP id S264624AbTFELvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 07:51:46 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200306051205.h55C5At08035@oboe.it.uc3m.es>
Subject: sleep under spinlock detection
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Thu, 5 Jun 2003 14:05:09 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've put a prototype c-code analyser on the net at

 ftp://oboe.it.uc3m.es/pub/Programs/c-1.0.tgz

It currently is only detecting sleep under spinlock (and needs another
pass to do it with full accuracy). But it's a start. I've run it over
about 28KLOC so far.

  % ./c -D__KERNEL__ -DMODULE -I/usr/local/src/linux-2.4.17rc2-xfs/include ../dbr/1/sbull.c
  gcc -D__KERNEL__ -DMODULE -I/usr/local/src/linux-2.4.17rc2-xfs/include -E ../dbr/1/sbull.c  -o .gcc-nM5VVc
  eek! index 353 has no key in db
  can't find key 353!
  eek! index 352 has no key in db
  can't find key 352!
  eek! index 352 has no key in db
  can't find key 352!
  eek! index 352 has no key in db
  can't find key 352!
  smb_lock_server is sleepy because it calls down.4605
  lock_parent is sleepy because it calls down.6287
  double_down is sleepy because it calls down.6310
  triple_down is sleepy because it calls down.6340
  double_lock is sleepy because it calls double_down.6358
  lock_super is sleepy because it calls down.9463
  sbull_ioctl is sleepy because it calls interruptible_sleep_on.10021
  ***
  *** sleep under spinlock at file="../dbr/1/sbull.c" about line=420
  ***
  sbull_request is sleepy because it calls interruptible_sleep_on.10182
  sbull_init is sleepy because it calls kfree.10244
  sbull_cleanup is sleepy because it calls kfree.10264

Peter
