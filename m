Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWFBTiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWFBTiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWFBTiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:38:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30645 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932178AbWFBTiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:38:09 -0400
Message-ID: <4480938E.3060005@redhat.com>
Date: Fri, 02 Jun 2006 14:37:50 -0500
From: Clark Williams <williams@redhat.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: -rt x86_64 fix for latency tracing
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ingo/Steve,

The included patch fixes a bug that causes a segfault in the init
thread when latency tracing is enabled on x86_64 kernels. Not sure if
it's completely correct, but it gets me past my segfault and lets me
complete booting.

diff --git a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
index 066497a..b124409 100644
- --- a/arch/x86_64/kernel/entry.S
+++ b/arch/x86_64/kernel/entry.S
@@ -1089,7 +1089,7 @@ ENTRY(mcount)
 
        mov 0x0(%rbp),%rax
        mov 0x8(%rbp),%rdi
- -       mov 0x8(%rax),%rsi
+       mov 0x10(%rax),%rsi
 
        call   __trace

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEgJOOHyuj/+TTEp0RAhkEAKDWQu4cvGBvCQi1UyQcDalbR6SPZACglMRH
rVy1tTWHbatDx37pXHAXs1s=
=5Qi9
-----END PGP SIGNATURE-----

