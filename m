Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275811AbRJNR0V>; Sun, 14 Oct 2001 13:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275822AbRJNR0L>; Sun, 14 Oct 2001 13:26:11 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:20608 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S275811AbRJNRZv>; Sun, 14 Oct 2001 13:25:51 -0400
Message-ID: <3BC9CAA9.7378075B@welho.com>
Date: Sun, 14 Oct 2001 20:26:01 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: ak@muc.de, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
In-Reply-To: <200110141707.VAA06123@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > Not very hard at all. It could be done easily with a couple of extra
> > state variables.
> 
> Does current heuristics not work? :-)

Well, you should read the preceding messages to understand how we got
here.

Andi had some reservations and I tend to agree. The current heuristic
assumes specific TCP behaviour, which is left as an implementation issue
in specifications. Conclusion: it works if you're lucky.

But it's true I can't show you any data to the contrary, either. This is
not the issue that started this thread.

> > state variables. The following is a rough pseudo code (ignores
> > initialization of state variables):
> 
> You missed one crucial moment: stream may consist of remnants
> for long time or even forever. It is normal case. And rcv_mss is used
> not only and mostly not for ACKing, it is used in really important places
> (SWS avoidance et al), where specs propose to use your advertised MSS,
> which does not work at all when you talk over high MTU interfaces.

I don't think I missed that point.

> The approach (invented by Andi?) provided necessary robustness,
> checking for two segments in row and suppressing MSS drops below 536.
> Check for PSHless segments allows to detect really low mtu reliably.

When you say "reliably", you should recognize the underlying assumptions
as well.

> Alexey

Regards,

	MikaL
