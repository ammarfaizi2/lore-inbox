Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290277AbSCGB7V>; Wed, 6 Mar 2002 20:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290333AbSCGB7M>; Wed, 6 Mar 2002 20:59:12 -0500
Received: from are.twiddle.net ([64.81.246.98]:22426 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S290277AbSCGB7G>;
	Wed, 6 Mar 2002 20:59:06 -0500
Date: Wed, 6 Mar 2002 17:58:46 -0800
From: Richard Henderson <rth@twiddle.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Hubertus Franke <frankeh@watson.ibm.com>, Robert Love <rml@tech9.net>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fast Userspace Mutexes III.
Message-ID: <20020306175846.B26064@twiddle.net>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	Robert Love <rml@tech9.net>, Rusty Russell <rusty@rustcorp.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020304154848.A1055@elinux01.watson.ibm.com> <Pine.LNX.4.44.0203041305250.1561-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0203041305250.1561-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Mon, Mar 04, 2002 at 02:15:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 02:15:58PM -0800, Davide Libenzi wrote:
> That's great. What if the process holding the mutex dies while there're
> sleeping tasks waiting for it ?

The lock is lost.  The same thing would happen with locks completely
implemented in userspace.

I don't see that the kernel should do anything about this.  If a 
thread is killed with predudice (i.e. without pthread_cancel) then
there are all sorts of cleanups that won't happen.  Having the
kernel automatically unlock the locks doesn't help much, since
the data structures are quite likely in an inconsistent state.


r~
