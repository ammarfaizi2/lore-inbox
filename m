Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262863AbVGHUEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262863AbVGHUEM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbVGHUEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:04:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10407 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262859AbVGHUDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:03:11 -0400
Date: Fri, 8 Jul 2005 22:03:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Doug Maxey <dwm@maxeymade.com>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Real-Time Preemption -RT-V0.7.51-17 - Keyboard Problems
Message-ID: <20050708200315.GA31100@elte.hu>
References: <20050708191326.GA6503@elte.hu> <200507081935.j68JZSqr003200@falcon30.maxeymade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507081935.j68JZSqr003200@falcon30.maxeymade.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Doug Maxey <dwm@maxeymade.com> wrote:

> FWIW, I have seen this issue under USB, off and on since about 2.6.9. 
> Never have dug into it, was always simpler to just unplug and re-plug 
> the keyboard.  Of course, this predates RT.

hm, doesnt this coincide with the pushing of some keyboard functionality 
(such as LED handling, etc.) into keventd? Keyboard stuff used to be 
done from a tasklet, but that had its own problems. Now that we use 
keventd (which is a SCHED_OTHER task) the delays seen by the keyboard 
handling path might be larger. This could both affect the hardware 
(keyboards are quite fragile), or it could also trigger some races that 
were not triggered that often with tasklets?

	Ingo
