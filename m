Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318736AbSICJBS>; Tue, 3 Sep 2002 05:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318733AbSICJBS>; Tue, 3 Sep 2002 05:01:18 -0400
Received: from ns.suse.de ([213.95.15.193]:17674 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318720AbSICJBQ>;
	Tue, 3 Sep 2002 05:01:16 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       haveblue@us.ibm.com, Manand@us.ibm.com, christopher.leech@intel.com
Subject: Re: TCP Segmentation Offloading (TSO)
References: <288F9BF66CD9D5118DF400508B68C4460283E564@orsmsx113.jf.intel.com.suse.lists.linux.kernel> <200209021858.WAA00388@sex.inr.ac.ru.suse.lists.linux.kernel> <20020903.164243.21934772.taka@valinux.co.jp.suse.lists.linux.kernel> <20020903.005119.50342945.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Sep 2002 11:05:30 +0200
In-Reply-To: "David S. Miller"'s message of "3 Sep 2002 10:02:10 +0200"
Message-ID: <p73y9ajqw85.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>    From: Hirokazu Takahashi <taka@valinux.co.jp>
>    Date: Tue, 03 Sep 2002 16:42:43 +0900 (JST)
> 
>    I guess it may also depend on bad implementations of csum_partial().
>    It's wrong that some architecture assume every data in a skbuff are
>    aligned on a 2byte boundary so that it would access a byte next to
>    the the last byte where no pages might be there.
>    
> It is real requirement, x86 works because unaligned
> access is handled transparently by cpu.
> 
> But on every non-x86 csum_partial I have examined, worse than
> 2-byte aligned data start is totally not handled.  It is not difficult
> to figure out why this is the case, everyone has copied by example. :-)

x86-64 handles it (also in csum-copy). I think at least Alpha does it 
too (that is where I stole the C csum-partial base from) But it's ugly.
See the odd hack. 

-Andi
