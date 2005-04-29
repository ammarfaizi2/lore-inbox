Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbVD3AjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbVD3AjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 20:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbVD3AjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 20:39:25 -0400
Received: from s-utl01-lapop.stsn.com ([12.129.240.11]:45714 "HELO
	s-utl01-lapop.stsn.com") by vger.kernel.org with SMTP
	id S263093AbVD3AgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 20:36:20 -0400
Subject: Re: 2.6.12-rc3 mmap lack of consistency among runs
From: Arjan van de Ven <arjan@infradead.org>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <0563I2L12@server5.heliogroup.fr>
References: <0563I2L12@server5.heliogroup.fr>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 09:29:59 -0400
Message-Id: <1114781399.6077.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 12:44 +0000, Hubert Tonneau wrote:
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

there is the setarch command that you can use to disable it on a per
process basis.

> . second, my process restart succeeding roughly in 50% cases means that the
>   randomisation performed is just a toy. A virus assuming fixed memory layout
>   will still succeed 50% of times to install.

actually no. 
It just means that half the time the old value was below the current
boundary, and half the time above. Eg half the time it was in free
space.


> All in all, I'm not concerned about Linux kernel to randomise or not,
> but I need to have a reliable way to request a memory region and be granted
> that I can request the same one in a futur run.

glibc also has some randomisations in places (for cache performance) as
did kernels before 2.6.11 on p4 hyperthreading machines (granted that
was very small randomisation)

The only reliable ways I can think of is to either take a predetermined
address, or to mmap a big chunk first, then your real chunk and then
free the first chunk. Neither are clean or pretty




