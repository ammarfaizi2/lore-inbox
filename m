Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751841AbWHUKT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbWHUKT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 06:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWHUKT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 06:19:27 -0400
Received: from ns2.suse.de ([195.135.220.15]:61900 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751841AbWHUKT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 06:19:26 -0400
From: Andi Kleen <ak@suse.de>
To: Magnus Damm <magnus@valinux.co.jp>
Subject: Re: [PATCH][RFC] x86_64: Reload CS when startup_64 is used.
Date: Mon, 21 Aug 2006 12:19:09 +0200
User-Agent: KMail/1.9.3
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
In-Reply-To: <20060821095328.3132.40575.sendpatchset@cherry.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608211219.09042.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  
> +	/* Reload CS with a value that is within our GDT. We need to do this
> +	 * if we were loaded by a 64 bit bootloader that happened to use a 
> +	 * CS that is larger than the GDT limit. This is true if we came here
> +	 * from kexec running under Xen.
> +	 */
> +	movq	%rsp, %rdx
> +	movq	$__KERNEL_DS, %rax
> +	pushq	%rax /* SS */
> +	pushq	%rdx /* RSP */
> +	movq	$__KERNEL_CS, %rax
> +	movq	$cs_reloaded, %rdx
> +	pushq	%rax /* CS */
> +	pushq	%rdx /* RIP */
> +	lretq

Can't you just use a normal far jump? That might be simpler.

-Andi
