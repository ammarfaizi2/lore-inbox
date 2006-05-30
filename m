Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWE3TO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWE3TO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWE3TO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:14:59 -0400
Received: from mx1.suse.de ([195.135.220.2]:36574 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932427AbWE3TO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:14:58 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] lock validator: disable NMI watchdog if CONFIG_LOCKDEP, i386
References: <20060530022925.8a67b613.akpm@osdl.org>
	<20060530111138.GA5078@elte.hu> <1148990326.7599.4.camel@homer>
	<1148990725.8610.1.camel@homer> <20060530120641.GA8263@elte.hu>
	<1148991422.8610.8.camel@homer> <20060530121952.GA9625@elte.hu>
	<1148992098.8700.2.camel@homer> <20060530122950.GA10216@elte.hu>
From: Andi Kleen <ak@suse.de>
Date: 30 May 2006 21:14:54 +0200
In-Reply-To: <20060530122950.GA10216@elte.hu>
Message-ID: <p73mzcz1g0h.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
> 
> The NMI watchdog uses spinlocks (notifier chains, etc.),
> so it's not lockdep-safe at the moment.

That's totally unsafe even without lockdep and should be fixed
instead. I guess someone bungled the notifier chain conversion.
The NMI notifiers need to be lockless.

-Andi
