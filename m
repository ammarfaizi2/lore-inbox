Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319160AbSIDMwa>; Wed, 4 Sep 2002 08:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319161AbSIDMwa>; Wed, 4 Sep 2002 08:52:30 -0400
Received: from coruscant.franken.de ([193.174.159.226]:36511 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S319160AbSIDMw2>; Wed, 4 Sep 2002 08:52:28 -0400
Date: Wed, 4 Sep 2002 14:56:28 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
Cc: Netfilter Mailing List <netfilter-devel@lists.netfilter.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Patrick Schaaf <bof@bof.de>,
       Andreas Kleen <ak@suse.de>
Subject: Re: ip_conntrack_hash() problem
Message-ID: <20020904125628.GB1720@naboo.lincon.Uni-Koeln.DE>
References: <1031142822.3314.116.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031142822.3314.116.camel@biker.pdb.fsc.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux naboo 2.4.19-pre4-ben0
X-Date: Today is Boomtime, the 28th day of Bureaucracy in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 02:33:41PM +0200, Martin Wilck wrote:
> Hi,
> 
> I posted a patch to netfilter-devel a week ago that fixes a severe
> performance problem with ip_conntrack_hash() (see below).
> Harald rejected it (sort of), telling me I should have read past threads
> about the hash function first. 

no, I didn't reject it.  I just said you should contribute your work
with the work of the other people, so we end up having one
conntrack-optimization patch.

> Although it certainly isn't the "optimal" hash function for
> ip_conntrack, it fixes a problem that leads to extremely unbalanced
> hashing in some situations, in particular in a simple
> client<->router<->webserver scenario. 

It is an artificial case, in which you have a single client opening 
thousands of connections to a single port on a singles server.  Please 
correct me, if I misunderstood.

> This happens if the hash size is a power of 2, which is the default on
> most newer machines.

yes, this is the thing we should change right now.  All other
optimizations should be sorted out as a whole.

> The fix is rather trivial (mainly the port numbers are accounted for
> outside the ntohl() function), and therefore I'd like to ask again that
> it be applied.

Would you be satisfied with making the default hashsize no longer a
power of two?

> Unless I am mistaken, the past discussions were mainly concerned with
> fine-tuning of the hash function, which is a topic my patch doesn't
> address, and can easily be done on top of it.

no, exactly the 'power-of-two' has been discussed as well.

> Regards,
> Martin

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
