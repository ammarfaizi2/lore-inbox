Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422784AbWJTWPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422784AbWJTWPr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423235AbWJTWPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:15:46 -0400
Received: from twin.jikos.cz ([213.151.79.26]:22975 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1422784AbWJTWPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:15:46 -0400
Date: Sat, 21 Oct 2006 00:14:34 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Bryce Harrington <bryce@osdl.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Martin Peschke <mp3@de.ibm.com>
Subject: Re: 2.6.19-rc2-mm2 not building on ia64
In-Reply-To: <20061020205742.GU10386@osdl.org>
Message-ID: <Pine.LNX.4.64.0610210007020.29022@twin.jikos.cz>
References: <20061020205742.GU10386@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006, Bryce Harrington wrote:

> We're seeing the following error building the 2.6.19-rc2-mm2 kernel on
> ia64 (it builds ok on x86_64).  2.6.19-rc2-git4 builds ok.
>   CC [M]  drivers/acpi/processor_throttling.o
> arch/ia64/sn/kernel/setup.c: In function `sn_setup':
> arch/ia64/sn/kernel/setup.c:470: error: `ia64_timestamp_clock' undeclared (first use in this function)
> arch/ia64/sn/kernel/setup.c:470: error: (Each undeclared identifier is reported only once
> arch/ia64/sn/kernel/setup.c:470: error: for each function it appears in.)
>   CC      fs/ext2/namei.o
> make[2]: *** [arch/ia64/sn/kernel/setup.o] Error 1
> make[1]: *** [arch/ia64/sn/kernel] Error 2
> make: *** [arch/ia64/sn] Error 2
> make: *** Waiting for unfinished jobs....

(added relevant CCs)

This is caused by 
statistics-infrastructure-make-printk_clock-a-generic-kernel-wide-nsec-resolution.patch

I wonder how this could ever compile :) 

Andrew, could you please apply this trivial on top of the original one?

[PATCH] IA64: Fix compile problem in arch/ia64/sn/setup.c

Rename forgotten occurence of ia64_printk_clock to ia64_timestamp_clock

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

---

 arch/ia64/sn/kernel/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
index 911000a..d3cf595 100644
--- a/arch/ia64/sn/kernel/setup.c
+++ b/arch/ia64/sn/kernel/setup.c
@@ -65,7 +65,7 @@ extern void sn_timer_init(void);
 extern unsigned long last_time_offset;
 extern void (*ia64_mark_idle) (int);
 extern void snidle(int);
-extern unsigned long long (*ia64_printk_clock)(void);
+extern unsigned long long (*ia64_timestamp_clock)(void);
 
 unsigned long sn_rtc_cycles_per_second;
 EXPORT_SYMBOL(sn_rtc_cycles_per_second);

-- 
Jiri Kosina
