Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWJ0QEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWJ0QEI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 12:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWJ0QEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 12:04:07 -0400
Received: from ns1.suse.de ([195.135.220.2]:18659 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751014AbWJ0QEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 12:04:05 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH] x86_64 add missing enter_idle() calls
Date: Fri, 27 Oct 2006 09:03:44 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20061006081607.GB8793@frankl.hpl.hp.com> <200610211522.53938.ak@suse.de> <20061025212940.GA10003@frankl.hpl.hp.com>
In-Reply-To: <20061025212940.GA10003@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610270903.44810.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 October 2006 14:29, Stephane Eranian wrote:
> Andi,
>
> Looking a the exit_idle() code:
>
> static void __exit_idle(void)
> {
>         if (read_pda(isidle) == 0)
>                 return;
>         write_pda(isidle, 0);
>         atomic_notifier_call_chain(&idle_notifier, IDLE_END, NULL);
> }
>
> I am wondering whether you are exposed to a race condition  w.r.t. to
> interrupts. Supposed you are in idle, you get an interrupt and you execute
> __exit_idle(), the test evaluate to false but before you can change the
> value of isidle, you get a higher priority interrupt which then also calls
> __exit_idle(), the test is still false and you invoke the notifier, when
> you return from this interrupt you also clear the isidle, but you call the
> notifier yet a second time.
>
> I think that isidle needs to be test_and_clear atomically for this to
> guarantee only one call the notifier on __exit_idle().
>
> what do you think?

Agreed. I will fix that. Thanks

-Andi
