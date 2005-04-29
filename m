Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVD2N04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVD2N04 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 09:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVD2N0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 09:26:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:37082 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262639AbVD2NXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 09:23:19 -0400
Date: Fri, 29 Apr 2005 06:20:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: 2.6.12-rc3 mmap lack of consistency among runs
Message-Id: <20050429062053.2c9943ce.akpm@osdl.org>
In-Reply-To: <0563I2L12@server5.heliogroup.fr>
References: <0563I2L12@server5.heliogroup.fr>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Tonneau <hubert.tonneau@fullpliant.org> wrote:
>
> Andrew Morton wrote:
> >
> > Maybe you're being bitten by the address space randomisation.
> > 
> > Try
> > 	echo 0 > /proc/sys/kernel/randomize_va_space
> 
> Ok, it solves my issue, but:
> 
> . desabling it through 'echo 0 > /proc/sys/kernel/randomize_va_space' is not
>   a solution because only the application knows that it wants it to be desabled,
>   and the application is not root so cannot write to /proc; morever the
>   application can only speak for itself so desabling should be on a per process
>   bias.

You can disable randomization on a per-executable basis by setting an ELF
personality.  I forget the magic incantation.  Arjan?

>   I can hardly imagine to publish a warning in the README such as:
>   This software only works if your Linux kernel is configured so that
>   /proc/sys/kernel/randomize_va_space = 0
> 
> . second, my process restart succeeding roughly in 50% cases means that the
>   randomisation performed is just a toy. A virus assuming fixed memory layout
>   will still succeed 50% of times to install.

Dunno.

> All in all, I'm not concerned about Linux kernel to randomise or not,
> but I need to have a reliable way to request a memory region and be granted
> that I can request the same one in a futur run.
> What is the proper way to get such a memory area ?

MAP_FIXED?
