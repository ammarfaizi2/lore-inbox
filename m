Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWFBTro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWFBTro (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWFBTrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:47:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:21419 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932551AbWFBTrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:47:08 -0400
Date: Fri, 2 Jun 2006 21:47:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Clark Williams <williams@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: -rt x86_64 fix for latency tracing
Message-ID: <20060602194731.GA1104@elte.hu>
References: <4480938E.3060005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4480938E.3060005@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5004]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


good catch!

	Ingo

* Clark Williams <williams@redhat.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Ingo/Steve,
> 
> The included patch fixes a bug that causes a segfault in the init
> thread when latency tracing is enabled on x86_64 kernels. Not sure if
> it's completely correct, but it gets me past my segfault and lets me
> complete booting.
> 
> diff --git a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
> index 066497a..b124409 100644
> - --- a/arch/x86_64/kernel/entry.S
> +++ b/arch/x86_64/kernel/entry.S
> @@ -1089,7 +1089,7 @@ ENTRY(mcount)
>  
>         mov 0x0(%rbp),%rax
>         mov 0x8(%rbp),%rdi
> - -       mov 0x8(%rax),%rsi
> +       mov 0x10(%rax),%rsi
>  
>         call   __trace
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.3 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iD8DBQFEgJOOHyuj/+TTEp0RAhkEAKDWQu4cvGBvCQi1UyQcDalbR6SPZACglMRH
> rVy1tTWHbatDx37pXHAXs1s=
> =5Qi9
> -----END PGP SIGNATURE-----
