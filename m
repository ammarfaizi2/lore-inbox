Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVGISbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVGISbJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 14:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVGISbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 14:31:09 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.23]:25900 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261678AbVGISbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 14:31:06 -0400
Subject: Re: Real-Time Preemption -RT-V0.7.51-17 - Keyboard Problems
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050708191326.GA6503@elte.hu>
References: <42CEC7B0.7000108@cybsft.com>  <20050708191326.GA6503@elte.hu>
Content-Type: text/plain
Date: Sat, 09 Jul 2005 20:31:04 +0200
Message-Id: <1120933864.14404.22.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-08 at 21:13 +0200, Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> > Ingo,
> > 
> > I have an issue with keys VERY SPORADICALLY repeating, SOMETIMES, when 
> > running the RT patches. The problem manifests itself as if the key 
> > were stuck but happens far too quickly for that to be the case. I 
> > realize that the statements above are far from scientific, but I can't 
> > seem to narrow it down further. 2.6.12 doesn't seem to have the 
> > problem at all, only when running the RT patches. It SEEMS to have 
> > gotten worse lately. I am attaching my config as well as the output 
> > from lspci.
> > 
> > Adjusting the delay in the keyboard repeat seems to help. Any ideas?
> 
> hm. Would be nice to somehow find a condition that triggers it. One 
> possibility is that something else is starving the keyboard handling 
> path. Right now it's handled via workqueues, which live in keventd. Do 
> things improve if you chrt keventd up to prio 99? Also i'd chrt the 
> keyboard IRQ thread up to prio 99 too.
> 
> the other possibility is some IRQ handling bug - those are usually 
> specific to the IRQ controller, so try turning off (or on) the IO-APIC 
> [if the box has an IO-APIC], does that change anything?
> 

I have also noticed this behaviour; PS2 keyboard, USB mouse.
Just now on linux-2.6.12-RT-V0.7.51-18 while building
linux-2.6.12-RT-V0.7.51-23 with make -j5. My desktop experience
became quite bumpy, the mouse pointer was very _very_ choppy and
when pressing the down arrow to access the next email message
in evolution it seemed like the key release event was delayed
and several 10's of messages were scrolled down before it stopped.

I will try again with IRQ 1 and events/* chrt'ed to fifo-99.

Ok, then my system is almost unusable but the keyboard works flawlesly.
The mouse was unmovable. I did a make clean; make -j5 on the kernel.
This on a dual athlon system.


-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

