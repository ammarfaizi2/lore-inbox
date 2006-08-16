Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWHPKFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWHPKFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 06:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWHPKFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 06:05:04 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:27359 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751087AbWHPKFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 06:05:01 -0400
Message-ID: <44E2ED07.6070203@aitel.hist.no>
Date: Wed, 16 Aug 2006 12:01:43 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Willy Tarreau <w@1wt.eu>, Irfan Habib <irfan.habib@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Maximum number of processes in Linux
References: <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com> <Pine.LNX.4.61.0608151419120.13947@chaos.analogic.com> <20060815182219.GL8776@1wt.eu> <Pine.LNX.4.61.0608151511310.3138@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0608151511310.3138@chaos.analogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
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
>   
Doesn't work here.  Without ulimit, I wasn't surprised
about the resulting OOM mess. 

Problem was, it never stopped.  I expected OOM to kill
this program, and quite possibly lots of other running programs
as well.  What I got, was ever-rolling OOM messages
with stack traces inbetween. 
2.6.18-rc4-mm1 never recovered and had to be killed by sysrq.

Helge Hafting



