Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbTHVPgG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 11:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263841AbTHVPgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 11:36:06 -0400
Received: from birosca.ime.usp.br ([143.107.45.59]:34246 "HELO
	birosca.ime.usp.br") by vger.kernel.org with SMTP id S263827AbTHVPgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 11:36:00 -0400
Date: Fri, 22 Aug 2003 12:35:01 -0300
From: Livio Baldini Soares <livio@ime.usp.br>
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in drivers/block/ll_rw_blk.c ?
Message-ID: <20030822153501.GB31360@ime.usp.br>
Mail-Followup-To: Livio Baldini Soares <livio@ime.usp.br>,
	Yoav Weiss <ml-lkml@unpatched.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0308220030420.27026-100000@marcellos.corky.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308220030420.27026-100000@marcellos.corky.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Yoav!

Yoav Weiss writes:
> A few days ago I posted the report attached below.  After some more
> research, I'm starting to think I've hit a bug in ll_rw_blk.c.
> 
> If the maintainer of the block dev subsystem happens to be reading
> this, please contact me on the list or by mail.

  I'm not the  maintainer, but I'm pretty sure that there  is no problem in
that specific  code... but I  think you're hitting  another bug in  the 2.4
tree (read below...)

[...snip...]

> The cloop (compressed loop) code I'm debugging is this one:
> 
> http://developer.linuxtag.net/knoppix/sources/cloop_1.0-2.tar.gz
> 
> I'm testing with kernel 2.4.22-rc2.

[...snip...]

> The stalled process waits on a page in mm/filemap.c:1505:
> 
> /* Again, try some read-ahead while waiting for the page to finish.. */
> 	generic_file_readahead(reada_ok, filp, inode, page);
> ------> wait_on_page(page);
> 
> 
> I found who wakes it up in calls that don't stall:
> unlock_page(), called from
> drivers/block/ll_rw_blk.c:end_that_request_first().
> bh->b_end_io(bh, uptodate) seems to do it.


  From  this description  it seems  that you  are hitting  a bug  which was
discussed to death here on the  list. Here's a thread with 143 messages for
you:

http://marc.theaimsgroup.com/?t=105400721000001&r=5&w=2

  And here are the threads in which a solution was dicussed:

http://marc.theaimsgroup.com/?t=105519528200001&r=1&w=2
http://marc.theaimsgroup.com/?t=105769525800005&r=3&w=2

  Notice, however, that  the patch Chris, Andrea, Jens  and others made for
this  problem is _already_  included in  2.4 (so,  yes, 2.4.22-rc2  has the
fix).

  So, you are  probably hitting the same bug, which was  not fixed 100%. If
you think  that your  test is  very easily reproducible  and can  shed more
light on this  problem, perhaps you should write to  Chris, Andrea and Jens
(with Cc: to the list), and show  them the test. I don't know if they would
be willing to spend more time  on this issue, specially with 2.6 around the
corner... 

  best regards,  

--  
  Livio B. Soares
