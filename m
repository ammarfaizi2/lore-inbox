Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261988AbRFLPq4>; Tue, 12 Jun 2001 11:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbRFLPqq>; Tue, 12 Jun 2001 11:46:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34716 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261988AbRFLPq3>;
	Tue, 12 Jun 2001 11:46:29 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15142.14648.665490.589503@pizda.ninka.net>
Date: Tue, 12 Jun 2001 08:46:00 -0700 (PDT)
To: Keith Owens <kaos@ocs.com.au>
Cc: DJBARROW@de.ibm.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: bug in /net/core/dev.c 
In-Reply-To: <9802.992360059@ocs4.ocs-net>
In-Reply-To: <15142.11764.844524.381111@pizda.ninka.net>
	<9802.992360059@ocs4.ocs-net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith Owens writes:
 > David, how do any network drivers that need net_dev_init() work when
 > all $(DRIVERS) come before $(NETWORKS)?  This is a generic problem, not
 > s390 specific.

Then I don't understand why none of the statically built in drivers in
any of my kernels (on any platform I use, sparc64, i386, etc.) make
that "early initialization of device XXX deferred" message get spit
out.

Actually after some studying I do understand :-) net_dev_init() is not
invoked via net/* initialization.  My bad.  It gets invoked from
drivers/block/genhd.c:device_init()  so that is the ordering
dependency and why things work for non-s390 network devices now.

So, if the s390 folks move their stuff into the appropriate spot it
will work.  In fact, I personally like to see the s390 net devices
under drivers/net/s390 anyways.  They'll get free maintenance from
myself and Jeff Garzik in this way as I rarely look int
drivers/${PLATFORM} type directories unless I'm doing a tree-wide
grep. :-)

Later,
David S. Miller
davem@redhat.com
