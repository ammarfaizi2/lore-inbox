Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbTFUTlq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 15:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265298AbTFUTlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 15:41:46 -0400
Received: from crack.them.org ([146.82.138.56]:35306 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S265293AbTFUTld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 15:41:33 -0400
Date: Sat, 21 Jun 2003 15:55:31 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace Issues
Message-ID: <20030621195531.GA25700@nevyn.them.org>
Mail-Followup-To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030509004759.46182eca.us15@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509004759.46182eca.us15@os.inf.tu-dresden.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 12:47:59AM +0200, Udo A. Steinberg wrote:
> 
> Hi all,
> 
> I have discovered that recently I can no longer attach via strace to 
> already running processes for a long time. Specifically I have a daemon which
> sleeps in select and periodically wakes up from SIGALRM signals. As soon as a
> signal hits, strace quits on 2.5.69, however, it works fine on 2.4.21-rc.
> Can someone shed some light on what's going on?

Sorry it took so long...

> root@Corona:~> strace -p 527
> --- SIGSTOP (Stopped (signal)) ---
> --- SIGSTOP (Stopped (signal)) ---
> select(7, [0 3 6], [], NULL, NULL)      = ? ERESTARTNOHAND (To be restarted)
> --- SIGALRM (Alarm clock) ---
> root@Corona:~> echo $?
> 0

I can't explain why it works for you on 2.4.21-rc.  Were they the same
system and strace version?

The short answer appears to be: this is a bug in strace, not a bug in
the kernel.  If you get 4.4.98, it'll work.  There was an off-by-one
bug in parsing /proc/%d/status for the list of signals.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
