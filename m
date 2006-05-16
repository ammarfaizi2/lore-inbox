Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWEPPPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWEPPPX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWEPPPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:15:22 -0400
Received: from mx1.suse.de ([195.135.220.2]:54934 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932088AbWEPPPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:15:20 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH 3/3] reliable stack trace support (i386)
Date: Tue, 16 May 2006 17:15:11 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <4469FC41.76E4.0078.0@novell.com>
In-Reply-To: <4469FC41.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605161715.11405.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 16:22, Jan Beulich wrote:
> These are the i386-specific pieces to enable reliable stack traces. This is
> going to be even more useful once CFI annotations get added to he assembly
> code, namely to entry.S (a patch for that had been submitted several times).

Yes we should merge that. Can you resend it please?

> +static asmlinkage void show_trace_unwind(struct unwind_frame_info *info, void *log_lvl)

static asmlinkage ?

> +#define UNW_PC(frame) (frame)->regs.eip
> +#define UNW_SP(frame) (frame)->regs.esp
> +#ifdef CONFIG_FRAME_POINTER
> +#define UNW_FP(frame) (frame)->regs.ebp
> +#define FRAME_RETADDR_OFFSET 4
> +#define FRAME_LINK_OFFSET 0
> +#define STACK_BOTTOM(tsk) (((tsk)->thread.esp0 - 1) & ~(THREAD_SIZE - 1))
> +#define STACK_TOP(tsk) ((tsk)->thread.esp0)
> +#endif

Same comments as for x86-64

-Andi
