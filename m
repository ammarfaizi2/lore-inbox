Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265328AbRFVEZR>; Fri, 22 Jun 2001 00:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265330AbRFVEZH>; Fri, 22 Jun 2001 00:25:07 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:22003 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S265328AbRFVEYy>; Fri, 22 Jun 2001 00:24:54 -0400
Date: Fri, 22 Jun 2001 13:24:50 +0900
Message-ID: <1yodnnu5.wl@nisaaru.open.nm.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: raf@raf.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: bugreport: poll() timeout always takes 10ms too long
In-Reply-To: <20010622115212.A8681@eccles.raf.org>
In-Reply-To: <20010622115212.A8681@eccles.raf.org>
User-Agent: Wanderlust/2.5.8 (Smooth) EMY/1.13.9 (Art is long, life is
 short) SLIM/1.14.7 (=?ISO-2022-JP?B?GyRCPHIwZjpMTD4bKEI=?=) APEL/10.3 MULE
 XEmacs/21.2 (beta46) (Urania) (i386-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello,

At Fri, 22 Jun 2001 11:52:12 +1000,
raf@raf.org wrote:
> 
> [1.] One line summary of the problem:    
> 
> poll() timeout always takes 10ms too long
> 
> [2.] Full description of the problem/report:
> 
> Select() timeouts work fine. A timeout between 10n-9 and 10n ms times
> out after 10n ms on average. Poll() timeouts between 10n-9 and 10n ms,
> on the other hand, time out after 10(n+1) ms on average. It's always a
> jiffy too long. This means it's impossible to set a 10ms timeout using
> poll() even though it's possible using select(). The programs and their
> output below [6] demonstrate this. The same behavious occurs with
> linux-2.2 and linux-2.4.


  I think this is correct behavior. The Single UNIX Specification
describes about the timeout parameter of poll() as follows,

	If none of the defined events have occurred on any selected
	file descriptor, poll() waits at least timeout milliseconds
	for an event to occur on any of the selected file descriptors.

  On the other hand, select(),

	If the specified condition is false for all of the specified
	file descriptors, select() blocks, up to the specified timeout
	interval, until the specified condition is true for at least
	one of the specified file descriptors.
