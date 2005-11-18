Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbVKRKyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbVKRKyM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 05:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbVKRKyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 05:54:11 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:9371 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1161032AbVKRKyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 05:54:11 -0500
Date: Fri, 18 Nov 2005 18:55:26 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-rc1-mm2
Message-ID: <20051118105526.GA6401@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20051109134938.757187000@localhost.localdomain> <20051109141454.336639000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117234645.4128c664.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch should fix a link error:

arch/i386/kernel/built-in.o: In function `parse_cmdline_early':
: undefined reference to `elfcorehdr_addr'
arch/i386/kernel/built-in.o: In function `parse_cmdline_early':
: undefined reference to `elfcorehdr_addr'

Regards,
Wu
---

 arch/i386/kernel/setup.c   |    2 +-
 arch/x86_64/kernel/setup.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc1-mm2.orig/arch/i386/kernel/setup.c
+++ linux-2.6.15-rc1-mm2/arch/i386/kernel/setup.c
@@ -898,7 +898,7 @@ static void __init parse_cmdline_early (
 			}
 		}
 #endif
-#ifdef CONFIG_CRASH_DUMP
+#ifdef CONFIG_PROC_VMCORE
 		/* elfcorehdr= specifies the location of elf core header
 		 * stored by the crashed kernel.
 		 */
--- linux-2.6.15-rc1-mm2.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.15-rc1-mm2/arch/x86_64/kernel/setup.c
@@ -418,7 +418,7 @@ static __init void parse_cmdline_early (
 		}
 #endif
 
-#ifdef CONFIG_CRASH_DUMP
+#ifdef CONFIG_PROC_VMCORE
 		/* elfcorehdr= specifies the location of elf core header
 		 * stored by the crashed kernel. This option will be passed
 		 * by kexec loader to the capture kernel.
