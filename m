Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319166AbSIDNSW>; Wed, 4 Sep 2002 09:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319167AbSIDNSW>; Wed, 4 Sep 2002 09:18:22 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:460 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S319166AbSIDNSU>; Wed, 4 Sep 2002 09:18:20 -0400
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
Date: 04 Sep 2002 15:24:12 +0200
Message-Id: <1031145854.3359.125.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mit, 2002-09-04 um 14.56 schrieb Harald Welte:

> It is an artificial case, in which you have a single client opening 
> thousands of connections to a single port on a singles server.  Please 
> correct me, if I misunderstood.

As I stated before, yes, it's artificial, but it is easy to come up with
real-world scenarios that come close. (proxy<->router<->webserver).

> > The fix is rather trivial (mainly the port numbers are accounted for
> > outside the ntohl() function), and therefore I'd like to ask again that
> > it be applied.
> 
> Would you be satisfied with making the default hashsize no longer a
> power of two?

I don't know. After all, users expect that if they set hashsize=4096,
the hashsize will be 4096. It should be possible to use that setting
without suffering extreme performance losses. IMO the right thing for
now is take the port numbers out of the ntohl() function.

> > Unless I am mistaken, the past discussions were mainly concerned with
> > fine-tuning of the hash function, which is a topic my patch doesn't
> > address, and can easily be done on top of it.
> 
> no, exactly the 'power-of-two' has been discussed as well.

Right. But as stated above, making certain hash sizes impossible would
change the usage. Are we sure that there are no user-space tools out
there that rely on the hashsize being equal to what they specify when
the module is loaded?

I think the hash function should be fixed, not the possible choice of
hash sizes, if that is at feasible.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





