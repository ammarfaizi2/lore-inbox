Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262459AbSI2MlD>; Sun, 29 Sep 2002 08:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262466AbSI2MlC>; Sun, 29 Sep 2002 08:41:02 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:22533 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S262459AbSI2Mk7>;
	Sun, 29 Sep 2002 08:40:59 -0400
Message-ID: <3D96F771.E6D7B2B0@tv-sign.ru>
Date: Sun, 29 Sep 2002 16:52:01 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: [UPATCH] force_sig_info()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This is my third attempt:

On Mon, 16 Sep 2002, Oleg Nesterov wrote:
> 2.5.34 introduced this change in force_sig_info()
> 
> -	return send_sig_info(sig, info, t);
> +	return send_sig_info(sig, (void *)1, t);
> 
> I beleive, it is wrong, info can carry useful information
> from do_page_fault, traps. And this (info *)1 does not
> prevent send_signal() from allocation of siginfo struct.
> Ingo, could you please clarify?

Call me stupid, but i still believe it is bug.

--- linux-2.5.39/kernel/signal.c~	Sun Sep 29 16:37:08 2002
+++ linux-2.5.39/kernel/signal.c	Sun Sep 29 16:37:35 2002
@@ -781,7 +781,7 @@
 	recalc_sigpending_tsk(t);
 	spin_unlock_irqrestore(&t->sigmask_lock, flags);
 
-	return send_sig_info(sig, (void *)1, t);
+	return send_sig_info(sig, info, t);
 }
 
 static int

Oleg.
