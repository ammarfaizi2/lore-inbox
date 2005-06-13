Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVFMNjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVFMNjs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 09:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVFMNjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 09:39:47 -0400
Received: from mailservice.tudelft.nl ([130.161.131.5]:50457 "EHLO
	mailservice.tudelft.nl") by vger.kernel.org with ESMTP
	id S261556AbVFMNj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 09:39:26 -0400
Subject: [PATCH] apm.c: ignore_normal_resume is set a bit too late
From: Thomas Hood <jdthood@aglu.demon.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, 310865-submitter@bugs.debian.org,
       Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20050613222003.2895ac2c.sfr@canb.auug.org.au>
References: <1118655939.7066.37.camel@thanatos>
	 <20050613222003.2895ac2c.sfr@canb.auug.org.au>
Content-Type: multipart/mixed; boundary="=-HR9AzgaoW4J+b8i4OBbY"
Date: Mon, 13 Jun 2005 15:50:26 +0200
Message-Id: <1118670626.7066.84.camel@thanatos>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HR9AzgaoW4J+b8i4OBbY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-06-13 at 22:20 +1000, Stephen Rothwell wrote:
> I am not using APM any more and have no way to test such a change.  So,
> can you please do a proper patch with comment and Signed-off-by line and
> send it to Andrew Morton (akpm@osdl.org) (and cc lkml, I guess).  When I
> see it, I will Ack it to Andrew.


Summary: apm: Prevent double APM resume on Thinkpad X31

This patch causes the ignore_normal_resume flag to be set slightly
earlier, before there is a chance that the apm driver will receive the
normal resume event from the BIOS.  (Addresses Debian bug #310865)

Signed-off-by: Thomas Hood <jdthood@yahoo.co.uk>

-- 
Thomas Hood <jdthood@aglu.demon.nl>

--=-HR9AzgaoW4J+b8i4OBbY
Content-Disposition: attachment; filename=apm.c_double_resume_fix_20050613jdth1.patch
Content-Type: text/x-patch; name=apm.c_double_resume_fix_20050613jdth1.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- kernel-source-2.6.11/arch/i386/kernel/apm.c_ORIG	2005-03-02 08:37:47.000000000 +0100
+++ kernel-source-2.6.11/arch/i386/kernel/apm.c	2005-06-13 14:59:51.000000000 +0200
@@ -1220,13 +1220,13 @@ static int suspend(int vetoable)
 
 	save_processor_state();
 	err = set_system_power_state(APM_STATE_SUSPEND);
+	ignore_normal_resume = 1;
 	restore_processor_state();
 
 	write_seqlock_irq(&xtime_lock);
 	spin_lock(&i8253_lock);
 	reinit_timer();
 	set_time();
-	ignore_normal_resume = 1;
 
 	spin_unlock(&i8253_lock);
 	write_sequnlock_irq(&xtime_lock);

--=-HR9AzgaoW4J+b8i4OBbY--

