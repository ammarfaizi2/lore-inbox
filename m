Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271814AbTG2QHs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 12:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271839AbTG2QHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 12:07:48 -0400
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:51104
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S271814AbTG2QF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 12:05:58 -0400
Message-ID: <32460.216.12.38.216.1059494755.squirrel@www.ghz.cc>
In-Reply-To: <1059491223.6094.6.camel@dhcp22.swansea.linux.org.uk>
References: <28705.216.12.38.216.1059490232.squirrel@www.ghz.cc>
    <1059491223.6094.6.camel@dhcp22.swansea.linux.org.uk>
Date: Tue, 29 Jul 2003 12:05:55 -0400 (EDT)
Subject: Re: [REPOST] "apm: suspend: Unable to enter requested state" after 
     2.5.31 (incl. 2.6.0testX)
From: "Charles Lepple" <clepple@ghz.cc>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox said:
> Does it work any better if you change the 0x0, 0x00409200 to
>
> 0x00109300, 0x00409200 ?

Is this what you're referring to?

--- arch/i386/kernel/apm.c.orig 2003-07-27 12:57:00.000000000 -0400
+++ arch/i386/kernel/apm.c      2003-07-29 11:18:52.000000000 -0400
@@ -424,7 +424,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
 static struct apm_user *       user_list;
 static spinlock_t              user_list_lock = SPIN_LOCK_UNLOCKED;
-static struct desc_struct      bad_bios_desc = { 0, 0x00409200 };
+static struct desc_struct      bad_bios_desc = { 0x00109300, 0x00409200 };
 static char                    driver_version[] = "1.16ac";    /* no
spaces */

I tried this on top of 2.6.0-test2, and it didn't work. Where does the
first number in that initializer come from?

In case it has something to do with the APM entry points:

  apm: entry fcd4:0 cseg16 f000 dseg 9f80 [...]

thanks,

-- 
Charles Lepple <clepple@ghz.cc>
http://www.ghz.cc/charles/
