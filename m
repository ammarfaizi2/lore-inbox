Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268117AbUIPSSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268117AbUIPSSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUIPSSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 14:18:23 -0400
Received: from pop.gmx.de ([213.165.64.20]:6546 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268381AbUIPSOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 14:14:43 -0400
X-Authenticated: #17725021
Date: Thu, 16 Sep 2004 20:10:21 +0200
From: Henry Margies <henry.margies@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Is there a problem in timeval_to_jiffies?
Message-Id: <20040916201021.17ec80b5.henry.margies@gmx.de>
In-Reply-To: <414962DF.5080209@mvista.com>
References: <20040909154828.5972376a.henry.margies@gmx.de>
	<20040912163319.6e55fbe6.henry.margies@gmx.de>
	<20040915203039.369bb866.rddunlap@osdl.org>
	<414962DF.5080209@mvista.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: %3lz3@K$hA\]+AEANQT9>.M`@Pfo]3I,M,_JWswT5MBOpjXQ'VST8|DGMhkv8j,9Xb%j3jG
 |onl!dcPab\nF3>j.1\:ixCGSM)nHq&UXeDDhN@x^5I
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Thu, 16 Sep 2004 02:54:39 -0700
George Anzinger <george@mvista.com> wrote:

> Timers are constrained by the standard to NEVER finish early. 

I just thought about that again and I think you are wrong.
Maybe your statement is true for one-shot timers, but not for
interval timers.

No interval timer can guarantee, that the time between to
triggers is always greater or equal to the time you programmed
it.

1 occurrence of a 1000ms timer,
10 occurrences of a 100ms timer and
100 occurrences of a 10ms timer should take the same time.

For example: 

I want to have an interval timer for each second. Because of
some special reason the time between two triggers became 1.2
seconds.
The question is now, when do you want to have the next timer? 

Your approach would trigger the timer in at least one second. But
that is not the behaviour of an interval timer. An interval timer
should trigger in 0.8 seconds because I wanted him to trigger  
_every_ second.
If you want to have at least one second between your timers, you
have to use one-shot timers and restart them after each
occurrence.

And in fact, I think that no userspace program can ever take
advantage of your approach, because it can be interrupted
everytime, so there is no guarantee at all, that there will be at
least some fixed time between the very important commands. (for
interval timers)


So, what about adding this rounding value just to it_value to
guarantee that the first occurrence is in it least this time?


Best regards,

Henry

-- 

Hi! I'm a .signature virus! Copy me into your
~/.signature to help me spread!


