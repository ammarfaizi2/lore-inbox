Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267014AbTAFQmv>; Mon, 6 Jan 2003 11:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbTAFQmv>; Mon, 6 Jan 2003 11:42:51 -0500
Received: from www.wireboard.com ([216.151.155.101]:63877 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id <S267014AbTAFQmu>; Mon, 6 Jan 2003 11:42:50 -0500
To: Alex Riesen <fork0@users.sf.net>
Cc: Dirk Bull <dirkbull102@hotmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: shmat problem
References: <20030106162251.GA15900@steel>
	<m3wuligrqg.fsf@varsoon.wireboard.com> <20030106164332.GA16131@steel>
From: Doug McNaught <doug@mcnaught.org>
Date: 06 Jan 2003 11:50:24 -0500
In-Reply-To: Alex Riesen's message of "Mon, 6 Jan 2003 17:43:32 +0100"
Message-ID: <m3smw6gr3j.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen <fork0@users.sf.net> writes:

> Doug McNaught, Mon, Jan 06, 2003 17:36:39 +0100:
> > > You have to add SHM_REMAP to shmat flags (see definitions of SHM_ flags).
> > Hmm, the manpage (on RH7.3 at least) doesn't mention SHM_REMAP.  Nice
> > to know about it.
> 
> RH7.3 manpage is quiet old, btw.

Apparently so.

> Linux manpages-1.54 (Dec 30 2002):
> 
>    The  (Linux-specific) SHM_REMAP flag may be asserted in shmflg to indi-
>    cate that the mapping of the segment should replace any  existing  map-
>    ping  in  the  range starting at shmaddr and continuing for the size of
>    the segment.  (Normally an EINVAL  error  would  result  if  a  mapping
>    already  exists in this address range.)  In this case, shmaddr must not
>    be NULL.

Wouldn't the OP's code still (potentially) have problems? What if you
had:

char my_shared_area[2048];
int my_unshared_var;

...

   void *foo = shmat(id, &my_shared_area, SHM_REMAP);


Would my_unshared_var end up shared, since memory mappings have page
granularity?

-Doug
