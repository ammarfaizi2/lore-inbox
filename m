Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbUDSAhs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 20:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264228AbUDSAhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 20:37:47 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:31092 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264223AbUDSAhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 20:37:45 -0400
Message-ID: <40831F4F.1000406@yahoo.com.au>
Date: Mon, 19 Apr 2004 10:37:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Antti Lankila <alankila@elma.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: elevator=as related to my 2.6 performance issues
References: <Pine.A41.4.58.0404181621140.42820@tokka.elma.fi>
In-Reply-To: <Pine.A41.4.58.0404181621140.42820@tokka.elma.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antti,
Sounds pretty serious. What happens if you set
/sys/block/*/queue/iosched/antic_expire to 0 while
using elevator=as?

Antti Lankila wrote:
> I whined a couple of weeks back with stalling USB and PS/2 mice... I seem to
> have accidentally found a workaround around the issue.
> 
> I switched to elevator=deadline the other day and found that it solved my
> issues with stalling USB mice that I'm seeing on 3 computers. Overall the
> system behaves very responsively now during IDE load, none of the bad
> behaviour such as:
> 
> - system is something like 80 % idle but still no events from USB or PS/2
>   mice appear in /dev/psaux, thus mouse doesn't move for prolonged periods.
>   I've measured the mouse to stop moving for up to 10 seconds.
> 
> - when apt-get dist-upgrade or updatedb is running, games like ut2004 start
>   to stall so much everything gets unplayable. You don't expect
>   /usr/bin/find to cause too much load. On the contrary, you would expect it
>   to be hardly noticeable.
> 
> I've seen this on 3 computers now, which have been based on KT266, KT333 and
> Nforce2. Kernels have been 2.6.3-1-k7 (Debian sarge) and 2.6.5 (custom
> compiled).
> 
> I tried elevator=deadline because I got tired of the unacceptable
> performance I was seeing from 2.6 and tried to come up with some kind of
> numbers with bonnie++ to prove that 'hey, look there, that's the problem'.
> Bonnie++ numbers with 2.6 AS looked just fine though, CPU usage was down,
> although throughput was not so good as with 2.4 (about 10 % overall
> degradiation in the "intelligent" read and write, but per-char results were
> much better). However, with deadline I got a clear improvement over 2.4 in
> the numbers and the behaviour during bonnie++.
> 
> These experiences suggests that I until this get solved I'm going to keep
> anticipatory scheduler off. Either it's directly responsible or just brings
> out some misbehaviour in another place. And yes, I have machines where AS
> never appears to cause any particular kind of trouble, so I got no idea
> what's really wrong. Other people who have had this kind of issues might
> want to try the same trick and report with results.
> 
> Antti
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

