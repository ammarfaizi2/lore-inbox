Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbULAN1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbULAN1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 08:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbULAN1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 08:27:47 -0500
Received: from mx1.elte.hu ([157.181.1.137]:62861 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261240AbULAN1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 08:27:45 -0500
Date: Wed, 1 Dec 2004 14:27:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-17
Message-ID: <20041201132710.GA8328@elte.hu>
References: <41AD9A33.3070205@cola.voip.idv.tw> <20041201113746.GA21640@elte.hu> <20041201115221.GA22697@elte.hu> <41ADBE1C.9010807@cola.voip.idv.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ADBE1C.9010807@cola.voip.idv.tw>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Wen-chien Jesse Sung <jesse@cola.voip.idv.tw> wrote:

> I redo the test with a vanilla 2.6.10-rc2-mm3-V0.7.31-16 again, and it
> still hangs at hwclock. Here's the complete config file.

ok, could you try the -17 kernel i've just uploaded to the usual place:

    http://redhat.com/~mingo/realtime-preempt/

does this fix the lockup?

i believe the lockup is an interesting side-effect of threading IRQ#0:
any code within the kernel that loops on jiffies will produce a lockup,
because it starves the timer IRQ thread.

The RTC driver had two such places, but i also found one in the
IRQ-autodetect code. We want to eliminate such code anyway, and a lockup
is certainly an effective way to detect it ;)

to debug such lockups in the future you can do:

	echo 1 > /proc/sys/kernel/debug_direct_keyboard
	/sbin/hwclock ...

and use the sysrq keys to get a stack dump of the lockup. NOTE: dont use
the keyboard in this mode for too long, it can lock up.

	Ingo
