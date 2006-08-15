Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932778AbWHOOGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbWHOOGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932775AbWHOOGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:06:03 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:53222 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S932778AbWHOOGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:06:01 -0400
Date: Tue, 15 Aug 2006 23:07:41 +0900 (JST)
Message-Id: <20060815.230741.41198421.anemo@mba.ocn.ne.jp>
To: rjw@sisk.pl
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200608141954.29656.rjw@sisk.pl>
References: <20060813012454.f1d52189.akpm@osdl.org>
	<200608141954.29656.rjw@sisk.pl>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 19:54:29 +0200, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem.patch
> 
> makes my x86_64 SMP box (dual-core Athlon 64 on an ULi-based AsRock mobo) run
> _very_ slow (it would take tens of minutes to boot the box if I were as
> patient as to wait for that).
> 
> Strangely enough, on a non-SMP box I have tested it on it works just fine.

Oh, my fault.

Could you retry with this patch?

diff -urp linux-2.6.18-rc4-mm1.org/arch/x86_64/kernel/time.c linux-2.6.18-rc4-mm1/arch/x86_64/kernel/time.c
--- linux-2.6.18-rc4-mm1.org/arch/x86_64/kernel/time.c	2006-08-13 22:59:27.000000000 +0900
+++ linux-2.6.18-rc4-mm1/arch/x86_64/kernel/time.c	2006-08-15 23:01:55.631372704 +0900
@@ -417,6 +417,8 @@ void main_timer_handler(struct pt_regs *
 
 	if (lost > 0)
 		handle_lost_ticks(lost, regs);
+	else
+		lost = 0;
 
 /*
  * Do the timer stuff.

