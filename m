Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbTFJLic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 07:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbTFJLic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 07:38:32 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:31976 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S262090AbTFJLib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 07:38:31 -0400
Message-ID: <3EE5C68B.2065BE35@Bull.Net>
Date: Tue, 10 Jun 2003 13:52:43 +0200
From: Eric Piel <Eric.Piel@Bull.Net>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Riley Williams <Riley@Williams.Name>
CC: george anzinger <george@mvista.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] More time clean up stuff.
References: <BKEGKPICNAKILKJKMHCAEEEGEEAA.Riley@Williams.Name>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams wrote:
> 
> Hi George.
> 
> I'm ignoring the rest of this - it makes sense to me, but I'm
> no expert in it. However, your last point is one I can comment
> about as I've dealt with it professionally many times.
> 
>  > clock_nanosleep is changed to round up to the next jiffie to
>  > cover starting between jiffies.
> 
> Isn't this a case of replacing one error with another, where
> one of the two errors is unavoidable?
> 
>  1. In the old case, the sleep will on average be half a jiffie
>     LESS than the requested period.
> 
>  2. In the new case, the sleep will on average be half a jiffie
>     MORE than the requested period.
> 
> One or the other is unavoidable if a jiffie is the basic unit
> of time resolution of the system. However, the error is totally
> meaningless if we are asking to sleep for more than 15 jiffies.

The point is that the POSIX norm specifies the problem in a different
way:
"The suspension time may be longer than requested because the argument
value is rounded up to an integer multiple of the sleep resolution or
because of the scheduling of other activity by the system. But, except
for the case of being interrupted by a signal, the suspension time shall
not be less than the time specified by rqtp, as measured by the system
clock CLOCK_REALTIME."

Basicaly, this means the user must be assured that the sleep() will
ALWAYS return after the specified time. This patch corrects a bug wich
could happen nearly 50% of the time you called sleep()!

Eric
