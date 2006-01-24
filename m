Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbWAXJKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWAXJKM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 04:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWAXJKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 04:10:11 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:47285 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1030403AbWAXJKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 04:10:09 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 24 Jan 2006 10:08:50 +0100
To: matthias.andree@gmx.de, arjan@infradead.org
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <43D5EEA2.nailCE7111GPO@burner>
References: <20060123105634.GA17439@merlin.emma.line.org>
 <1138014312.2977.37.camel@laptopd505.fenrus.org>
 <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org>
 <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org>
 <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner>
 <20060123203010.GB1820@merlin.emma.line.org>
 <1138092761.2977.32.camel@laptopd505.fenrus.org>
In-Reply-To: <1138092761.2977.32.camel@laptopd505.fenrus.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:

> > And because this requirement is not specified in the relevant standards,
> > it is wrong to assume valloc() returns locked pages. 
>
> is it? I sort of doubt that (but I'm not a standards expert, but I'd
> expect that "lock all in the future" applies to all memory, not just
> mmap'd memory

I concur:

Locking pages into core is a property/duty of the VM subsystem.
If you have an orthogonal VM subsystem, you cannot later tell how a page was 
mapped into the user's address space. Even more: you may map a file to a 
alocation in the data segment of the proces (that has been retrieved via 
malloc()/brk()) and replace the related mapping with a mapped file.

On Solaris, there is no difference.

>
> > You cannot rely on
> > mmap() returning locked pages after mlockall() either, because you might
> > be exceeding resource limits.
>
> this is true and fully correct
>
>
>
> the situation is messy; I can see some value in the hack Ted proposed to
> just bump the rlimit automatically at an mlockall-done-by-root.. but to
> be fair it's a hack :(

As all other rlimits are honored even if you are root, it looks not orthogonal 
to disregard an existing RLIMIT_MEMLOCK rlimit if you are root.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
