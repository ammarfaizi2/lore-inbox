Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317814AbSGKSFV>; Thu, 11 Jul 2002 14:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317818AbSGKSFU>; Thu, 11 Jul 2002 14:05:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:59798 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317814AbSGKSFT>; Thu, 11 Jul 2002 14:05:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>,
       Thunder from the hill <thunder@ngforever.de>, dank@kegel.com,
       linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, cmolsen@us.ibm.com
Subject: Re: Periodic clock tick considered harmful (was: Re: HZ, preferably as small  as possible)
Date: Thu, 11 Jul 2002 13:05:34 -0400
X-Mailer: KMail [version 1.3.1]
References: <3D2DB5F3.3C0EF4A2@kegel.com> <Pine.LNX.4.44.0207111056230.3582-100000@hawkeye.luckynet.adm> <200207111745.g6BHjmT64928@d12relay01.de.ibm.com>
In-Reply-To: <200207111745.g6BHjmT64928@d12relay01.de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020711180753.CC97D3FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 July 2002 03:45 pm, Arnd Bergmann wrote:
> Thunder from the hill wrote:
> > On Thu, 11 Jul 2002 dank@kegel.com wrote:
> >> OK, so I'm just an ignorant member of the peanut gallery, but
> >> I'd like to hear a real kernel hacker explain why this isn't
> >> the way to go.
> >
> > The only thing that was mentioned yet was the amount of stuff that
> > depends on periodic ticks. If we just tick unperiodically, we'd fail for
> > sure, but if we make these instances depend on another timer - we won.
> >
> > I think a good scheduler can handle this and should also be able to
> > determine a halfaway optimal tick rate for the current load.
>
> The current approach on s390 is stop the timer tick only for idle cpus,
> because that's where it hurts. A busy system can just keep on using 100
> (or 1000) Hz timers.
> The jiffies value then gets updated from the time stamp counter when an
> interrupt happens on an idle CPU.
>
> See Martin Schwidefsky's recent post for code:
>
> http://marc.theaimsgroup.com/?l=linux-kernel&m=102578746520177&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=102578746420174&w=2
>
>         Arnd <><
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


There has also been some work done by Michael Olsen (cmolsen@us.ibm.com)
regarding noperiodic jiffie updates. This was in the context of embedded 
handheld devices, in particular IBM's LinuxWatch. Similar problem
arise in such devices where the timer tick can be a significant source of 
battery drainage.
There are/were some settled differences between Michael and Martin approach, 
which I won't be able to adequately describe. 
I believe Michael has a publication on this, I let him respond.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
