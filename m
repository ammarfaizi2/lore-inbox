Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263099AbSITRLw>; Fri, 20 Sep 2002 13:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbSITRLw>; Fri, 20 Sep 2002 13:11:52 -0400
Received: from are.twiddle.net ([64.81.246.98]:12440 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S263099AbSITRLu>;
	Fri, 20 Sep 2002 13:11:50 -0400
Date: Fri, 20 Sep 2002 10:16:36 -0700
From: Richard Henderson <rth@twiddle.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, Brian Gerst <bgerst@didntduck.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, dvorak <dvorak@xs4all.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
Message-ID: <20020920101636.A25490@twiddle.net>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	"J.A. Magallon" <jamagallon@able.es>,
	Brian Gerst <bgerst@didntduck.org>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>, dvorak <dvorak@xs4all.nl>,
	linux-kernel@vger.kernel.org
References: <20020919224613.GA2026@werewolf.able.es> <Pine.LNX.3.95.1020920081925.19137A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1020920081925.19137A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Fri, Sep 20, 2002 at 08:27:32AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 08:27:32AM -0400, Richard B. Johnson wrote:
> Adding 1 to %eax is plain dumb.

No it isn't.  P4 has a partial register stall on the
flags register when using incl.  You'll notice that
we *do* use incl except when optimizing for P4.

> Also that 1 is 4 bytes long.

No it isn't.  There is an 8-bit signed immediate form.

As for the rest of the memory operand rant, the problem
is not that gcc won't try to use memory operands, it's
that the bit of code that's supposed to put these 
memory operands back together is like 10 years old and
hasn't been taught about the memory aliasing subsystem.
So any time it sees a memory load cross a memory store,
it gives up.

Perhaps I'll have this fixed for gcc 3.4.



r~
