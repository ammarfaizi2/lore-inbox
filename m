Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291707AbSBHSih>; Fri, 8 Feb 2002 13:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291716AbSBHSiY>; Fri, 8 Feb 2002 13:38:24 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:7779 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S291707AbSBHSiK>; Fri, 8 Feb 2002 13:38:10 -0500
Date: Fri, 8 Feb 2002 13:38:06 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Tigran Aivazian <tigran@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] larger kernel stack (8k->16k) per task
Message-ID: <20020208133806.B23001@devserv.devel.redhat.com>
In-Reply-To: <3C640994.F3528E74@redhat.com> <Pine.LNX.3.95.1020208123843.1974A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1020208123843.1974A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Fri, Feb 08, 2002 at 01:29:16PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 01:29:16PM -0500, Richard B. Johnson wrote:
> I think it is entirely inefficient to call an external procedure
> for temporary variable space when the actual math is done by the
> compiler at compile time, and the code is a simple subtraction, then
> later-on a simple addition to a single register!

Depends. If you need a few bytes (and upto 1Kb I'd call a few bytes if
you're careful), then stack usage is fine. If you need more, well, kmalloc
is some 100 cycles...

> If the kernel does not provide sufficient stack-space for small
> buffers and structures, it is a kernel problem,

notice the *small*

The alternative is to double the amount of PER PROCESS overhead in terms of
unswappable memory... Even 1 disk IO will hurt more than your kmalloc of 4Kb
of "small buffers and structures" will in a year.


