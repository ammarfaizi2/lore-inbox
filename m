Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUC1PYL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 10:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbUC1PYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 10:24:11 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:54535 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S261885AbUC1PYK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 10:24:10 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Linux 2.4.26-rc1
Date: Sun, 28 Mar 2004 17:24:02 +0200
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <20040328042608.GA17969@logos.cnet>
In-Reply-To: <20040328042608.GA17969@logos.cnet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403281724.03136.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Sunday 28 of March 2004 06:26, Marcelo Tosatti napisa³:
> Finally, -rc1.
>
> The first -rc contains an ACPI update, networking fixes, amongst others.
ACPI uses cmpxchg so it's not possible to build it for i386 it seems.

+__acpi_release_global_lock (unsigned int *lock)
+{
+       unsigned int old, new, val;
+       do {
+               old = *lock;
+               new = old & ~0x3;
+               val = cmpxchg(lock, old, new);
+       } while (unlikely (val != old));
+       return old & 0x1;
+}

/home/areq/rpm/BUILD/linux-2.4.25/arch/i386/lib/lib.a /home/areq/rpm/BUILD/linux-2.4.25/lib/lib.a /home/areq/rpm/BUILD/linux-2.4.25/arch/i386/lib/lib.a 
\
--end-group \
-o vmlinux
drivers/acpi/acpi.o(.text+0x4cf4): In function `acpi_ev_global_lock_handler':
: undefined reference to `cmpxchg'
drivers/acpi/acpi.o(.text+0x4dc6): In function `acpi_ev_acquire_global_lock':
: undefined reference to `cmpxchg'
drivers/acpi/acpi.o(.text+0x4e4b): In function `acpi_ev_release_global_lock':
: undefined reference to `cmpxchg'

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
