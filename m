Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbULHLg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbULHLg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 06:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbULHLg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 06:36:59 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:34797 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261189AbULHLg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 06:36:56 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Date: Wed, 8 Dec 2004 20:37:33 +0900
User-Agent: KMail/1.5.4
Cc: phil.el@wanadoo.fr, John Levon <levon@movementarian.org>,
       linux-kernel@vger.kernel.org
References: <200412081830.51607.amgta@yacht.ocn.ne.jp> <200412081834.38462.amgta@yacht.ocn.ne.jp> <20041208111316.GA24484@elte.hu>
In-Reply-To: <20041208111316.GA24484@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412082037.33229.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 December 2004 20:13, Ingo Molnar wrote:
> * Akinobu Mita <amgta@yacht.ocn.ne.jp> wrote:
> > -	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
> > +	if (timer_hook) {
> > +		struct pt_regs regs;
> > +
> > +		GET_CURRENT_REGS(regs);
> > +		timer_hook(&regs);
> > +	}
>
> ugh. nack.
>

This second patch is not intended for inclusion.
It's my own tailor-made profiler. Actually it breaks all architectures
except for i386 with CONFIG_PROFILING.

It just demonstrates why I want to apply the first patch.
It fixes specifying "timer=1" as oprofile module parameter avoids to
set oprofile_operations.backtrace.



