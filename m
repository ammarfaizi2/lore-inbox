Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131344AbRCSD1A>; Sun, 18 Mar 2001 22:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131348AbRCSD0v>; Sun, 18 Mar 2001 22:26:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34565 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131344AbRCSD0n>; Sun, 18 Mar 2001 22:26:43 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [CHECKER] blocking w/ spinlock or interrupt's disabled
Date: 18 Mar 2001 19:24:25 -0800
Organization: Transmeta Corporation
Message-ID: <993u59$32k$1@penguin.transmeta.com>
In-Reply-To: <001801c0af8e$bda30c10$5517fea9@local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <001801c0af8e$bda30c10$5517fea9@local>,
Manfred Spraul <manfred@colorfullife.com> wrote:
>
>Unortunately schedule() with disabled interrupts is a feature, it's
>needed for the old (deprecated and waiting for termination in 2.5)
>sleep_on() functions.

Yes.  But that should only cover "sleep_on()" and it's interruptible
cousing "sleep_on_interruptible()".  No other blocking call should have
interrupts disabled, I would hope.

The special-case is a fairly specific "some old-style drivers avoid race
conditions by having interrupts disabled over explicit conditional
sleeps", not a generic "you may have interrupts disabled before
blocking". 

		Linus
