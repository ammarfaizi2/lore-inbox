Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSGLC66>; Thu, 11 Jul 2002 22:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317972AbSGLC65>; Thu, 11 Jul 2002 22:58:57 -0400
Received: from quechua.inka.de ([212.227.14.2]:1367 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S314277AbSGLC64>;
	Thu, 11 Jul 2002 22:58:56 -0400
From: Bernd Eckenfels <ecki-news2002-06@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <5.1.0.14.2.20020711201602.022387b0@whisper.qrpff.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17Sqgi-0002Pe-00@sites.inka.de>
Date: Fri, 12 Jul 2002 05:01:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <5.1.0.14.2.20020711201602.022387b0@whisper.qrpff.net> you wrote:
> Why must HZ be the same as 'interrupts per second'?

Well, it must not. But currently each timer interrupt the tick timestamp is
increased by one. So to find out how many seconds uptime you have (and other
things which are measured in timer ticks and passed to the userspace) you
need to know how many ticks have passed.

Actually there are a few things here, on the one hand, kernel should not
pass values in ticks to the userspace. 

On the other hand having a changing HZ does not work for timespans measured
in those ticks, as long as those are not adjusted. One could think about
having a doze mode where only every 100th interruped is generated but it
increasedss the tick count by 100. Mst likely this will break a lot of
averaged measuring and stats counting, tough.

Greetings
Bernd
