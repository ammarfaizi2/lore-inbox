Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275023AbTHLC6O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 22:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275024AbTHLC6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 22:58:14 -0400
Received: from main.gmane.org ([80.91.224.249]:48546 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S275023AbTHLC6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 22:58:06 -0400
Mail-Followup-To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: ilmari@ilmari.org (=?utf-8?b?RGFnZmlubiBJbG1hcmkg?=
	=?utf-8?b?TWFubnPDpWtlcg==?=)
Subject: Re: C99 Initialisers
Date: Tue, 12 Aug 2003 04:57:53 +0200
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Message-ID: <d8jzniflgzy.fsf@wirth.ping.uio.no>
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost>
 <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
Mail-Copies-To: never
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
Cancel-Lock: sha1:tjOYvPtEe+GRVQzs+NwV53CiI3o=
Cc: kernel-janitor-discuss@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:

> On Mon, Aug 11, 2003 at 07:18:53PM -0700, Robert Love wrote:
>> Convert GNU-style to C99-style.  I think converting unnamed initializers
>> to named initializers is a Good Thing, too.
>
> By and large ... here's a counterexample:

[snip unnamed initialisation]

> I don't think anyone would appreciate you converting that to:

[snip C99 named initialisation]

To the contrary (and I agree with Jeff):

From: Jeff Garzik <jgarzik@pobox.com>
To: davej@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] c99 initialisers for random.c
Message-ID: <20030811144709.GA32180@gtf.org>
References: <E19mCuO-0003da-00@tetrachloride>

On Mon, Aug 11, 2003 at 02:40:24PM +0100, davej@redhat.com wrote:
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/random.c linux-2.5/drivers/char/random.c
> --- bk-linus/drivers/char/random.c	2003-08-04 01:00:22.000000000 +0100
> +++ linux-2.5/drivers/char/random.c	2003-08-06 18:59:31.000000000 +0100
>@@ -1850,27 +1850,62 @@ static int uuid_strategy(ctl_table *tabl
> }
> 
> ctl_table random_table[] = {
>-	{RANDOM_POOLSIZE, "poolsize",
>-	 &sysctl_poolsize, sizeof(int), 0644, NULL,
>-	 &proc_do_poolsize, &poolsize_strategy},
[...]
>-       {0}
>+	{
>+		.ctl_name	= RANDOM_POOLSIZE,
>+		.procname	= "poolsize",
>+		.data		= &sysctl_poolsize,
>+		.maxlen		= sizeof(int),
>+		.mode		= 0644,
>+		.proc_handler	= &proc_do_poolsize,
>+		.strategy	= &poolsize_strategy,
>+	},
[...]
>+	{ .ctl_name = 0 }
> };
> 
> static void sysctl_init_random(struct entropy_store *random_state)

Wow.  That is so much more clean (to my eyes).

	Jeff

-- 
ilmari

