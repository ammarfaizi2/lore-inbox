Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268940AbRHTV3d>; Mon, 20 Aug 2001 17:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269385AbRHTV3X>; Mon, 20 Aug 2001 17:29:23 -0400
Received: from [209.202.108.240] ([209.202.108.240]:32522 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S268940AbRHTV3N>; Mon, 20 Aug 2001 17:29:13 -0400
Date: Mon, 20 Aug 2001 17:29:12 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Fw: select(), EOF...
In-Reply-To: <009501c129bc$75724ca0$0414a8c0@10>
Message-ID: <Pine.LNX.4.33.0108201718090.11734-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001, Carlos Fernández Sanz wrote:

> a strace shows it works differently
>
> nanosleep({1, 0}, {1, 0})               = 0
> fstat(3, {st_mode=S_IFREG|0600, st_size=227128, ...}) = 0
> rt_sigprocmask(SIG_BLOCK, [CHLD], [RT_0], 8) = 0
> rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
> rt_sigprocmask(SIG_SETMASK, [RT_0], NULL, 8) = 0
>
> the file is opened just once (as I expected), and tail sleeps in nanosleep
> () until the file grows. I think strace isn't showing more nanosleep() as it
> should be looping there. BTW what's the reason for the sigprocmask, etc?

Huh. You're right. It seems that tail has changed since I last looked at the
source. Now it uses stat() instead. However, tail in textutils 2.0.11 still
calls sleep(). I don't know how sleep() is implemented, but it's not
impossible for it to use nanosleep() and signals. I believe I read something
about SIGALRM...

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>


