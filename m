Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbTIEIF7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 04:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbTIEIF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 04:05:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63056 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262255AbTIEIF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 04:05:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Paul Mackerras <paulus@samba.org>,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
References: <Pine.LNX.4.44.0309040935040.1665-100000@home.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Sep 2003 02:02:00 -0600
In-Reply-To: <Pine.LNX.4.44.0309040935040.1665-100000@home.osdl.org>
Message-ID: <m1ad9jpssn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> So clearly ioremap() has to work for other buses too.
> 
> I think that in the 2.7.x timeframe, the right thing to do is definitely:
>  - move towards using "struct resource" and "ioremap_resource()"
>  - make resource sizes potentially be larger (ie use "u64" instead of 
>    "unsigned long")
> 
> This is actually a potential issue already, with 64-bit PCI on regular 
> PC's. We don't handle it at all right now (the PCI probing will just not 
> create the resources), and nobody has complained, but clearly the 
> RightThing(tm) to do eventually is to make sure this all works cleanly.
> 
> I just don't think it's worth worrying about in 2.6.x right now, since it 
> doesn't matter for anybody. 

But it does.  There are at least some embedded ppc people who are actually
using 64bit physical addresses with a 32bit virtual address space.    

And this has come up in a few other times, as well.

A big question is how much of a problem this will be for later revs of
2.6.x.  I would even enable 64bit resources on an Opteron box and not
loose memory if I could be certain a 32bit kernel that people are
using temporarily would work.

So is there any reason to delay making resources a 64bit quantity?

Eric
