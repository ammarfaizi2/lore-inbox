Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUFLN5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUFLN5x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 09:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUFLN5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 09:57:53 -0400
Received: from nepa.nlc.no ([195.159.31.6]:65468 "HELO nepa.nlc.no")
	by vger.kernel.org with SMTP id S264791AbUFLN5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 09:57:52 -0400
Message-ID: <1469.83.109.11.80.1087048662.squirrel@nepa.nlc.no>
In-Reply-To: <20040612134413.GA3396@sirius.home>
References: <Pine.LNX.4.44.0406112308100.13607-100000@chimarrao.boston.redhat.com>
      <20040612134413.GA3396@sirius.home>
Date: Sat, 12 Jun 2004 15:57:42 +0200 (CEST)
Subject: Re: timer + fpu stuff locks my console race
From: stian@nixia.no
To: "Sergey Vlasov" <vsu@altlinux.ru>
Cc: "Rik van Riel" <riel@redhat.com>, linux-kernel@vger.kernel.org,
       stian@nixia.no
User-Agent: SquirrelMail/1.4.0-1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.6.6/include/asm-i386/i387.h.fp-lockup	2004-05-10 06:33:06
> +0400
> +++ linux-2.6.6/include/asm-i386/i387.h	2004-06-12 17:25:56 +0400
> @@ -51,7 +51,6 @@
>  #define __clear_fpu( tsk )					\
>  do {								\
>  	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
> -		asm volatile("fwait");				\
>  		(tsk)->thread_info->status &= ~TS_USEDFPU;	\
>  		stts();						\
>  	}							\

But what about task-switching and fpu-exceptions that comes in late? I
know that the kernel does not use FPU in general, and the places it does,
fsave, fwait and frstor embeddes it all in kernel-space.


Stian Skjelstad
