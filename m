Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268159AbUIPPvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268159AbUIPPvC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268135AbUIPPrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:47:31 -0400
Received: from pop.gmx.net ([213.165.64.20]:48360 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268176AbUIPPmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:42:44 -0400
X-Authenticated: #17725021
Date: Thu, 16 Sep 2004 17:38:19 +0200
From: Henry Margies <henry.margies@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Is there a problem in timeval_to_jiffies?
Message-Id: <20040916173819.68ddad80.henry.margies@gmx.de>
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

Hello,

Thank you for your answers.

> You, I think, send a bug report.  I replied via bugz.  The open
> question is what value your particular arm platform is using
> for CLOCK_TICK_RATE.  See below.

That is right, but I did not send the bug report, I just answered
to your reply. The requested values are:

HZ: 100
LATCH: 600000
USEC_ROUND: 4294967295                                          
CLOCK_TICK_RATE: 60000000                 
TICK_NSEC: 10000000

> Timers are constrained by the standard to NEVER finish early. 

That is why I wrote to this mailing list, to determine if it
is a bug or a feature :)

But, especially for my arm device, the timers seem to be more or
less accurate. They appear every 20ms with a average deviation of
less than 20ns (without any load of course). The only bad thing
is, that I requested timers for 10ms. I understand your
statement, that timers should not finish early, but for my case,
they just appear exactly 10ms late.

> This means that, in order to account for the timer starting
> between two jiffies, an extra jiffie needs to be added to the
> value.  This will cause a timer to expire sometime between the
> value asked for and that value + the resolution.

In my case, that means, that most of my timers will appear at
least 9980ns too late. And! it is not possible to have 10ms
timers.

But if itimers have to act like this, the current implementation
is right. But anyway, on my board, I have to pay a high price
for that.

Just another comment, 2.4 kernels don't have this feature. So, is
there really a need to have this?


Best regards,
Henry

-- 

Hi! I'm a .signature virus! Copy me into your
~/.signature to help me spread!

