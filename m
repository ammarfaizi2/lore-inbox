Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRCAXCd>; Thu, 1 Mar 2001 18:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129398AbRCAXCY>; Thu, 1 Mar 2001 18:02:24 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:40444 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129084AbRCAXCH>; Thu, 1 Mar 2001 18:02:07 -0500
Message-ID: <3A9ED4D8.B3465722@uow.edu.au>
Date: Thu, 01 Mar 2001 23:01:44 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Caleb Epstein <cae@bklyn.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: NETDEV WATCHDOG: eth0: transmit timed out
In-Reply-To: <20010301115938.A8178@tela.bklyn.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Caleb Epstein wrote:
> 
>         I am seeing the following error after my machine has been up
>         for a while.  My eth0 is connected to a switched, local
>         subnet.  There is not a lot of traffic on the interface, maybe
>         a few 100 Mbytes or so.  Taking the interface down and then up
>         again fixes the problem (until it happens again :)
> 
>         Here is the relevant section from my kernel log
> 
> Mar  1 10:48:44 tela kernel: NETDEV WATCHDOG: eth0: transmit timed out

My guess would be that the driver has decided there's no
link beat on the 10baseT interface and has flopped over
to using 10base2.  A fix for this exists in 2.4.2-ac5+,
in the zerocopy patch and in

	http://www.uow.edu.au/~andrewm/linux/3c59x.c-2.4.2-pre4.gz

but not in 2.4.2.

You'll need to use

	options 3c59x options=0

in /etc/modules.conf to pin the driver down to using a 
particular physical interface - disable autoselection.


So could you please upgrade the driver?  If problems
remain, please send me a report, as described in the
final section of Documentation/networking/vortex.txt.

Thanks.

-
