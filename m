Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTFDAFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTFDAFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:05:16 -0400
Received: from exchange-1.umflint.edu ([141.216.3.48]:22976 "EHLO
	Exchange-1.umflint.edu") by vger.kernel.org with ESMTP
	id S261960AbTFDAFP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:05:15 -0400
X-MIMEOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Stalls from low free memory on 2.4.18 too  (fixed)
Date: Tue, 3 Jun 2003 20:15:55 -0400
Message-ID: <37885B2630DF0C4CA95EFB47B30985FB020EC025@exchange-1.umflint.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Stalls from low free memory on 2.4.18 too  (fixed)
Thread-Index: AcMqBUcyx2cirhonSWmPKJ+xqpktNwAARu0AAAC4vjAAB8HCYA==
From: "Lauro, John" <jlauro@umflint.edu>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One item I have not tried yet is one of the alternate memory
> allocation patches that are supposed to work better with HIGHMEM.
> 

None of this is probably new news to the people making the changes...
but for anyone with freezing or stalling problems it may be worth
testing... 

I am testing right now with the 2.4.20 rmap15f patch.  So far it's
been running great!  The lowest free has reports from a constant
rolling vmstat 1 was over 8000, and it seems to hover over 11000 most
of the time.  When dealing with large files, IMO the stock 2.4.x
kernels are seriously broken on HIGHMEM machines (12GB on the server I
am testing on), at least when dealing with huge file I/O.

The rmap patch seems to swap less. In fact, so far nothing has been
swapped out.  Not that it should need to, but I am just a little
surprised that it hasn't swapped any to try to get a little more
cache, but the machine has only been up a little over an hour... and
it would be silly to swap memory out when the io system is backed up
and lots of other memory in the box that is clean...

Maybe that is part of the problem with the standard 2.4.x kernels when
free gets too low?  It spends too much time trying to find something
to swap instead of just releasing clean cache?  I wasn't paying
attention, but I normally would have had about 200mb in swap by this
point...

Anyways, this server isn't collapsing now...  I'm happy now.  :)

Hopefully I will not have to reboot this box again for another year...
If anyone thinks they will have a patch that might make it into
2.4.21-rc let me know soon, and I will try to delay putting it fully
into production.


Thank you to all those who sent me messages suggesting different
patches to try.  I haven't tried all of them, but will probably try
some more of them on the next HIGHMEM server I setup (probably in a
month or two).

