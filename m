Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161300AbWGJCZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161300AbWGJCZQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 22:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161301AbWGJCZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 22:25:16 -0400
Received: from mail.suse.de ([195.135.220.2]:18884 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161300AbWGJCZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 22:25:14 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.18-rc1-mm1 fails on amd64 (smp_call_function_single)
Date: Mon, 10 Jul 2006 04:25:07 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, "gregoire.favre" <gregoire.favre@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>
References: <200607092152_MC3-1-C488-18A8@compuserve.com>
In-Reply-To: <200607092152_MC3-1-C488-18A8@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607100425.07750.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 July 2006 03:49, Chuck Ebbert wrote:
> In-Reply-To: <20060709154445.60d6619c.akpm@osdl.org>
> 
> On Sun, 9 Jul 2006 15:44:45 -0700, Andrew Morton wrote:
> 
> > I meant, in smp.h:
> > 
> > #else /* CONFIG_SMP */
> > #define smp_call_function_single(cpu, fn, arg, x, y) fn(arg)
> > #endif        /* CONFIG_SMP */
> 
> But smp_call_function_single() generates an error if you try to call
> it on your own CPU, so that doesn't make sense.

I have a full patch to be mirrored out soon.

Your patch is still wrong because now it won't be initialized on the BP

> 
> I fixed it like this, because that register defaults to zero
> anyway and doesn't need initialization on CPU 0.
> 
> What I can't figure out is how this ever gets called on CPU 0
> during init, whether it's SMP or not.

The notifier is called from time.c

-Andi
