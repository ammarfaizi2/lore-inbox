Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269659AbRHAGjq>; Wed, 1 Aug 2001 02:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269660AbRHAGjg>; Wed, 1 Aug 2001 02:39:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3070 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S269659AbRHAGjW>; Wed, 1 Aug 2001 02:39:22 -0400
Message-ID: <3B67A405.1A7CE632@mvista.com>
Date: Tue, 31 Jul 2001 23:39:01 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: sebastien person <sebastien.person@sycomore.fr>
CC: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: timer functions
In-Reply-To: <20010726170814.5f1aabe8.sebastien.person@sycomore.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

sebastien person wrote:
> 
> Hi,
> 
> I have a problem using timers. :-(
> 
> I want to change the function called by the timer :
>         - the first call on the first function works fine
>         - but the second call wich change the function being called
>           give me following error message : "bug: kernel timer added twice at c88cbdd7"
>           and the linux box hang totally
> 
> Is it possible to changed the called function ?
> 
> Any ideas ?
> 
> thanks
> 
> sebastien person
If I understand it, you have an active timer and want to change the
function it calls.  

If the timer is close to expiring, you may have a race with that, but,
in any case, you should be able to just change the function pointer in
the timer structure.  If you are too late, you will find the timer is
free (test by looking for NULL in the list pointer).  The system does
not use or look at the function pointer until it is about to make the
call, i.e. when the timer expires.  You do not have to call any timer
routine to do this, though many would say it is not good practice.

George
