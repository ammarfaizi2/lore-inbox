Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbUK3Ubo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbUK3Ubo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 15:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbUK3Ubm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 15:31:42 -0500
Received: from box.punkt.pl ([217.8.180.66]:7685 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S262307AbUK3UbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 15:31:12 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Tue, 30 Nov 2004 21:28:53 +0100
User-Agent: KMail/1.7
Cc: David Woodhouse <dwmw2@infradead.org>, Alexandre Oliva <aoliva@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <1101837135.26071.380.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411302128.53583.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On wtorek 30 listopad 2004 19:21, Linus Torvalds wrote:
> You call _that_ specific?
>
> Hell no. You need to do it without breaking existing uses, as noted
> earlier, and it's not specific at all. "all user visible parts" is a big
> undertaking, if you can't make it smaller than that, then forget about it.
>
> Basic rule in kernel engineering: you don't just rewrite the world. You do
> it in incremental independent steps.
>
> Any mtd-specific rewrite is obviously a go.

Facts:
- current __KERNEL__ stuff is crap; just check any distro what they're using - 
either some kind of userland headers or a patched version of kernel headers
- "You don't use kernel headers in userland!!"
small print: except this, this, and that dir, which are userland friendly
That's quite schizophrenic.

Specific problems:
- glibc has a copy of eg. networking definitions (mostly lots of numbers for 
different protocols); if userland wants to use something that's not in glibc 
already, it has to include linux' headers; which more often than not causes 
conflicts with glibc
- the above problem is present in allmost all headers that have a glibc and 
linux version
- glibc uses linux headers for getting ABI stuff in... dunno... four? five 
cases? And *everything* else ends up getting duplicated.

People in this thread are trying to force you to agree to a specific location 
where stuff like the above mentioned mtd can go to and to start accepting 
patches (afaik there were a number of patches trying to introduce that 
userland dir - all of them ignored). That's (mostly) all.


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
