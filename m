Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSH0S6K>; Tue, 27 Aug 2002 14:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSH0S6K>; Tue, 27 Aug 2002 14:58:10 -0400
Received: from AMarseille-201-1-5-72.abo.wanadoo.fr ([217.128.250.72]:5232
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316674AbSH0S6J>; Tue, 27 Aug 2002 14:58:09 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <Richard.Zidlicky@stud.informatik.uni-erlangen.de>, <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: readsw/writesw readsl/writesl
Date: Tue, 27 Aug 2002 11:29:07 +0200
Message-Id: <20020827092908.31569@192.168.4.1>
In-Reply-To: <200208271600.SAA17957@faui02b.informatik.uni-erlangen.de>
References: <200208271600.SAA17957@faui02b.informatik.uni-erlangen.de>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> ...... However, if we decide to go the way
>> you describe, the we should probably also provide the raw_{in,out}*
>> ones.
>
>carefull, m68k already has them for other purposes. Original intention
>was that raw_{in,out} should never be used outside architecture specific 
>stuff anyway.

Then we have a problem... Either we chose to keep 2 different interfaces
for MMIO and "PIO" with the "s" versions on PIO and not on MMIO, the
raw versions on MMIO but not PIO, etc...

Or we decide to unify this properly.

In all cases, the current abstraction doesn't allow to re-implement
{in,out}s{b,w,l}. This is already a problem as if a driver need to
pump a fifo with some udelay's (like doing a _p version of one of
the above), it can't or has to do some arch specific crap to deal
with byteswap, barriers, etc...

Ben.


