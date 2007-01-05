Return-Path: <linux-kernel-owner+w=401wt.eu-S1422639AbXAESBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbXAESBK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 13:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161142AbXAESBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 13:01:10 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:28805 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161172AbXAESBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 13:01:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=xtVJu92kmC8aNKQyrZGzUQQnYCO9PS6h8mzfxEN/D1puAfqqJIYjzWtYQr0BvBXNiloAIZMcuTXXS0RWvXKpD/LM6AyxkhcE06LWFEqxazjaaJIilEctAzsIOmOlB4A5ix4+XRVUgQEEHn3Z4nkI/GX0EfQXpQeKzM9ir5XSZ0Q=  ;
X-YMail-OSG: j6O8zlwVM1nrn47ItXeRU6hvXTgPUG1m0qJXmnU68YLVW5akU105nvUK3nyiVl__QyV2BFksGiyNY8TvQYat.SSugq78.N85OOL5FXiP8JVZJ._4DJBZFfAvOdNkE_71V4NyXRDDe57RFWIFYntMeocK_3OCfWy4qds-
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>,
       rtc-linux@googlegroups.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.20-rc3 0/3] rtc-cmos driver and support
Date: Fri, 5 Jan 2007 09:50:36 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200701050950.37383.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the latest version of an "rtc-cmos" driver, which lets PCs
(and other systems now using drivers/char/rtc.c) use the same RTC
class framework that other Linuxes use.

 - Patch #1 is the rtc-cmos driver itself.  Configure PNPACPI
   and up it comes ... in vanilla mode.

 - Patch #2 adds platform_device support for x86 PCs, so you
   can get that same vanilla functionality without PNPACPI.

 - Patch #3 adds the first non-vanilla functionality, exporting
   some extensions (notably, longer alarms) that ACPI knows about.

This is all pretty clean, and AFAICT ready to merge.  On hardware
I have handy, it's a clean replacement for drivers/char/rtc.c code.

This particular version doesn't supplant the /proc/acpi/alarm
mechanism, since I ripped that logic out for now.  Eventually
that can (and should!!) vanish(*), in favor of the portable
userspace interfaces supported by earlier patch versions, but
I figure there's no rush for that just now.

- Dave

(*) I'd be interested in hearing from anyone who actually uses
    that interface ... if there is anyone.  What do you do with
    it, and how.
