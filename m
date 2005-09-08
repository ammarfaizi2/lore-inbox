Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbVIHUb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVIHUb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 16:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbVIHUbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 16:31:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53473 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964991AbVIHUbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 16:31:25 -0400
Date: Thu, 8 Sep 2005 21:31:20 +0100
From: viro@ZenIV.linux.org.uk
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org, davem@redhat.com, akpm@osdl.org
Subject: Re: Serial maintainership
Message-ID: <20050908203120.GC9623@ZenIV.linux.org.uk>
References: <20050908165256.D5661@flint.arm.linux.org.uk> <1126197523.19834.49.camel@localhost.localdomain> <Pine.LNX.4.58.0509080922230.3208@g5.osdl.org> <20050908.131358.93602687.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050908.131358.93602687.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 01:13:58PM -0700, David S. Miller wrote:
> From: Linus Torvalds <torvalds@osdl.org>
> Date: Thu, 8 Sep 2005 09:27:56 -0700 (PDT)
> 
> > Mistakes happen, and the way you fix them is not to pull a tantrum, but 
> > tell people that they are idiots and they broke something, and get them to 
> > fix it instead.
> 
> In all this noise I still haven't seen what is wrong with
> the build warning fix I made.

The fact that it's called regardless of SUPPORT_SYSRQ and some callers
look like

#ifdef SUPPORT_SYSRQ
int foo(blah, struct pt_regs *regs)
#else
int foo(blah)
#endif
{
	...
	uart_handle_sysrq_char(..., regs);
	...
}

which works with old definition (without SUPPORT_SYSRQ the last argument of
uart_handle_sysrq_char() is never seen by parser) and obviously dies with
the new one.

And yes, it's sick...
