Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291214AbSBXUwh>; Sun, 24 Feb 2002 15:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291246AbSBXUw1>; Sun, 24 Feb 2002 15:52:27 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:32772 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291214AbSBXUwP>; Sun, 24 Feb 2002 15:52:15 -0500
Date: Sun, 24 Feb 2002 21:52:02 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Troy Benjegerdes <hozer@drgw.net>, Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224215202.A1706@ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org> <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com> <20020224013038.G10251@altus.drgw.net> <3C78DA19.4020401@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C78DA19.4020401@evision-ventures.com>; from dalecki@evision-ventures.com on Sun, Feb 24, 2002 at 01:18:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 01:18:33PM +0100, Martin Dalecki wrote:
> > Ummm, how does this work if I have two PCI ide cards, one on a 66mhz PCI 
> > bus, and one on a 33mhz PCI bus?
> > 
> > Or am I missing something?
> 
> You are missing the fact that it didn't work before.

Actually, no. The parameter is a 'base clock', it isn't related to the
66 MHz - if you set it to for example 25, the drivers will know that if
you have a PCI 66 MHz bus, it's running only on 2*25 = 50 MHz. The
multiplier is known from PCI config and isn't related to this parameter.

The parameter is also used for VLB, where it is more important, because
VLB has no standard clock - it can run at 33, 40 or 50 MHz.

Let me also note here that the bus speed value here doesn't have the
necessary precision to compute the IDE timings correctly for higher UDMA
speeds, and that most drivers either assume 33 MHz PCI blindly or have a
set of fixed values they know.

-- 
Vojtech Pavlik
SuSE Labs
