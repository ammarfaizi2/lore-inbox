Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbREYV0p>; Fri, 25 May 2001 17:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261926AbREYV0f>; Fri, 25 May 2001 17:26:35 -0400
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:33233 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S261921AbREYV02>;
	Fri, 25 May 2001 17:26:28 -0400
Date: Fri, 25 May 2001 17:26:28 -0400
From: Mark Frazer <mark@somanetworks.com>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Re: [timer] max timeout
Message-ID: <20010525172628.P32217@somanetworks.com>
Mail-Followup-To: liste noyau linux <linux-kernel@vger.kernel.org>
In-Reply-To: <20010523162801.38dabdff.sebastien.person@sycomore.fr> <3B0EC786.D7B65706@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B0EC786.D7B65706@mvista.com>; from george@mvista.com on Fri, May 25, 2001 at 01:58:46PM -0700
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> [01/05/25 17:04]:
> More than enough on the fp.  Now the other question.  
> 
> The time value is in jiffies (aka 1/Hz sec.).  The max value (in a 32
> bit system) is 0x7ffffff.  This value is added to the current value of
> jiffies to get the the absolute timer expire time.  While the value is
> unsigned (and thus you could go higher) the compare code (timer_before()
> and timer_after()) depend on the subtraction (of jiffies from expire) to
> be of the correct sign.  To insure this you must keep the timeout values
> sign clear (or if you don't like to think of an unsigned as having a
> sign, then the highest order bit must be zero).
> 
> George

The output of `find . -type f | xargs grep 'jiffies +'` would suggest
that there are a few latent bugs as jiffies grows to values near the
top of its range.  I guess this hasn't turned up as 0x7fffffff / (100 *
3600 * 24) = 248.55.


