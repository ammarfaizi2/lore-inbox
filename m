Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269763AbUJALrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269763AbUJALrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 07:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269764AbUJALrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 07:47:03 -0400
Received: from pop.gmx.de ([213.165.64.20]:465 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269763AbUJALqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 07:46:55 -0400
X-Authenticated: #17725021
Date: Fri, 1 Oct 2004 13:42:14 +0200
From: Henry Margies <henry.margies@gmx.de>
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a problem in timeval_to_jiffies?
Message-Id: <20041001134214.7458c1cd.henry.margies@gmx.de>
In-Reply-To: <415B2178.7060907@am.sony.com>
References: <20040909154828.5972376a.henry.margies@gmx.de>
	<20040912163319.6e55fbe6.henry.margies@gmx.de>
	<20040915203039.369bb866.rddunlap@osdl.org>
	<414962DF.5080209@mvista.com>
	<20040916200203.6259e113.henry.margies@gmx.de>
	<4149F56E.50406@mvista.com>
	<20040917115502.33831479.henry.margies@gmx.de>
	<415B2178.7060907@am.sony.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: %3lz3@K$hA\]+AEANQT9>.M`@Pfo]3I,M,_JWswT5MBOpjXQ'VST8|DGMhkv8j,9Xb%j3jG
 |onl!dcPab\nF3>j.1\:ixCGSM)nHq&UXeDDhN@x^5I
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 29 Sep 2004 13:56:24 -0700
Tim Bird <tim.bird@am.sony.com> wrote:

> > If there is no latency, the timer should appear right at the
> > beginning of a jiffie
> 
> How does the computer "know" that the timer is at the beginning
> of the jiffy?

I was assuming no latency and in that case the timer should be
managed right at the beginning of a jiffie. George Anzinger
pionted out that timers should be designed to never be early. And
for the design you have to assume there is no latency.

Another thing is that the calculation of jiffies for the first
occurrence of a timer is different to the interval calculation
(for the first case, one jiffie is always added). But
for interval timers it is different, it is normal that they take
sometimes less time than you expect, because they needed more
time for the last loop for example. But after 1000 loops the time
between should be near to 1000 * time_for_one_loop.

> If you are rescheduling one-shot timers immediately
> after they fire, you should 'undershoot' on the time
> interval, to hit the tick boundary you want, based
> on the jiffy resolution of your platform.

'undershooting' is not a good idea.

The current calculation of interval to jiffies works quit good
(I guess). But for arm there is this small problem. I'm still
waiting for the test application from George and in fact I also
have not that much time at the moment to work on that.




Henry


-- 

Hi! I'm a .signature virus! Copy me into your
~/.signature to help me spread!

