Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317066AbSIEGcL>; Thu, 5 Sep 2002 02:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSIEGcL>; Thu, 5 Sep 2002 02:32:11 -0400
Received: from bof.de ([195.4.223.10]:35220 "HELO oknodo.bof.de")
	by vger.kernel.org with SMTP id <S317066AbSIEGcK>;
	Thu, 5 Sep 2002 02:32:10 -0400
Date: Thu, 5 Sep 2002 08:33:40 +0200
From: Patrick Schaaf <bof@bof.de>
To: "David S. Miller" <davem@redhat.com>
Cc: bof@bof.de, rusty@rustcorp.com.au, ak@suse.de, laforge@gnumonks.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: ip_conntrack_hash() problem
Message-ID: <20020905083340.E19551@oknodo.bof.de>
References: <20020904152626.A11438@wotan.suse.de> <20020905044436.0772A2C0DF@lists.samba.org> <20020905082128.D19551@oknodo.bof.de> <20020904.232425.10994370.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020904.232425.10994370.davem@redhat.com>; from davem@redhat.com on Wed, Sep 04, 2002 at 11:24:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 11:24:25PM -0700, David S. Miller wrote:
> 
>    B) I despise the (1 << ...htable_bits) construct, used in several places.
>       It's nothing but obfuscation. Please reinstate ...htable_size, and
>       use that, the code will be more readable.
> 
> You despise, but the processor doesn't.  Less data loads
> means the code goes faster.

Please explain. I don't think that matters here:

Both _bits and _size are unsigned int, same amount of stuff to load. 

The one single per-packet-path use is in hash_conntrack(), where
the _bits thing can be used without touching the _size thing.

All other places where the patch now uses _bits, really need _size,
and do the ugly computation by shifting. And all those other places
are called very rarely.

So, I don't see how your (abstractly true) observation is relevant, here.

best regards
  Patrick
