Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUA1Pse (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266053AbUA1Pr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:47:26 -0500
Received: from palrel13.hp.com ([156.153.255.238]:19109 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266066AbUA1Pm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:42:59 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16407.55422.229863.840323@napali.hpl.hp.com>
Date: Wed, 28 Jan 2004 07:42:54 -0800
To: Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Subject: Re: [RFC/PATCH, 3/4] readX_check() performance evaluation
In-Reply-To: <00a401c3e541$c1d347f0$2987110a@lsd.css.fujitsu.com>
References: <00a401c3e541$c1d347f0$2987110a@lsd.css.fujitsu.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 28 Jan 2004 10:54:42 +0900, Hironobu Ishii <ishii.hironobu@jp.fujitsu.com> said:

  Hironobu> This is a patch for rawread 1.0.3.
  Hironobu> Original rawread 1.0.3 depends on i386.

  Hironobu> --- rawread.c.old 2004-01-22 19:33:43.000000000 +0900
  Hironobu> +++ rawread.c 2004-01-27 23:26:24.406717936 +0900
  Hironobu> @@ -94,8 +94,14 @@

  Hironobu> __inline__ unsigned long long int rdtsc()
  Hironobu> {
  Hironobu> -  unsigned long long int x;
  Hironobu> -  __asm__ volatile (".byte 0x0f, 0x31" : "=A" (x));
  Hironobu> + unsigned long long int x;
  Hironobu> +#if __i386__
  Hironobu> + __asm__ volatile (".byte 0x0f, 0x31" : "=A" (x));
  Hironobu> +#elif __ia64__
  Hironobu> + __asm__ volatile ("mov r8 = ar44");
  Hironobu> +#else
  Hironobu> + #error "Please write your own rdtsc()"
  Hironobu> +#endif
  Hironobu> return x;
  Hironobu> }

Inline assembly doesn't work with the Intel compiler on ia64.  I
suggest to use ia64_get_itc() defined in <asm/delay.h> instead.

	--david
