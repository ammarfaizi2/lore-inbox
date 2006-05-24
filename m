Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWEXEkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWEXEkc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 00:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbWEXEkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 00:40:32 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:11966 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932570AbWEXEkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 00:40:32 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>, vgoyal@in.ibm.com,
       ebiederm@xmission.com
Message-Id: <20060524044232.14219.68240.sendpatchset@cherry.local>
Subject: [PATCH 00/03] kexec: Avoid overwriting the current pgd (V2)
Date: Wed, 24 May 2006 13:40:31 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kexec: Avoid overwriting the current pgd (V2)

This patch updates the kexec code for i386 and x86_64 to avoid overwriting
the current pgd. For most people is overwriting the current pgd is not a big
problem. When kexec:ing into a new kernel that reinitializes and makes use of 
all memory we don't care about saving state.

But overwriting the current pgd is not a good solution in the case of kdump 
(CONFIG_CRASH_DUMP) where we want to preserve as much state as possible when 
a crash occurs. This patch solves the overwriting issue.

20060524: V2

- Broke out architecture-specific data structures into asm/kexec.h
- Fixed a i386/PAE page table problem only triggering on real hardware.
- Moved segment handling code into the assembly routines.

20060501: V1

- First release

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
