Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbVGHTPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVGHTPL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVGHTNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:13:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37844 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262787AbVGHTNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:13:20 -0400
Date: Fri, 8 Jul 2005 21:13:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Real-Time Preemption -RT-V0.7.51-17 - Keyboard Problems
Message-ID: <20050708191326.GA6503@elte.hu>
References: <42CEC7B0.7000108@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CEC7B0.7000108@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo,
> 
> I have an issue with keys VERY SPORADICALLY repeating, SOMETIMES, when 
> running the RT patches. The problem manifests itself as if the key 
> were stuck but happens far too quickly for that to be the case. I 
> realize that the statements above are far from scientific, but I can't 
> seem to narrow it down further. 2.6.12 doesn't seem to have the 
> problem at all, only when running the RT patches. It SEEMS to have 
> gotten worse lately. I am attaching my config as well as the output 
> from lspci.
> 
> Adjusting the delay in the keyboard repeat seems to help. Any ideas?

hm. Would be nice to somehow find a condition that triggers it. One 
possibility is that something else is starving the keyboard handling 
path. Right now it's handled via workqueues, which live in keventd. Do 
things improve if you chrt keventd up to prio 99? Also i'd chrt the 
keyboard IRQ thread up to prio 99 too.

the other possibility is some IRQ handling bug - those are usually 
specific to the IRQ controller, so try turning off (or on) the IO-APIC 
[if the box has an IO-APIC], does that change anything?

	Ingo
