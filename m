Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265019AbSKFM43>; Wed, 6 Nov 2002 07:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265020AbSKFM43>; Wed, 6 Nov 2002 07:56:29 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:12952 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265019AbSKFM42>; Wed, 6 Nov 2002 07:56:28 -0500
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Willy Tarreau <willy@w.ods.org>, Jim Paris <jim@jtan.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1021106074128.3698A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1021106074128.3698A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 13:25:24 +0000
Message-Id: <1036589124.9781.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 12:47, Richard B. Johnson wrote:
> udelay() would work memory/read/write is entirely different from I/O
> port read/write even though PWB traces are shared. But that might
> result in wasted CPU cycles.

udelay actually makes a lot lot more sense than the current _p stuff.
Legacy-free hardware might not do what is expected with port 0x80
eventually and still have stuff using _p
> 
> This works in all cases in machines I have tested. I can't test everything
> but, depending upon whether or not the forces a cache-line refill, the
> delay can be from 200 ns to over 800 ns. I have a single instance of this,
> and call it, rather than doing in-line. This adds a further delay.

Thats a call/return stack break. That does delay damage in excess of
what you actually want and the wrong places. udelay does the right thing

