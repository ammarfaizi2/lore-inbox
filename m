Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266191AbSKLEWw>; Mon, 11 Nov 2002 23:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266197AbSKLEWw>; Mon, 11 Nov 2002 23:22:52 -0500
Received: from dp.samba.org ([66.70.73.150]:3980 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266191AbSKLEWv>;
	Mon, 11 Nov 2002 23:22:51 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15824.33674.343838.639008@argo.ozlabs.ibm.com>
Date: Tue, 12 Nov 2002 15:28:58 +1100
To: linux-kernel@vger.kernel.org
Subject: Why does sys_rt_sigreturn call do_sigaltstack?
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in both 2.4 and 2.5, the kernel saves the current alternate
signal stack setting when invoking the handler for a real-time signal,
and restores that setting on return from the handler.

More precisely, in setup_rt_frame, the kernel saves current->sas_ss_sp
and current->sas_ss_size in the ucontext that it sets up (in
frame->uc.uc_stack).  Then, in sys_rt_sigreturn, it copies
frame->uc.uc_stack back in and calls do_sigaltstack with the copy.
This is on x86; ppc does something similar too.

Why does it do this?  It seems rather bizarre to me, given that
sigaltstack() is not per-signal, its effect is global.  Is there some
requirement that the effect of a sigaltstack() call during a real-time
signal handler should only be allowed to persist until the handler
returns?  If so, can someone please point me at where it says that in
some standards document?

Thanks,
Paul.
