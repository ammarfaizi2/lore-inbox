Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbWHOTS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWHOTS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbWHOTS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:18:27 -0400
Received: from 1wt.eu ([62.212.114.60]:22799 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S965172AbWHOTS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:18:27 -0400
Date: Tue, 15 Aug 2006 21:13:57 +0200
From: Willy Tarreau <w@1wt.eu>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Irfan Habib <irfan.habib@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Maximum number of processes in Linux
Message-ID: <20060815191356.GC6672@1wt.eu>
References: <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com> <Pine.LNX.4.61.0608151419120.13947@chaos.analogic.com> <20060815182219.GL8776@1wt.eu> <Pine.LNX.4.61.0608151511310.3138@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0608151511310.3138@chaos.analogic.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 03:13:35PM -0400, linux-os (Dick Johnson) wrote:
> 
> On Tue, 15 Aug 2006, Willy Tarreau wrote:
> 
> > On Tue, Aug 15, 2006 at 02:22:02PM -0400, linux-os (Dick Johnson) wrote:
> >>
> >> On Tue, 15 Aug 2006, Irfan Habib wrote:
> >>
> >>> Hi,
> >>>
> >>> What is the maximum number of process which can run simultaneously in
> >>> linux? I need to create an application which requires 40,000 threads.
> >>> I was testing with far fewer numbers than that, I was getting
> >>> exceptions in pthread_create
> >>>
> >>> Regards
> >>> Irfan
> 
> [SNIPPED bad stuff]
> 
> >
> > Dick, would you please initialize your local variables when you send
> > examples like this ? You should have been amazed by one billion processes
> > on your box, at least.
> >
> 
> 
> Yep....
> 
> #include <stdio.h>
> #include <signal.h>
> int main()
> {
>      unsigned long i;
>      for(i = 0; ; i++)
>      {
>          switch(fork())
>          {
>          case 0:		// kid
>  	pause();
>          break;
>          case -1:	// Failed
>          printf("%lu\n", i);
>              kill(0, SIGTERM);
>              exit(0);
>          default:
>              break;
>          }
>      }
>      return 0;
> }
> 
> Shows a consistent 6140.

Better ! :-)

1) how much memory do you have ?
2) Would you try with clone() instead of fork(), you should get more because
   everything will be shared.

Regards,
Willy

