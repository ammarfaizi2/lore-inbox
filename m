Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319089AbSIDNet>; Wed, 4 Sep 2002 09:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319135AbSIDNet>; Wed, 4 Sep 2002 09:34:49 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:43473 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S319089AbSIDNes>; Wed, 4 Sep 2002 09:34:48 -0400
Subject: Re: ip_conntrack_hash() problem
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: Harald Welte <laforge@gnumonks.org>
Cc: Netfilter Mailing List <netfilter-devel@lists.netfilter.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Patrick Schaaf <bof@bof.de>,
       Andreas Kleen <ak@suse.de>
In-Reply-To: <20020904125628.GB1720@naboo.lincon.Uni-Koeln.DE>
References: <1031142822.3314.116.camel@biker.pdb.fsc.net> 
	<20020904125628.GB1720@naboo.lincon.Uni-Koeln.DE>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Sep 2002 15:40:51 +0200
Message-Id: <1031146851.3314.139.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to make my previous statement clearer:

I think there's nothing wrong with a power-of-2 hashsize, as long as the
hash function contains no implicit or explicit multipliers that are also
powers of two. In general, multipliers should not have a greatest common
divisor (GCD) larger than 1 with the hash size. Unfortunately, in the
current implementation, ntohl() creates an implicit multiplier of 2^16
for the port numbers (on little-endian machines).

Martin

PS: For the sake of that, the patch also changed the multiplier for the
source port from 2 to 7, assuming that it's relatively unlikely to have
a hash size that is a multiple of 7, and knowing that  multiplying by 7
is cheap. Instead of 7, 31 or 127 also seem good candidates that are
even more unlikely to be divisors of the hash size.

I recommend to printk() a warning if the hash size turns out to have a
GCD >1 with multiple of any multiplier in the hash function.

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





