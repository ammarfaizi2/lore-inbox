Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbUBWJav (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 04:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbUBWJav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 04:30:51 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:15489 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261896AbUBWJau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 04:30:50 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Mike Strosaker <strosake@austin.ibm.com>
Subject: Re: [PATCH] arch-specific callout in panic()
Date: Mon, 23 Feb 2004 10:25:05 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402231025.05630.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Strosaker <strosake@austin.ibm.com> wrote:
>@@ -53,7 +53,8 @@
>        static char buf[1024];
>        va_list args;
>  #if defined(CONFIG_ARCH_S390)
>-        unsigned long caller = (unsigned long) __builtin_return_address(0);
>+       extern unsigned long panic_caller;
>+        panic_caller = (unsigned long) __builtin_return_address(0);
>  #endif
>
>        bust_spinlocks(1);
...
>+       machine_panic();
>+

Why don't you just pass __builtin_return_address(0) to machine_panic for
everyone? It will get you rid of the #ifdef completely and the argument
can still be ignored.
Also, arch_panic() might be a little clearer than machine_panic().

	Arnd <><

