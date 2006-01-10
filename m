Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWAJUtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWAJUtI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWAJUtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:49:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57069 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932439AbWAJUtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:49:06 -0500
Date: Tue, 10 Jan 2006 15:48:59 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: David Howells <dhowells@redhat.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [patch] remove unnecessary asm/mutex.h from kernel/mutex-debug.c
In-Reply-To: <2758.1136902767@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.58.0601101546120.2133@devserv.devel.redhat.com>
References: <2758.1136902767@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Jan 2006, David Howells wrote:

> I've found a compilation error in mutexes when using the null variety:
> 
> 	In file included from kernel/mutex-debug.c:25:
> 	kernel/mutex-debug.h:23:1: warning: "__IP__" redefined
> 	In file included from include/asm/mutex.h:9,
> 			 from kernel/mutex-debug.c:23:
> 	include/asm-generic/mutex-null.h:15:1: warning: this is the location of the previous definition

ok, the patch below should solve this. This didnt trigger on any of the
existing arches until now, because neither used asm-generic/null.h as
their method. I build-tested the patch. Linus, please apply.

	Ingo
--

remove unnecessary (and incorrect) inclusion of asm/mutex.h, pointed out 
by David Howells.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/mutex-debug.c |    2 --
 1 files changed, 2 deletions(-)

Index: linux/kernel/mutex-debug.c
===================================================================
--- linux.orig/kernel/mutex-debug.c
+++ linux/kernel/mutex-debug.c
@@ -20,8 +20,6 @@
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
 
-#include <asm/mutex.h>
-
 #include "mutex-debug.h"
 
 /*
