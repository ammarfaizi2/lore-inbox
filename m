Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S269281AbRHCCsm>; Thu, 2 Aug 2001 22:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S269285AbRHCCsd>; Thu, 2 Aug 2001 22:48:33 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:12301 "EHLO vasquez.zip.com.au") by vger.kernel.org with ESMTP id <S269281AbRHCCsT>; Thu, 2 Aug 2001 22:48:19 -0400
Message-ID: <3B6A11F9.9C5FCDE7@zip.com.au>
Date: Fri, 03 Aug 2001 12:52:41 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show_trace() module_end = 0?
References: <Pine.LNX.4.33.0108021553500.7060-100000@chaos.tp1.ruhr-uni-bochum.de> <Pine.LNX.4.21.0108021822340.959-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> 
> > The other, minor problem is that we should walk the module_list under
> > lock_kernel() only, but I wasn't brave enough to add this to the
> > show_trace() code path.
> 
> I think it's just modlist_lock you'd need.  Not sure whether better
> to try for it or ignore it.  CC'ed Andrew "spinlock-buster" Morton
> for his opinion.

Debugging things like show_trace() may be called from any context
at all, and hence really cannot take locks.  We just live with the
race possibilities.

One could possibly play games with spin_trylock, but I don't expect
it'd help much - if you failed to get the lock what can you do?

-
