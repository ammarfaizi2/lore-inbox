Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWIKJrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWIKJrm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 05:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWIKJrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 05:47:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1933 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932212AbWIKJrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 05:47:41 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060909051211.GA6922@elte.hu> 
References: <20060909051211.GA6922@elte.hu>  <20060908153236.21015.56106.stgit@warthog.cambridge.redhat.com> <20060908153240.21015.67367.stgit@warthog.cambridge.redhat.com> 
To: Ingo Molnar <mingo@elte.hu>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 2/3] FRV: Permit __do_IRQ() to be dispensed with 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 11 Sep 2006 10:47:02 +0100
Message-ID: <7359.1157968022@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:

> The real solution would be to use gcc -ffunction-sections plus ld 
> --gc-sections to automatically get rid of unused global functions, at 
> link time.

It's easy.  It's already possible with FRV.  Just add the attached patch and
enable the new option.  However, you also need to compile without debugging
code, otherwise it has little effect.  I think stabs links bring stuff in or
something.

David
---
diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index 5e6583a..0dc3730 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -342,6 +342,14 @@ menu "Power management options"
 source kernel/power/Kconfig
 endmenu
 
+config GC_SECTIONS
+       bool "Garbage collect unused functions and data"
+       default y
+       help
+         Tell the compiler to place all functions and variables in their own
+         sections and then tell the linker to discard any section that aren't
+         referred to.
+
 endmenu
 
 
