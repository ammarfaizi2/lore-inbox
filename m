Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265342AbRF0SNx>; Wed, 27 Jun 2001 14:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbRF0SNn>; Wed, 27 Jun 2001 14:13:43 -0400
Received: from xd1.xdrive.com ([65.166.147.200]:1510 "HELO hellman.xman.org")
	by vger.kernel.org with SMTP id <S265341AbRF0SN3>;
	Wed, 27 Jun 2001 14:13:29 -0400
Date: Wed, 27 Jun 2001 11:11:20 -0700
From: Christopher Smith <x@xman.org>
To: Balbir Singh <balbir.singh@wipro.com>, Dan Kegel <dank@kegel.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
Message-ID: <52100000.993665480@hellman>
In-Reply-To: <Pine.SV4.4.21.0106271143430.23526-100000@wipro.wipsys.sequent.com>
X-Mailer: Mulberry/2.0.8 (Linux/x86 Demo)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, June 27, 2001 11:51:36 +0530 Balbir Singh 
<balbir.singh@wipro.com> wrote:
> Shouldn't there be a sigclose() and other operations to make the API
Wouldn't the existing close() be good enough for that?

> orthogonal. sigopen() should be selective about the signals it allows
> as argument. Try and make sigopen() thread specific, so that if one
> thread does a sigopen(), it does not imply it will do all the signal
> handling for all the threads.

Actually, this is exactly what you do want to happen. Linux's existing 
signals + threads semantics are not exactly ideal for high-performance 
computing. Of course, fd's are shared by all threads, so all of the threads 
would be able to read the siginfo structures into memory.

> Does using sigopen() imply that signal(), sigaction(), etc cannot be used.
> In the same process one could do a sigopen() in the library, but the
> process could use sigaction()/signal() without knowing what the library
> does (which signals it handles, etc).

If I understood Dan's intentions correctly, you could use signal() and 
sigaction(), but while the fd is open, signals would be queued up to the fd 
rather than passed off to a signal handler or sigwaitinfo(). Care to 
comment  Dan?

> Let me know, when somebody has a patch or needs help, I would like to
> help or take a look at it.

Maybe we can both hack on this.

--Chris
