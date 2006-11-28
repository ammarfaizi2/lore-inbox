Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936079AbWK1T6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936079AbWK1T6X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936081AbWK1T6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:58:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:5604 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S936079AbWK1T6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:58:22 -0500
Date: Tue, 28 Nov 2006 20:56:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch] x86_64: fix earlyprintk=...,keep regression
Message-ID: <20061128195653.GA24577@elte.hu>
References: <20061128081405.GA9031@elte.hu> <Pine.LNX.4.64.0611281048170.4244@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611281048170.4244@woody.osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> -	if (!strcmp(buf,"keep"))
> +	if (!strncmp(buf,"keep", 4)) {
>  		keep_early = 1;
> -
> -	if (!strncmp(buf, "serial", 6)) {
> +	} else if (!strncmp(buf, "serial", 6)) {
>  		early_serial_init(buf + 6);
>  		early_console = &early_serial_console;

nope, that doesnt work, because the function call is a one-time thing 
via the early_console_initialized flag. Nor does this keep compatibility 
with the 2.6.18 API, my existing boot-entries:

        root (hd0,4)
        kernel /boot/bzImage-x64 root=/dev/hda5 \
	earlyprintk=serial,ttyS0,115200,keep console=ttyS0,115200 console=tty

stopped working.

I agree that the parameter parsing here is a bit hacky, but my patch 
restores the original behavior, so i think that's the best option for 
now.

	Ingo
