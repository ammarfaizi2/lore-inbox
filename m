Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263579AbTDGSPK (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 14:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbTDGSPK (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 14:15:10 -0400
Received: from findaloan-online.cc ([216.209.85.42]:19470 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S263579AbTDGSPI (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 14:15:08 -0400
Date: Mon, 7 Apr 2003 14:33:52 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
Message-ID: <20030407183352.GA7311@mark.mielke.cc>
References: <200304071026.47557.schlicht@uni-mannheim.de> <200304072021.17080.kernel@kolivas.org> <1049712476.3e91575c2e6ae@rumms.uni-mannheim.de> <yw1xsmsuk0sm.fsf@nogger.e.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xsmsuk0sm.fsf@nogger.e.kth.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 01:24:41PM +0200, M?ns Rullg?rd wrote:
> Thomas Schlichter <schlicht@rumms.uni-mannheim.de> writes:
> > > This has been argued before. Why would the last swapped out pages
> > > be the best to swap in? The vm subsystem has (somehow) decided
> > > they're the least likely to be used again so why swap them in?
> > > Alternatively how would it know which to swap in instead?  Con

> > What I wanted to say is that if there is free memory it should be
> > filled with the pages that were in use before the memory got
> > rare. And these are the pages swapped out last. The other swapped
> > out pages are swapped out even longer and so will likely not be used
> > in the near future... (That's what the LRU algorithm says...)

> Would it be possible to track the most recently used swapped out page?
> This would possibly be a good candidate for speculative loading.

Personally, I'm not sure that this idea sounds very effective. I
_like_ the fact that after pages get swapped out, my RAM gets filled
up with file pages with use. It means that although bringing a window
that I haven't used in a while takes some time to load, my apache
server, or my xterm, can serve files or requests like 'ls' much
faster. If swap was automatically pulled in to replace my file pages,
I suspect I would be trading one evil for another.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

