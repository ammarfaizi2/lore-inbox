Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbREYU7g>; Fri, 25 May 2001 16:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbREYU7Z>; Fri, 25 May 2001 16:59:25 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:63947 "EHLO
	c0mailgw12.prontomail.com") by vger.kernel.org with ESMTP
	id <S261857AbREYU7R>; Fri, 25 May 2001 16:59:17 -0400
Message-ID: <3B0EC786.D7B65706@mvista.com>
Date: Fri, 25 May 2001 13:58:46 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: sebastien person <sebastien.person@sycomore.fr>
CC: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: [timer] max timeout
In-Reply-To: <20010523162801.38dabdff.sebastien.person@sycomore.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sebastien person wrote:
> 
> Hi,
> 
> is there a max timeout to respect when I use mod_timer ? or add_timer ?
> 
> Is it bad to do the following call ?
> 
>         mod_timer(&timer, jiffies+(0.1*HZ));
> 
> that might fire the timer 1/10 second later.
> 
> Thanks.
> 
More than enough on the fp.  Now the other question.  

The time value is in jiffies (aka 1/Hz sec.).  The max value (in a 32
bit system) is 0x7ffffff.  This value is added to the current value of
jiffies to get the the absolute timer expire time.  While the value is
unsigned (and thus you could go higher) the compare code (timer_before()
and timer_after()) depend on the subtraction (of jiffies from expire) to
be of the correct sign.  To insure this you must keep the timeout values
sign clear (or if you don't like to think of an unsigned as having a
sign, then the highest order bit must be zero).

George
