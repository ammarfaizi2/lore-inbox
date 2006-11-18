Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756121AbWKRB02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121AbWKRB02 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 20:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756123AbWKRB02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 20:26:28 -0500
Received: from main.gmane.org ([80.91.229.2]:22226 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1756121AbWKRB01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 20:26:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH] emit logging when a process receives a fatal signal
Date: Sat, 18 Nov 2006 01:26:02 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnelsomr.dd3.olecom@flower.upol.cz>
References: <20061118010946.GB31268@vanheusden.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-18, Folkert van Heusden wrote:
> Hi,
>
> I found that sometimes processes disappear on some heavily used system
> of mine without any logging. So I've written a patch against 2.6.18.2
> which emits logging when a process emits a fatal signal.

Why not to patch default signal handlers in glibc, to have not only
stderr, but syslog, or /dev/kmsg copy of fatal messages?

> Signed-off-by: Folkert van Heusden <folkert@vanheusden.com>
>
> --- linux-2.6.18.2/kernel/signal.c	2006-11-04 02:33:58.000000000 +0100
> +++ linux-2.6.18.2.new/kernel/signal.c	2006-11-17 15:59:13.000000000 +0100
> @@ -706,6 +706,15 @@
>  	struct sigqueue * q = NULL;
>  	int ret = 0;
>  
> +	if (sig == SIGQUIT || sig == SIGILL  || sig == SIGTRAP ||
> +	    sig == SIGABRT || sig == SIGBUS  || sig == SIGFPE  ||
> +	    sig == SIGSEGV || sig == SIGXCPU || sig == SIGXFSZ ||
> +	    sig == SIGSYS  || sig == SIGSTKFLT)
> +	{
> +		printk(KERN_WARNING "Sig %d send to %d owned by %d.%d (%s)\n",
> +			sig, t -> pid, t -> uid, t -> gid, t -> comm);
> +	}
> +
>  	/*
>  	 * fast-pathed signals for kernel-internal things like SIGSTOP
>  	 * or SIGKILL.
>
>
> Folkert van Heusden
>
> www.vanheusden.com/multitail - multitail is tail on steroids. multiple
>                windows, filtering, coloring, anything you can think of
> ----------------------------------------------------------------------
> Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

