Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264278AbRFMCSX>; Tue, 12 Jun 2001 22:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264286AbRFMCSO>; Tue, 12 Jun 2001 22:18:14 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:8663 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S264278AbRFMCSF>;
	Tue, 12 Jun 2001 22:18:05 -0400
Message-ID: <3B26CD5B.47002360@candelatech.com>
Date: Tue, 12 Jun 2001 19:18:03 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: landley@webofficenow.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Hour long timeout to ssh/telnet/ftp to down host?
In-Reply-To: <01061217025700.02061@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> 
> I have scripts that ssh into large numbers of boxes, which are sometimes
> down.  The timeout for figuring out the box is down is over an hour.  This is
> just insane.
> 
> Telnet and ftp behave similarly, or at least tthey lasted the 5 minutes I was
> willing to wait, anyway.  Basically anything that calls connect().  If the
> box doesn't respond in 15 seconds, I want to give up.
> 
> Is this a problem with the kernel or with glibc?  If it's the kernel, I'd
> expect a /proc entry where I can set this, but I can't seem to find one.  Is
> there one?  What would be involved in writing one?
> 

You can tune things by setting the tcp-timeout probably..I don't
know exactly where to set this..

You probably don't want all tcp to time out at 15 seconds anyway, so
I'd suggest either using non-blocking connect (if you have the code
that does the connect), or just set a timer (or use sigalarm) when you
start the attempt, and fail the attempt if the timer or alarm signal
goes off.

> If it's glibc I'm probably better off writing a wrapper to ping the
> destination before trying to connect, or killing the connection after a
> timeout with no traffic.  But both of those are really ugly solutions.

Ugly is relative, and don't use ping because there is still a race condition
(ping worked, but by the time you try tcp, the box is down.)

> 
> Anybody have any light to shed on the situation?
> 
> Rob
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
