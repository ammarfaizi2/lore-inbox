Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317811AbSGKRnl>; Thu, 11 Jul 2002 13:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317808AbSGKRnk>; Thu, 11 Jul 2002 13:43:40 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:6285 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S317786AbSGKRnj>; Thu, 11 Jul 2002 13:43:39 -0400
Message-Id: <200207111745.g6BHjmT64928@d12relay01.de.ibm.com>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: Periodic clock tick considered harmful (was: Re: HZ, preferably as small  as possible)
To: Thunder from the hill <thunder@ngforever.de>, dank@kegel.com,
       linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Mail-Copies-To: arndb@de.ibm.com
Date: Thu, 11 Jul 2002 21:45:56 +0200
References: <3D2DB5F3.3C0EF4A2@kegel.com> <Pine.LNX.4.44.0207111056230.3582-100000@hawkeye.luckynet.adm>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:
> On Thu, 11 Jul 2002 dank@kegel.com wrote:
>> OK, so I'm just an ignorant member of the peanut gallery, but
>> I'd like to hear a real kernel hacker explain why this isn't
>> the way to go.
> 
> The only thing that was mentioned yet was the amount of stuff that depends
> on periodic ticks. If we just tick unperiodically, we'd fail for sure, but
> if we make these instances depend on another timer - we won.
> 
> I think a good scheduler can handle this and should also be able to
> determine a halfaway optimal tick rate for the current load.

The current approach on s390 is stop the timer tick only for idle cpus,
because that's where it hurts. A busy system can just keep on using 100
(or 1000) Hz timers.
The jiffies value then gets updated from the time stamp counter when an 
interrupt happens on an idle CPU.

See Martin Schwidefsky's recent post for code:

http://marc.theaimsgroup.com/?l=linux-kernel&m=102578746520177&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=102578746420174&w=2

        Arnd <><
