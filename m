Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284495AbRLMSAT>; Thu, 13 Dec 2001 13:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284491AbRLMSAL>; Thu, 13 Dec 2001 13:00:11 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:7699 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S284495AbRLMR7z>;
	Thu, 13 Dec 2001 12:59:55 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200112131759.UAA01376@ms2.inr.ac.ru>
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2
To: Mika.Liljeberg@welho.com (Mika Liljeberg)
Date: Thu, 13 Dec 2001 20:59:37 +0300 (MSK)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3C17BEB0.FDE8E9EB@welho.com> from "Mika Liljeberg" at Dec 12, 1 10:31:44 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Looks like there are still problems

This is not related to that problem.


> 11:11:57.149389 10.0.5.3.3071 > 10.0.5.11.1327: P 254033:255481(1448) ack 1 win 7300 <timestamp 3704210538 8515686,eol> (DF) (ttl 63, id 860, len 1500)
> 11:11:57.149451 10.0.5.11.1327 > 10.0.5.3.3071: . [tcp sum ok] 1:1(0) ack 255481 win 65160 <nop,nop,timestamp 8544990 3704210538> (DF) (ttl 64, id 30696, len 52)
> 11:11:57.661595 10.0.5.3.3071 > 10.0.5.11.1327: FP 255481:256001(520) ack 1 win 7300 <timestamp 3705679288 8515686,eol> (DF) (ttl 63, id 861, len 572)
> 11:11:57.661660 10.0.5.11.1327 > 10.0.5.3.3071: F [tcp sum ok] 1:1(0) ack 256002 win 65160 <nop,nop,timestamp 8545041 3705679288> (DF) (ttl 64, id 30697, len 52)
> 11:12:11.340666 10.0.5.3.3071 > 10.0.5.11.1327: FP 255481:256001(520) ack 1 win 7300 <timestamp 3727069913 8515686,eol> (DF) (ttl 63, id 863, len 572)
> 11:12:11.340698 10.0.5.11.1327 > 10.0.5.3.3071: . [tcp sum ok] 2:2(0) ack 256002 win 65160 <nop,nop,timestamp 8546409 3727069913,nop,nop,sack sack 1 {255481:256002} > (DF) (ttl 64, id 30698, len 64)

Please, make cat /proc/net/tcp at this point. To be honest I do not believe
that tcpdump finishes _here_. When will retransmit timer expire? Taking
into account that 10.0.5.3 has rto of 14 seconds (distance between retransmits
of its FIN :-)), linux can have even more. In the case of such bad connection
closing fin-wait-2 via abort is pretty normal.

Alexey
