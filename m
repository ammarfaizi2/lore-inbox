Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbUKIXbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbUKIXbx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUKIXbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:31:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:49077 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261775AbUKIXar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:30:47 -0500
Date: Tue, 9 Nov 2004 15:30:16 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       venkatesh.pallipadi@intel.com
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: [PATCH] timer: fix up problem where two sysdev_class devices had the same name.
Message-ID: <20041109233016.GA8025@kroah.com>
References: <20041109193043.GA8767@vrfy.org> <20041109225245.GB7618@kroah.com> <d120d50004110915196517dd37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50004110915196517dd37@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Kay Sievers for reporting this.  

Was caused by a change from Venkatesh Pallipadi as seen at:
  http://linux.bkbits.net:8080/linux-2.5/cset@41810e4aGZ0E5bn_hMb4JgIY5u90zA

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	2004-11-09 15:25:54 -08:00
+++ b/arch/i386/kernel/timers/timer_pit.c	2004-11-09 15:25:54 -08:00
@@ -181,7 +181,7 @@
 }
 
 static struct sysdev_class timer_sysclass = {
-	set_kset_name("timer"),
+	set_kset_name("timer_pit"),
 	.resume	= timer_resume,
 };
 
