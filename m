Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319156AbSIDM1t>; Wed, 4 Sep 2002 08:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319158AbSIDM1s>; Wed, 4 Sep 2002 08:27:48 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:55737 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S319156AbSIDM1p>; Wed, 4 Sep 2002 08:27:45 -0400
Subject: ip_conntrack_hash() problem
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: Netfilter Mailing List <netfilter-devel@lists.netfilter.org>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Patrick Schaaf <bof@bof.de>,
       Harald Welte <laforge@gnumonks.org>, Andreas Kleen <ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Sep 2002 14:33:41 +0200
Message-Id: <1031142822.3314.116.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I posted a patch to netfilter-devel a week ago that fixes a severe
performance problem with ip_conntrack_hash() (see below).
Harald rejected it (sort of), telling me I should have read past threads
about the hash function first. 

http://marc.theaimsgroup.com/?l=netfilter-devel&m=103054090215896&w=2

I think I have to insist on this, though.

Although it certainly isn't the "optimal" hash function for
ip_conntrack, it fixes a problem that leads to extremely unbalanced
hashing in some situations, in particular in a simple
client<->router<->webserver scenario. 

In that case, all connection tuples from server to client, i.e. 50% of
all tuples, end up in the same bucket(!), as I showed in my posting to
netfilter-devel.

This happens if the hash size is a power of 2, which is the default on
most newer machines.

The fix is rather trivial (mainly the port numbers are accounted for
outside the ntohl() function), and therefore I'd like to ask again that
it be applied.

Unless I am mistaken, the past discussions were mainly concerned with
fine-tuning of the hash function, which is a topic my patch doesn't
address, and can easily be done on top of it.

Regards,
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





