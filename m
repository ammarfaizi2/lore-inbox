Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVANNwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVANNwW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 08:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVANNwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 08:52:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9441 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261983AbVANNwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 08:52:17 -0500
Date: Fri, 14 Jan 2005 08:21:14 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Roy Keene (Contractor)" <keene@nrlssc.navy.mil>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.28 crashes with BUG at page_alloc.c:144
Message-ID: <20050114102113.GB8176@logos.cnet>
References: <Pine.LNX.4.58.0501131241230.6797@opt-riedlinger.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501131241230.6797@opt-riedlinger.nrlssc.navy.mil>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 12:44:23PM -0600, Roy Keene (Contractor) wrote:
> I'm having problems with a stock 2.4.28 kernel occasionally giving
> BUGs and then the system becoming unstable.
> 
> Has anyone else seen this ?

A page being freed has the "mapping" pointer set:

         if (page->mapping)
                BUG();
> Example:
> 
> Jan 13 10:24:30 x kernel: kernel BUG at page_alloc.c:144!
> Jan 13 10:24:30 x kernel: invalid operand: 0000
> Jan 13 10:24:30 x kernel: CPU:    0
> Jan 13 10:24:30 x kernel: EIP:    0010:[<c013a3d2>]    Tainted: P
> Jan 13 10:24:30 x kernel: EFLAGS: 00013282
> Jan 13 10:24:30 x kernel: eax: 00000000   ebx: c28c1760   ecx: c02f32d4   edx: c02f3040
> Jan 13 10:24:30 x kernel: esi: c28c1760   edi: 00000000   ebp: ea01fbc4   esp: f47fbdd0
> Jan 13 10:24:30 x kernel: ds: 0018   es: 0018   ss: 0018
> Jan 13 10:24:30 x kernel: Process X (pid: 2412, stackpage=f47fb000)
> Jan 13 10:24:30 x kernel: Stack: 00000001 00003286 00000003 cb6eca00 cb6eca00 cb6eca00 c28c1760 c01479d3
> Jan 13 10:24:30 x kernel:        cb6eca00 00000000 c28c1760 c02f31f8 000200a6 c0139a1c c28c1760 000001d2
> Jan 13 10:24:30 x kernel:        00000b54 000001d2 00000018 0000001d 000001d2 c02f31f8 c02f31f8 c0139c6a
> Jan 13 10:24:30 x kernel: Call Trace:    [<c01479d3>] [<c0139a1c>] [<c0139c6a>] [<c0139ce2>] [<c012688a>]
> Jan 13 10:24:30 x kernel:   [<c013a93d>] [<c013ac58>] [<c012e117>] [<c012e4c5>] [<c0119648>] [<c0108cba>]
> Jan 13 10:24:30 x kernel:   [<c0122e25>] [<c012688a>] [<c0117588>] [<c01192d0>] [<c0108fbc>]
> Jan 13 10:24:30 x kernel:
> Jan 13 10:24:30 x kernel: Code: 0f 0b 90 00 57 d0 2a c0 8b 35 d0 27 37 c0 89 d8 29 f0 c1 f8

Are you using any binary module? Seems so.


