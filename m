Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318711AbSHAMKg>; Thu, 1 Aug 2002 08:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318733AbSHAMJi>; Thu, 1 Aug 2002 08:09:38 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:64012 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S318723AbSHAMIn>;
	Thu, 1 Aug 2002 08:08:43 -0400
Date: Thu, 1 Aug 2002 14:12:05 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.4.19-rc5 - APM bug
Message-ID: <20020801121205.GA168@pcw.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

I observe a kernel panic at boot time if I set apm=power-off. OK with apm=off.
This is on an ASUS A7M266D with two Athlon XP 1800+. Since it works well on
2.4.19-pre10, I'm recompiling intermediate versions to check which one brought
the problem.

This is rather strange, since the crash occurs in do_softirq, but 2 bytes after
the beginning of an instruction :
c0120d09 fa			cli
c0120d0a 8b b5 80 17 3c c0	mov 0xc03c1780(%ebp),%esi

The crash occurs at c0120d0c (80 17 3c c0 ...). Seems like a bad pointer
somewhere.

Regards,
Willy

