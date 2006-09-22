Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWIVAsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWIVAsx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 20:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWIVAsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 20:48:42 -0400
Received: from smtp-out.google.com ([216.239.45.12]:10848 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932147AbWIVAsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 20:48:23 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:message-id:x-mailer;
	b=QSy3gKIPuBXMIp0azvLo5704IMxAtCAFhiB1ASMP1wj70+kxXoJ0v3Fyn/CTHEgXs
	DCK6U0mGLfoZCBYGqvGiw==
From: Dmitriy Zavin <dmitriyz@google.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Subject: [PATCH 0/4 v2] therm_throt: Refactor thermal throttle processing, and keep a total count of events.
Date: Thu, 21 Sep 2006 17:48:00 -0700
Message-Id: <11588860842488-git-send-email-dmitriyz@google.com>
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

Tested on 32bit and 64bit Intel P4 Xeons.

Differences from last cut:
 - No more #ifdef CONFIG_X86_64.. sorry Andi :). x86_64 specific
   code is in arch/x86_64/kernel/mce.c
 - Commented the need/use for time_before64/time_after64.
   (I addressed Andi Kleen's concern about these macros in a
    followup from last attempt, but never got a response.)
 - More comments in therm_throt.c and individual patch descriptions

 arch/i386/kernel/cpu/mcheck/Makefile      |    2
 arch/i386/kernel/cpu/mcheck/p4.c          |   26 +---
 arch/i386/kernel/cpu/mcheck/therm_throt.c |  171 ++++++++++++++++++++++++++++++
 arch/x86_64/kernel/Makefile               |    4
 arch/x86_64/kernel/mce.c                  |   27 ++++
 arch/x86_64/kernel/mce_intel.c            |   30 +----
 include/asm-i386/therm_throt.h            |    9 +
 include/asm-x86_64/mce.h                  |    4
 include/asm-x86_64/therm_throt.h          |    1
 include/linux/jiffies.h                   |   15 ++
 10 files changed, 248 insertions(+), 41 deletions(-)


