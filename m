Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265580AbUAZX1q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbUAZX1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:27:45 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:15816 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265580AbUAZX1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:27:41 -0500
Message-ID: <4015A24A.3090101@cyberone.com.au>
Date: Tue, 27 Jan 2004 10:27:06 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange xmms deaths under high disk load
References: <yw1xu12i1fak.fsf@ford.guide>
In-Reply-To: <yw1xu12i1fak.fsf@ford.guide>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Måns Rullgård wrote:

>I have encountered a very strange (to me, at least) error.  I can
>reliably cause xmms to crash by simply doing some intensive disk IO.
>Copying a few hundred megabytes usually does it.  After about 20
>seconds of heavy disk IO, xmms will die with this message:
>
>** WARNING **: snd_pcm_wait: Input/output error
>Xlib: unexpected async reply (sequence 0x2ef5c)!
>
>The hex number varies.
>
>The machine is an Alpha SX164 running Linux 2.6.2-rc2 patched up to
>ALSA 1.0.1.  The problem has been around for quite a while, probably
>also with kernel 2.4.21, though I can't confirm that at the moment.
>The sound card is a cmi8738.
>
>If I play music with TCVP instead, it keeps playing, but sound is
>choppy at intervals.  Below is vmstat output during a copying.
>
>procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
> r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
> 0  0      0  86128   3424 165920    0    0    66    66   24     4 23 23 54  0
> 0  0      0  86128   3424 165920    0    0     0     0 1131  1352 17 14 69  0
> 0  0      0  86128   3424 165920    0    0     0     0 1128  1360 13  4 84  0
> 0  0      0  86128   3424 165920    0    0     0     0 1129  1351 13  4 84  0
> 0  0      0  86128   3424 165920    0    0     0   153 1142  1361 14  3 83  0
> 0  0      0  86128   3424 165920    0    0     0     0 1127  1353 14  4 83  0
> 0  0      0  86128   3424 165920    0    0     0     0 1128  1348 12  3 84  0
> 0  0      0  86128   3424 165920    0    0     0     0 1130  1344 17 15 69  0
> 0  0      0  86000   3424 166048    0    0   128     0 1132  1356 13  3 84  0
>
...

>11  2      0   2400   3392 246368    0    0   768 26112  969   626 25 71  0  3
>
...

>11  0      0   3040   1704 248160    0    0     0 33704  696    58 10 90  0  0
>
...

>
> 1  1      0   2528   1736 250608    0    0  1756 21332  965   590 35 56  0  8
>

Looks like you might be losing timer interrupts, possibly caused
by an IDE disk doing PIO?


