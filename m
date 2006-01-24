Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWAXIwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWAXIwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 03:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWAXIwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 03:52:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22229 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030390AbWAXIwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 03:52:43 -0500
Subject: Re: Rationale for RLIMIT_MEMLOCK?
From: Arjan van de Ven <arjan@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060123203010.GB1820@merlin.emma.line.org>
References: <20060123105634.GA17439@merlin.emma.line.org>
	 <1138014312.2977.37.camel@laptopd505.fenrus.org>
	 <20060123165415.GA32178@merlin.emma.line.org>
	 <1138035602.2977.54.camel@laptopd505.fenrus.org>
	 <20060123180106.GA4879@merlin.emma.line.org>
	 <1138039993.2977.62.camel@laptopd505.fenrus.org>
	 <20060123185549.GA15985@merlin.emma.line.org>
	 <43D530CC.nailC4Y11KE7A@burner>
	 <20060123203010.GB1820@merlin.emma.line.org>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Jan 2006 09:52:41 +0100
Message-Id: <1138092761.2977.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> c() was the function in question.
> 
> Jörg, if we're talking about valloc(), this hasn't much to do with the
> kernel, but is a library issue.
> 
> There is _no_ documentation that says valloc() or memalign() or
> posix_memalign() is required to use mmap(). It works on some systems and
> for some allocation sizes as a side effect of the valloc()
> implementation.

it doesn't matter. Regardless of the method, the memory has to be locked
due to the FUTURE requirement.



> And because this requirement is not specified in the relevant standards,
> it is wrong to assume valloc() returns locked pages. 

is it? I sort of doubt that (but I'm not a standards expert, but I'd
expect that "lock all in the future" applies to all memory, not just
mmap'd memory

> You cannot rely on
> mmap() returning locked pages after mlockall() either, because you might
> be exceeding resource limits.

this is true and fully correct



the situation is messy; I can see some value in the hack Ted proposed to
just bump the rlimit automatically at an mlockall-done-by-root.. but to
be fair it's a hack :(


