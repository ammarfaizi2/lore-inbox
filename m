Return-Path: <linux-kernel-owner+w=401wt.eu-S1030356AbWL3WmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbWL3WmO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 17:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWL3WmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 17:42:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:12745 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030356AbWL3WmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 17:42:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=krYhyY3ZtrHmr3EiYM+wvOtF9iKAwA+XFC6WIofWB4ilPuFkQcZ4IEJHrtR8lupyR2nGfCINbUuTr0r1ZkGgCuuSeWusQfS1CzCL3Gzm7AXH+vmP+l3BdFSygJjGtTvE5BKwtwz6X1DTi9FKmgV9UU7HUKgUT7Z0LKlmIejB58I=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
Date: Sat, 30 Dec 2006 23:40:57 +0100
User-Agent: KMail/1.8.2
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain> <200612302149.35752.vda.linux@googlemail.com> <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612302340.57337.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 December 2006 23:08, Robert P. J. Day wrote:
> >
> > clear_page assumes that given address is page aligned, I think. It
> > may fail if you feed it with misaligned region's address.
> 
> i don't see how that can be true, given that most of the definitions
> of the clear_page() macro are simply invocations of memset().  see for
> yourself:
> 
>   $ grep -r "#define clear_page" include
> 
> my only point here was that lots of code seems to be calling memset()
> when it would be clearer to invoke clear_page().  but there's still
> something a bit curious happening here.  i'll poke around a bit more
> before i ask, though.

There are MMX implementations of clear_page().

I was experimenting with SSE[2] clear_page() which uses
non-temporal stores. That one requires 16 byte alignment.

BTW, it worked ~300% faster than memset. But Andi Kleen
insists that cache eviction caused by NT stores will make it
slower in macrobenchmark.

Apart from fairly extensive set of microbechmarks
I tested kernel compiles (i.e. "real world load")
and they are FASTER too, not slower, but Andi
is fairly entrenched in his opinion ;)
I gave up.
--
vda
