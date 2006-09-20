Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWITCni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWITCni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 22:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWITCnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 22:43:14 -0400
Received: from smtp-out.google.com ([216.239.45.12]:53787 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750834AbWITCnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 22:43:06 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:message-id:x-mailer;
	b=nMKPyw6DDUMsA3zQ/8JHqBHd4R2CIpISMueOE+k3cgt+x0Si+tM1aJfOXbZdxa9r6
	wI+GaToBczm73yp0L9SaQ==
From: Dmitriy Zavin <dmitriyz@google.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Subject: therm_throt: Refactor and improve thermal throttle processing
Date: Tue, 19 Sep 2006 19:42:38 -0700
Message-Id: <11587201623432-git-send-email-dmitriyz@google.com>
X-Mailer: git-send-email 1.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set factors out the thermal throttle processing code
from i386 and x86_64 into a separate file (therm_throt.c).
This allows consistent reporting of CPU thermal throttle events.
Furthermore, a counter is added to /sys that keeps track of the
number of thermal events, such that the user knows how bad the
thermal problem might be (since the logging to syslog and mcelog
is rate limited).

 arch/i386/kernel/cpu/mcheck/Makefile      |    2
 arch/i386/kernel/cpu/mcheck/p4.c          |   26 +---
 arch/i386/kernel/cpu/mcheck/therm_throt.c |  185 ++++++++++++++++++++++++++++++
 arch/x86_64/kernel/Makefile               |    4
 arch/x86_64/kernel/mce_intel.c            |   29 +---
 include/asm-i386/therm_throt.h            |    9 +
 include/asm-x86_64/therm_throt.h          |    1
 include/linux/jiffies.h                   |   12 +
 8 files changed, 227 insertions(+), 41 deletions(-)




