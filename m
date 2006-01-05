Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWAEOaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWAEOaq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWAEOaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:30:46 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:28405 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751304AbWAEOap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:30:45 -0500
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
From: Daniel Walker <dwalker@mvista.com>
To: kus Kusche Klaus <kus@keba.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323316@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F367323316@MAILIT.keba.co.at>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 06:30:42 -0800
Message-Id: <1136471443.31011.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 10:28 +0100, kus Kusche Klaus wrote:
> > From: Daniel Walker
> > Ok, yet another patch. This one uses the correct lowlevel calls, and I
> > fixed the call ordering.
> 
> Hmm, I have no deep knowledge of ARM assembler programming,
> but your patch branches to a C subroutine without setting up a
> return address in the lr register.
> 
> Hence, the return in trace_irqs_... jumps to god-knows-where,
> but not back to the next instruction.
> 
> As a wild guess, I replaced the "b trace_irqs_..." with
> "bl trace_irqs_...".

Ok .

> With this change, the kernel boots fine, but the system seems to go
> into an infinite loop as soon as the first usermode processes start.
> Most likely, my change messes up the lr register of some surrounding
> context.

That's odd. Do you have an OOPS, or is it just a silent hang?


Daniel

