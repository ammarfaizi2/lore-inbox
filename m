Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUC3QRg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 11:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbUC3QRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 11:17:36 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:7695 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262960AbUC3QRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 11:17:34 -0500
Date: Tue, 30 Mar 2004 18:14:31 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Len Brown <len.brown@intel.com>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Message-ID: <20040330161431.GA22272@alpha.home.local>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com> <1080535754.16221.188.camel@dhcppc4> <20040329052238.GD1276@alpha.home.local> <1080598062.983.3.camel@dhcppc4> <1080651370.25228.1.camel@dhcp23.swansea.linux.org.uk> <Pine.LNX.4.53.0403300814350.5311@chaos> <20040330142215.GA21931@alpha.home.local> <Pine.LNX.4.53.0403300943520.6151@chaos> <20040330150949.GA22073@alpha.home.local> <Pine.LNX.4.53.0403301019570.6451@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0403301019570.6451@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That's not what I meant. I only meant to declare the cmpxchg() function.
> 
> It's not a function. It is actual op-codes.

I know it's an opcode (I even wrote an emulator for it). But it's used
as an inline function in linux. Check include/asm-i386/system.h.

> If you compile with '486 or higher, the C compiler is free to spew
> out these op-codes any time it thinks it's a viable instruction
> sequence. Since it basically replaces two other op-codes, gcc might
> certainly use if for optimization.

Yes, only if you compile with -m486 or higher. When Linux is compiled for
386 target, the -march=i386 is correctly appended, which prevents gcc from
using this instruction (as well as bswap and xadd BTW).

In what I described, a 386 target would be compiled with -march=i386,
but the cmpxchg() FUNCTION will still reference the cmpxchg op-code
in the __asm__ statement, and this is perfectly valid. In this case,
only callers of the cmpxchg() FUNCTION will have a chance to use it.
And at the moment, the only client seems to be ACPI.

Anyway, I think that basically we understand ourselves, and it's just
a matter of words.

Cheers,
Willy

