Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSIEGUA>; Thu, 5 Sep 2002 02:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317091AbSIEGUA>; Thu, 5 Sep 2002 02:20:00 -0400
Received: from bof.de ([195.4.223.10]:33428 "HELO oknodo.bof.de")
	by vger.kernel.org with SMTP id <S317073AbSIEGT6>;
	Thu, 5 Sep 2002 02:19:58 -0400
Date: Thu, 5 Sep 2002 08:21:28 +0200
From: Patrick Schaaf <bof@bof.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, Harald Welte <laforge@gnumonks.org>,
       Netfilter Mailing List <netfilter-devel@lists.netfilter.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Schaaf <bof@bof.de>
Subject: Re: ip_conntrack_hash() problem
Message-ID: <20020905082128.D19551@oknodo.bof.de>
References: <20020904152626.A11438@wotan.suse.de> <20020905044436.0772A2C0DF@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020905044436.0772A2C0DF@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Sep 05, 2002 at 10:39:40AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 10:39:40AM +1000, Rusty Russell wrote:
> In message <20020904152626.A11438@wotan.suse.de> you write:
> > > I think the hash function should be fixed, not the possible choice of
> > > hash sizes, if that is at feasible.
> > I also agree with Martin that it is better to fix the hash function in
> > this case. Restricting to magic hash table sizes looks like a bad hack.
> 
> This work is already done:
> http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Netfilter/conntrack_hashing.patch.gz

Some comments:

A) secs_between_rehash is doubled every rehash, and never decreased
   again. This looks broken. What's the rationale?
B) I despise the (1 << ...htable_bits) construct, used in several places.
   It's nothing but obfuscation. Please reinstate ...htable_size, and
   use that, the code will be more readable.
C) did you measure how much time the rehashing takes, for a single run
   on a significant (2^16 buckets, at least) conntracking table?
D) did you run your hash_conntrack() against my cttest bucket occupation
   simulator? Can we see comparing pictures?

To conclude, I agree with using a multiplicative hash, but I'm a bit nervous
about the rehashing thing. A single random hash_base call would be enough
to satisfy _my_ paranoia. IMHO the rehashing should be a compile/run time
"be more paranoid" option.

best regards
  Patrick
