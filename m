Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132426AbRDMXmK>; Fri, 13 Apr 2001 19:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132425AbRDMXl7>; Fri, 13 Apr 2001 19:41:59 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:15365 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132414AbRDMXlm>;
	Fri, 13 Apr 2001 19:41:42 -0400
Date: Fri, 13 Apr 2001 19:40:44 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
X-X-Sender: <bart@localhost>
To: Thiago Rondon <maluco@mileniumnet.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, "Michael A. Griffith" <grif@acm.org>
Subject: Re: [QUESTION] init/main.c
In-Reply-To: <Pine.LNX.4.21.0104131916150.11797-100000@freak.mileniumnet.com.br>
Message-ID: <Pine.LNX.4.33.0104131935100.3652-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jiffies is updated by a timer interrupt once every 1/HZ seconds (HZ==100
for i386).

The code intents to start running at the time right after jiffies was
incremented to improve the correctness of the delay calibration loop.

The reason why jiffies is read later is to get the value after the
change... if the interrupts are sporadic then the increment could be 2 ...
although not very likely.

Bart.

On Fri, 13 Apr 2001, Thiago Rondon wrote:

>
> At function calibrate_delay(void) in init/main.c,
> I dont understand this code:
>
> <<EOF
>                 /* wait for "start of" clock tick */
>                 ticks = jiffies;
>                 while (ticks == jiffies)
>                         /* nothing */;
>                 /* Go .. */
>
>                 ticks = jiffies;
> EOF
>
> ticks = jiffies; while (ticks == jiffies); ticks = jiffies; ?
>
> Thanks in advanced,
> -Thiago Rondon
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
	WebSig: http://www.jukie.net/~bart/sig/

