Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265220AbSJaMuk>; Thu, 31 Oct 2002 07:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbSJaMuj>; Thu, 31 Oct 2002 07:50:39 -0500
Received: from 11.67.3.213.dial.bluewin.ch ([213.3.67.11]:26246 "EHLO
	k3.hellgate.ch") by vger.kernel.org with ESMTP id <S265220AbSJaMuj>;
	Thu, 31 Oct 2002 07:50:39 -0500
Date: Thu, 31 Oct 2002 13:57:24 +0100
From: Roger Luethi <rl@hellgate.ch>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Cc: alan@lxorguk.ukuu.org.uk, sergeyssv@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: VIA EPIA problem
Message-ID: <20021031125724.GA32684@k3.hellgate.ch>
Mail-Followup-To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>,
	alan@lxorguk.ukuu.org.uk, sergeyssv@mail.ru,
	linux-kernel@vger.kernel.org
References: <20021031100245.GA5207@k3.hellgate.ch> <200210311136.g9VBaKBi013883@wildsau.idv.uni.linz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210311136.g9VBaKBi013883@wildsau.idv.uni.linz.at>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.44 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002 12:36:20 +0100, H.Rosmanith (Kernel Mailing List) wrote:
> > 
> > My favorite suspect is currently byte 84 bit 3 in the configuration
> > registers. It does not exist in VT86C100A (which would explain why it's not
> > handled in Donald Becker's original code). According to VT6102 specs, it
> > indicates an error condition, according to VT6105 specs, it is reserved and
> > always reads 0.
> 
> okay, let's reopen the case. you want me to monitor this bit? perhaps

Bit 3 in 0x84 and 0x86 are those I'm most interested in. If the chip has
0x86 bit 3 cleared, try with having it set.

If that doesn't yield anything, you may want to monitor bytes 0x08, 0x09,
0x0c, 0x0d, 0x80, 0x81, 0x84 and 0x86. Just in case.

> it will be 1 in case of an error condition. for the via epia board, this
> would contradict with the specs, right? but *maybe* the bit is indeed

What spec? It seems okay with the one I have.

> 1 in case of an error, so we could possibly fix the problem just in time,
> instead of (ugly) storing some temporary value globally across functions.

That bit is just the obvious candidate, there might be others. Here's
hoping that Rhine chips don't turn off the TxEngine without setting a flag
to inform the driver.

Roger
