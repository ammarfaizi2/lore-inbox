Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUIIXpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUIIXpN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUIIXpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:45:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:33505 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267212AbUIIXlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:41:49 -0400
Date: Thu, 9 Sep 2004 16:41:44 -0700
From: Chris Wright <chrisw@osdl.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] update: _working_ code to add device+inode check to ipt_owner.c
Message-ID: <20040909164144.F1924@build.pdx.osdl.net>
References: <20040909162200.GB9456@lkcl.net> <20040909091931.K1973@build.pdx.osdl.net> <20040909181034.GF10046@lkcl.net> <20040909213813.GC10892@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040909213813.GC10892@lkcl.net>; from lkcl@lkcl.net on Thu, Sep 09, 2004 at 10:38:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Luke Kenneth Casson Leighton (lkcl@lkcl.net) wrote:
> chris - for example, i notice that at the top of ipt_owner.c it says
> "deals with local outgoing sockets".
> 
> so... does sk_buff _only_ contain a list of outgoing sockets?

no, and in fact outgoing there's no question who's sending the packet,
as it's still in process context.

> iiiisss... there a different socket for incoming traffic that
> someone is different from the list of sockets associated with
> a task?
> 
> is the clue in what you say about "Incoming is in interrupt context"?
> 
> are the sockets in the interrupt context somehow different / special
> such that they would never get to this code?

Depends on where the hooks are registered into netfilter whether you'll
get the inbound stuff.  I'm assuming this part is ok.  Point is, the act
of receiving a packet and queueing data to a socket does not happen in
process context.  So you don't know who will be woken up to actually
read data from that socket.  Your stuff should work for most cases.  But
it's not fundamentally deterministic enough to call it really secure.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
