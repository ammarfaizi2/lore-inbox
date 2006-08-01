Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWHATNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWHATNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWHATNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:13:36 -0400
Received: from ns1.suse.de ([195.135.220.2]:17834 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751810AbWHATNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:13:35 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/33] x86_64: 64bit PIC SMP trampoline
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<11544302441424-git-send-email-ebiederm@xmission.com>
From: Andi Kleen <ak@suse.de>
Date: 01 Aug 2006 21:13:33 +0200
In-Reply-To: <11544302441424-git-send-email-ebiederm@xmission.com>
Message-ID: <p738xm81d7m.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:
> -	ljmpl	$__KERNEL32_CS, $(startup_32-__START_KERNEL_map)
> +
> +	# flush prefetch and jump to startup_32
> +	ljmpl	*(startup_32_vector - r_base)
> +
> +	.code32
> +	.balign 4
> +startup_32:

It would be nicer if you could factor out that code into
a common file between head.S and trampoline.S

-Andi

