Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267359AbUHXJom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUHXJom (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 05:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267366AbUHXJol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 05:44:41 -0400
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:36491 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267359AbUHXJoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 05:44:07 -0400
References: <412880BF.6050503@kolivas.org> <412A2398.8050702@asylumwear.com> <412A271F.3040802@gmx.de> <412A663D.2050104@kolivas.org> <cone.1093304064.895888.10766.502@pc.kolivas.org> <412B0A4F.2080603@gmx.de>
Message-ID: <cone.1093340584.747342.10766.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Prakash =?ISO-8859-1?B?Sy4=?= Cheemplavam <prakashkc@gmx.de>
Cc: ck kernel mailing list <ck@vds.kolivas.org>,
       Joshua Schmidlkofer <menion@asylumwear.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-ck4
Date: Tue, 24 Aug 2004 19:43:04 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam writes:
> |>> version of ck exhibited this, but the last one for 2.6.7 did work well
> |>> (I think even the one for 2.8.6-rc4 was ok), IIRC. In my case, when
> |>> doing a (niced) compile in background, some windows react very slow, ie
> |>> Mozilla Thunderbird takes ages to switch trough mails or cliking on an
> |>> icon in kde to load up konsole takes about 10seconds or more (shoud come
> |>> up <1sec normally).

> |>>> |> For both of you this only happens with NFS? Can you reproduce the
> |> problem in flight and send me the output of 'top -n -n 1' while it's
> |> happening? Also if you have time can you confirm this happens with
> |> just the staircase patch and none of the other patches?
> |
> |
> | blah... I mean `top -b -n 1`
> 
> SO exactly what I observed, even with the latest test fix. In my first
> try the machin did even do a hard lock...
> 
> So I did a emerge -B xorg-x11 (ie. I started compiling xorg-x11 using
> gentoo's emerge system). The hard lock occured after a minute or so.
> Next try I waited only a bit. I clicked on konsole icon to come up, but
> doesn't want to come for too long. In this time I did the top you see.
> I'll boot up linux-2.6.8-rc4 and test again (must check first whether it
> has reiser4 support...). I will also try to back oput staircase and try
> without.
> 
> As you can see xorg-x11 wasn't really compiling ie not using cpu, it was
> just scaning through the directories to find it it has nothing to do:

Does it happen without nfs or not? Does it happen with only the staircase 
patch or not?

> light@tachyon ~ $ top -b -n 1
> top - 11:22:41 up 4 min,  4 users,  load average: 2.03, 1.20, 0.51
> Tasks:  94 total,   4 running,  90 sleeping,   0 stopped,   0 zombie
> Cpu(s):  7.4% us, 17.3% sy, 25.2% ni, 25.8% id, 23.6% wa,  0.1% hi,  0.6% si
> Mem:   1034224k total,   646380k used,   387844k free,    39220k buffers
> Swap:        0k total,        0k used,        0k free,   467460k cached

You're not hitting swap.

> 
> ~  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> ~ 5491 root      20   0  151m  20m 141m S  9.9  2.0   0:10.99 X

X is as good priority as it gets.

> ~ 5662 light     20   0 31616  15m  28m S  4.0  1.5   0:01.32 kdeinit
> 14859 light     20   0 31152  14m  28m R  2.0  1.5   0:00.33 kdeinit

So is kde

> ~   44 root      20   0     0    0    0 S  0.0  0.0   0:00.00 kswapd0

kswapd isn't chewing up cpu time.

In fact nothing is chewing up a lot of cpu time; you're just waiting on i/o

> Cpu(s):  7.4% us, 17.3% sy, 25.2% ni, 25.8% id, 23.6% wa,  0.1% 
hi,  0.6% si

You even have 25% idle time so you have cpu to spare. Doesn't sound like a 
scheduling issue but something getting stuck during I/O. 

Something else is at play here. I need more information about 
the questions above.

Con

