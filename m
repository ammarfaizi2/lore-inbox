Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWIKXDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWIKXDi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWIKXDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:03:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63621 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932322AbWIKXDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:03:37 -0400
Date: Mon, 11 Sep 2006 16:03:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386-pda: Initialize the PDA early, before any C code
 runs.
Message-Id: <20060911160301.10789d6e.akpm@osdl.org>
In-Reply-To: <4505E8C1.7010906@goop.org>
References: <4505E8C1.7010906@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2006 15:52:49 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Initialize the PDA early, before any C code runs.
> 
> This patch makes sure the PDA is usable in head.S, before any C code
> is run.
> 
> On the boot CPU, this is done by using a temporary boot_pda which is
> initialized appropriately.  It is replaced with a proper PDA when the
> proper GDT is installed.
> 
> For secondary CPUs, the GDT and PDA are pre-allocated and initialized.
> head.S just needs to set %gs and load the GDT.
> 
> In the process, this removes the need for early_smp_processor_id() and
> early_current().
> 
> ...
>
> +/* Initial PDA used by boot CPU */
> +struct i386_pda boot_pda = {
> +	._pda = &boot_pda,
> +	.cpu_number = 0,
> +	.pcurrent = &init_task,
> +};

What is likely to happen if the boot CPU is not CPU #0?  (iirc Voyager does
that?)

