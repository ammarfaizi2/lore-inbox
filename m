Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967540AbWK2Syg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967540AbWK2Syg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 13:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967544AbWK2Syg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 13:54:36 -0500
Received: from ns2.nsc.liu.se ([130.236.101.9]:18394 "EHLO papput.nsc.liu.se")
	by vger.kernel.org with ESMTP id S967540AbWK2Syg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 13:54:36 -0500
From: Peter Kjellstrom <cap@nsc.liu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] oprofile: add a warning for unsuppored CPUs
Date: Wed, 29 Nov 2006 19:54:55 +0100
User-Agent: KMail/1.9.3
Cc: trivial@kernel.org, levon@movementarian.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611291954.57548.cap@nsc.liu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Kjellstrom <cap@nsc.liu.se>

Oprofile first tries to setup hardware counter based profiling. If this fails
it falls back to timer mode without any clues as to what went wrong. This
patch adds a warning when no supported CPU is found (typically too new CPU
and/or too old kernel).

Signed-off-by: Peter Kjellstrom <cap@nsc.liu.se>

---

--- a/arch/i386/oprofile/init.c
+++ b/arch/i386/oprofile/init.c
@@ -29,6 +29,8 @@ int __init oprofile_arch_init(struct opr

 #ifdef CONFIG_X86_LOCAL_APIC
        ret = op_nmi_init(ops);
+       if (ret == -ENODEV)
+               printk(KERN_INFO "oprofile: hardware counters unavailable, unknown cpu.\n");
 #endif
 #ifdef CONFIG_X86_IO_APIC
        if (ret < 0)
