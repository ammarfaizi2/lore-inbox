Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265782AbUHAKuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbUHAKuf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 06:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUHAKuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 06:50:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7117 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265782AbUHAKud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 06:50:33 -0400
Date: Sun, 1 Aug 2004 06:49:45 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Lee Revell <rlrevell@joe-job.com>, Shane Shrybman <shrybman@aei.ca>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2 PS2 keyboard gone south
In-Reply-To: <1091322692.1860.5.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.58.0408010643360.7208@devserv.devel.redhat.com>
References: <1091196403.2401.10.camel@mars> <20040730152040.GA13030@elte.hu>
  <1091209106.2356.3.camel@mars>  <1091229695.2410.1.camel@teapot.felipe-alfaro.com>
  <1091232345.1677.20.camel@mindpipe>  <1091236384.2672.0.camel@teapot.felipe-alfaro.com>
  <1091246222.1677.65.camel@mindpipe>  <1091319840.2386.3.camel@teapot.felipe-alfaro.com>
  <1091320373.20819.74.camel@mindpipe> <1091322692.1860.5.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 1 Aug 2004, Felipe Alfaro Solana wrote:

> It turns out that my lock ups where related to APIC. Disabling APIC
> seems to get rid of those lock ups.

ah ... that makes sense. It is most likely level-triggered IO-APIC
interrupts that break. Could you try to turn off redirection for every
interrupt that says 'IO-APIC-level' in /proc/interrupts - does that
stabilize things? (besides the 'noapic' workaround you already
discovered.) How does your /proc/interrupts look like btw?

the 'XT-PIC' interrupt controller (i8259A) is fine for redirection. (and
that's what i used for testing almost exclusively.)

	Ingo
