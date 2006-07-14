Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422753AbWGNUG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422753AbWGNUG0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 16:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422745AbWGNUGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 16:06:25 -0400
Received: from codepoet.org ([166.70.99.138]:49843 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1422753AbWGNUGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 16:06:24 -0400
Date: Fri, 14 Jul 2006 14:06:24 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jim Gifford <maillist@jg555.com>
Cc: David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
       ralf@linux-mips.org
Subject: Re: 2.6.18 Headers - Long
Message-ID: <20060714200623.GA25631@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Jim Gifford <maillist@jg555.com>,
	David Woodhouse <dwmw2@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org
References: <44B443D2.4070600@jg555.com> <1152836749.31372.36.camel@shinybook.infradead.org> <44B6FEDE.4040505@jg555.com> <1152903332.3191.87.camel@pmac.infradead.org> <44B7F062.8040102@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B7F062.8040102@jg555.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jul 14, 2006 at 12:28:34PM -0700, Jim Gifford wrote:
> Unfortunately, a lot programs out there are using page.h, and a lot of 
> people are using that in their programs. The 2 program I know for sure 
> that use page.h are glibc and util-linux.

util-linux should be using getpagesize() or sysconf(_SC_PAGESIZE)
from the C library.  And libc should be getting the page size
within ldso (or _start for static apps) by parsing the AT_PAGESZ
entry from the ELF auxiliary vector.  Should that be 0 (i.e.
because the kernel is horribly broken) then and only then should
libc fall back to guessing, i.e. a page size of 4k.  A quick check
shows that glibc, uClibc, and klibc all get this right.  But you
are right, that util-linux looks to have this wrong in a few
places.  I expect fixing the kernel headers will get that fixed
in short order.  :-)

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
