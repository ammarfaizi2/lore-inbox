Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbTIEBJv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbTIEBJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:09:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:65176 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261945AbTIEBIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:08:31 -0400
Message-ID: <32901.4.4.25.4.1062724109.squirrel@www.osdl.org>
Date: Thu, 4 Sep 2003 18:08:29 -0700 (PDT)
Subject: Re: [PATCH] ikconfig - resolve rebuild permissions
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <sam@ravnborg.org>
In-Reply-To: <20030904191353.GA10448@mars.ravnborg.org>
References: <20030904113133.3f950a51.shemminger@osdl.org>
        <20030904191353.GA10448@mars.ravnborg.org>
X-Priority: 3
Importance: Normal
Cc: <shemminger@osdl.org>, <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Sep 04, 2003 at 11:31:33AM -0700, Stephen Hemminger wrote:
>> This patch fixes it by removing the configs.o file when
>> needed.
>
> A better approach would be to remove the need for compile.h from
> configs.c. See attached patch for the makefile change.
> It just took the relevant part from mk_compile and
> used it in the Makefile.
> Example only - I expect Randy to integrate it properly.

configs.o also wants UTS_RELEASE from compile.h, and
I really dislike generating the same data in multiple places,
so I prefer to continue to use compile.h.
I'll see about other options or using Steve's patch.

Thanks,
~Randy


> ===== kernel/Makefile 1.33 vs edited =====
> --- 1.33/kernel/Makefile	Mon Sep  1 01:13:58 2003
> +++ edited/kernel/Makefile	Thu Sep  4 21:05:29 2003
> @@ -19,6 +19,7 @@
>  obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
>  obj-$(CONFIG_COMPAT) += compat.o
>  obj-$(CONFIG_IKCONFIG) += configs.o
> +CFLAGS_configs.o = -DLINUX_COMPILER="$(shell $(CC) -v 2>&1 | tail -n 1)"
>
>  ifneq ($(CONFIG_IA64),y)
>  # According to Alan Modra <alan@linuxcare.com.au>, the
> -fno-omit-frame-pointer is
> -



