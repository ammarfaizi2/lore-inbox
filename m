Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268152AbTBSIH5>; Wed, 19 Feb 2003 03:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268153AbTBSIH5>; Wed, 19 Feb 2003 03:07:57 -0500
Received: from ns.suse.de ([213.95.15.193]:62734 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268152AbTBSIH4>;
	Wed, 19 Feb 2003 03:07:56 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au, aeb@cwi.nl
Subject: Re: sendmsg and IP_PKTINFO
References: <15954.4693.893707.471216@notabene.cse.unsw.edu.au.suse.lists.linux.kernel> <200302181606.TAA03838@sex.inr.ac.ru.suse.lists.linux.kernel> <15954.49970.860809.75554@notabene.cse.unsw.edu.au.suse.lists.linux.kernel> <20030218.155651.108799644.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Feb 2003 09:17:58 +0100
In-Reply-To: "David S. Miller"'s message of "19 Feb 2003 01:20:15 +0100"
Message-ID: <p73wujwy98p.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> All you are showing us Neil is that the documentation
> is inaccurate.  That snippet you showed me from manual
> pages is wrong about sendmsg semantics.

Yes, it's wrong I agree. Here is a patch. Please check
and if nobody complains Andries can apply.

> 
> The ifindex you specify does mean "send out this interface".
> 
> It is very surprising that this documentation is wrong since
> the likely author (Andi Kleen) is smart enough to read the
> actual implementation when he writes these things.

There was no serious technical review of these manpages ever, so 
I wouldn't be surprised if there are more such technical errors (hint ;)

-Andi

--- ip.7~	2003-02-19 08:50:48.000000000 +0100
+++ ip.7	2003-02-19 09:09:36.000000000 +0100
@@ -260,12 +260,16 @@
 .I IP_PKTINFO 
 is passed to
 .BR sendmsg (2)
-then the outgoing packet will be sent over the interface
-specified in
-.B ipi_ifindex
-with the destination address set to
+and 
+.\" This field is grossly misnamed
 .B ipi_spec_dst
-.
+is not zero then it is used as the local source address for the routing
+table lookup and for setting up IP source route options.
+When
+.B ipi_ifindex
+is not zero the primary local address of the interface specified by the index overwrites
+.I ipi_spec_dst
+for the routing table lookup.
 
 .TP
 .B IP_RECVTOS



