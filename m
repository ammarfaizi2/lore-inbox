Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbUCEUdB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 15:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbUCEUdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 15:33:01 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8715
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262696AbUCEUc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 15:32:59 -0500
Date: Fri, 5 Mar 2004 21:33:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@osdl.org>, peter@mysql.com, riel@redhat.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305203340.GU4922@dualathlon.random>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040303200704.17d81bda.akpm@osdl.org> <20040304045212.GG4922@dualathlon.random> <20040303211042.33cd15ce.akpm@osdl.org> <20040305201954.GB7254@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305201954.GB7254@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 08:19:55PM +0000, Jamie Lokier wrote:
> Andrew Morton wrote:
> >   We believe that this could cause misbehaviour of such things as the
> >   boehm garbage collector.  This patch provides the mprotect() atomicity by
> >   performing all userspace copies under page_table_lock.
> 
> Can you use a read-write lock, so that userspace copies only need to
> take the lock for reading?  That doesn't eliminate cacheline bouncing
> but does eliminate the serialisation.

normally the bouncing would be the only overhead, but here I also think
the serialization is a significant factor of the contention because the
critical section is taking lots of time. So I would expect some
improvement by using a read/write lock.
