Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272048AbTGYMrb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 08:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272049AbTGYMrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 08:47:31 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:7863 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S272048AbTGYMra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 08:47:30 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16161.10863.793737.229170@laputa.namesys.com>
Date: Fri, 25 Jul 2003 17:02:39 +0400
To: Daniel Egger <degger@fhm.edu>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       reiserfs mailing list <reiserfs-list@namesys.com>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
In-Reply-To: <1059093594.29239.314.camel@sonja>
References: <3F1EF7DB.2010805@namesys.com>
	<1059062380.29238.260.camel@sonja>
	<16160.4704.102110.352311@laputa.namesys.com>
	<1059093594.29239.314.camel@sonja>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger writes:
 > Am Don, 2003-07-24 um 19.07 schrieb Nikita Danilov:
 > 
 > > I don't know enough about jffs2, but you can read about reiser4's
 > > "wandering logs" and transaction manager design at the
 > > http://www.namesys.com/txn-doc.html.
 > 
 > I've read it by now, thanks for the reference.
 > 
 > > Briefly speaking, in usual WAL (write-ahead logging) transaction system,
 > > whenever block is modified, journal record, describing changes to this
 > > block is forced to the on-disk journal before modified block is allowed
 > > to be written. In the worst case this means that data are written twice.
 > 
 > Is there way to influence what is considered free space for the
 > wandering blocks or is it a fixed algorithm? If the latter, what is the
 > access pattern on the free space (like pseudorandom, cyclic linear,
 > hashed)?

No special measures are taken to level block allocation. Wandered blocks
are allocated to improve packing i.e., place blocks of the same file
close to each other. Actually, it tries to place tree nodes in the
parent-first order.

 > 
 > > I should warn everybody that reiser4 is _highly_ _experimental_ at this
 > > moment. Don't use it for production.
 > 
 > That certainly doesn't stop me from trying... :)
 > Have you ran any tests to test the durabilty of your "transcrash" system
 > for instance against sudden power dropouts?
 > Is the filesystem selfhealing or does one need fsck.reiserfs for it? If
 > the latter: will it do the right thing (i.e. automatically bring the
 > system into consistent shape not like ext3) when invoked with "-y"?

It should automatically replay journal on the mount. fsck.reiser4 is
still needed owing to the bugs in the implementation, but, I am afraid,
it cannot do much at the moment.

 > 
 > -- 
 > Servus,
 >        Daniel

Nikita.
