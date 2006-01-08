Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161183AbWAHKyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161183AbWAHKyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 05:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbWAHKyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 05:54:09 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:40460 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1161183AbWAHKyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 05:54:08 -0500
Date: Sun, 8 Jan 2006 11:54:01 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Cc: linux-kernel@vger.kernel.org, gcoady@gmail.com
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Message-ID: <20060108105401.GI7142@w.ods.org>
References: <20060108095741.GH7142@w.ods.org> <E1EvXi5-0000kv-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EvXi5-0000kv-00@calista.inka.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 11:23:37AM +0100, Bernd Eckenfels wrote:
> Willy Tarreau <willy@w.ods.org> wrote:
> > It's rather strange that 2.6 *eats* CPU apparently doing nothing !
> 
> it eats it in high interrupt load.

*high* ? he never goes far beyond 1000/s !

> And it is caused by the pty-ssh-tcp output,

quite possibly, but I'd rather think it's more precisely related
to the ping-pong in the scheduler between grep, cut and ssh. I
had the same symptom with 'ls' in xterm with lots of files. It
took tens of seconds to list 2000 files while 'ls |cat' gave
the same result instantly.

I also have another example (2.6.15-rc5, dual athlon, logged in
via SSH) :
  willy@pcw:willy$ time ls -l

  real    0m0.150s
  user    0m0.016s
  sys     0m0.024s

Now if I start 4 processes in background :
  willy@pcw:willy$ time ls -l

  real    0m4.432s
  user    0m0.028s
  sys     0m0.008s

With 8 processes in background :
  willy@pcw:willy$ time ls -l

  real    0m49.817s
  user    0m0.020s
  sys     0m0.008s

  willy@pcw:willy$ time ls -l | wc -l
     1259

  real    0m18.917s
  user    0m0.016s
  sys     0m0.012s

I think my case with 4 processes on a dual CPU ressembles Grant's case
with 2 processes on single CPU. The background processes are only ones
which eat CPU half of their time, which might sometimes match an I/O
bound process such as grep from a disk.

> so most likely those are eepro100 interrupts.

I don't think so.

> Gruss
> Bernd

Regards,
Willy

PS: please don't remove people in CC:

