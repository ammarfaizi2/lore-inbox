Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314058AbSDVGZT>; Mon, 22 Apr 2002 02:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314059AbSDVGZS>; Mon, 22 Apr 2002 02:25:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11477 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314058AbSDVGZS>;
	Mon, 22 Apr 2002 02:25:18 -0400
Date: Sun, 21 Apr 2002 23:16:15 -0700 (PDT)
Message-Id: <20020421.231615.129368238.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: marcelo@conectiva.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TRIVIAL 2.4.19-pre7: smp_call_function not allowed
 from bh
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16zUc3-0000Rk-00@wagner.rustcorp.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Mon, 22 Apr 2002 13:35:34 +1000

It would be nice to fix this up on every other smp_call_function
implementation too.  Since this patch is by definition trivial, it
would be equally trivial to make sure every platform is updated
properly as well.

Please do this before installing the change.

Thanks.

   --- trivial-2.4.19-pre7/arch/i386/kernel/smp.c.orig	Mon Apr 22 13:21:41 2002
   +++ trivial-2.4.19-pre7/arch/i386/kernel/smp.c	Mon Apr 22 13:21:41 2002
   @@ -528,7 +528,7 @@
     * remote CPUs are nearly ready to execute <<func>> or are or have executed.
     *
     * You must not call this function with disabled interrupts or from a
   - * hardware interrupt handler, you may call it from a bottom half handler.
   + * hardware interrupt handler or from a bottom half handler.
     */
    {
    	struct call_data_struct data;
   @@ -544,7 +544,7 @@
    	if (wait)
    		atomic_set(&data.finished, 0);
    
   -	spin_lock_bh(&call_lock);
   +	spin_lock(&call_lock);
    	call_data = &data;
    	wmb();
    	/* Send a message to all other CPUs and wait for them to respond */
