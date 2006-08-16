Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWHPL7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWHPL7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 07:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWHPL7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 07:59:18 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:17582 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S1751118AbWHPL7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 07:59:18 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: Maximum number of processes in Linux
Date: Wed, 16 Aug 2006 12:58:59 +0100
User-Agent: KMail/1.9.4
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Willy Tarreau <w@1wt.eu>, Irfan Habib <irfan.habib@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com> <Pine.LNX.4.61.0608151511310.3138@chaos.analogic.com> <44E2ED07.6070203@aitel.hist.no>
In-Reply-To: <44E2ED07.6070203@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161258.59646.s0348365@sms.ed.ac.uk>
X-Originating-Pythagoras-IP: [217.155.137.246]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 August 2006 11:01, Helge Hafting wrote:
> linux-os (Dick Johnson) wrote:
> > Yep....
> >
> > #include <stdio.h>
> > #include <signal.h>
> > int main()
> > {
> >      unsigned long i;
> >      for(i = 0; ; i++)
> >      {
> >          switch(fork())
> >          {
> >          case 0:		// kid
> >  	pause();
> >          break;
> >          case -1:	// Failed
> >          printf("%lu\n", i);
> >              kill(0, SIGTERM);
> >              exit(0);
> >          default:
> >              break;
> >          }
> >      }
> >      return 0;
> > }
> >
> > Shows a consistent 6140.
>
> Doesn't work here.  Without ulimit, I wasn't surprised
> about the resulting OOM mess.
>
> Problem was, it never stopped.  I expected OOM to kill
> this program, and quite possibly lots of other running programs
> as well.  What I got, was ever-rolling OOM messages
> with stack traces inbetween.
> 2.6.18-rc4-mm1 never recovered and had to be killed by sysrq.

It took 4.5 minutes to recover on my X2 3800+, 2GB RAM, 512MB swap, when I 
tried without ulimit on 2.6.18-rc4. However, the OOM killer did call all of 
the offending processes and I was able to use the machine for many hours 
afterwards. The VM didn't even mind after a swapoff -a.

Maybe an -mm patch?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
