Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261500AbRERK5b>; Fri, 18 May 2001 06:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262292AbRERK5V>; Fri, 18 May 2001 06:57:21 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:6108 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261500AbRERK5M>; Fri, 18 May 2001 06:57:12 -0400
Message-ID: <3B04FEE8.FC45EAFE@uow.edu.au>
Date: Fri, 18 May 2001 20:52:24 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Santiago Garcia Mantinan <manty@udc.es>
CC: linux-kernel@vger.kernel.org, Jens David <dg1kjd@afthd.tu-darmstadt.de>
Subject: Re: 8139too on 2.2.19 doesn't close file descriptors
In-Reply-To: <20010518000450.A3755@man.beta.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Santiago Garcia Mantinan wrote:
> 
> Hi!
> 
> I was tracking down a problem with Debian installation freezing when doing
> the ifconfig of the 8139too driver on 2.2.19 kernel, and found that this was
> caused by 8139too for 2.2.19 not closing it's file descriptors.
> 
> The original code by Jeff for the 2.4 series is ok, and searching for the
> cause of the problem I have found a difference in the way rtl8139_thread
> exits on both versions:
> 
> 2.2 version:
>         up (&tp->thr_exited);
>         return 0;
> 
> 2.4 version:
>         up_and_exit (&tp->thr_exited, 0);
> 
> I think the problem must be there, not doing the do_exit on the 2.2 version,
> but I may be wrong, can anybody look this up?

No, that's OK.

In 2.2, daemonize() does *not* do exit_files().  In 2.4
it does.  I wonder why?

Try putting an

	exit_files(current);

at the start of rtl8139_thread()
