Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTFDPS7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 11:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbTFDPS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 11:18:59 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:28069
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263451AbTFDPS4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 11:18:56 -0400
Date: Wed, 4 Jun 2003 11:32:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Stewart Smith <stewartsmith@mac.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Stewart Smith <stewart@linux.org.au>
Subject: Re: [PATCH] fixed: CRC32=y && 8193TOO=m unresolved symbols
Message-ID: <20030604153224.GF19929@gtf.org>
References: <1054646171.17921.64.camel@passion.cambridge.redhat.com> <3D3CD66D-9651-11D7-A060-00039346F142@mac.com> <20030604152806.GE19929@gtf.org> <1054740649.17921.292.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054740649.17921.292.camel@passion.cambridge.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 04:30:49PM +0100, David Woodhouse wrote:
> On Wed, 2003-06-04 at 16:28, Jeff Garzik wrote:
> 
> > You can't EXPORT_SYMBOL from a header.
> > 
> > This sounds like Kconfig or Makefile bugs to me... all the
> > export-symbol stuff should already be in place.
> > 
> > Can you post your .config and the exact build errors you are getting?
> 
> It's because lib/crc32.o isn't actually _referenced_ by anything, hence
> isn't actually pulled into vmlinux from lib/lib.a.
> 
> My fix in the 2.4 tree is to export its symbols from kernel/ksyms.c
> #ifdef CONFIG_CRC32, and to export its symbols from lib/crc32.c 
> #ifndef CONFIG_CRC32.

That makes sense.

Any opinions on moving it out of lib/lib.a?

We have our own conditional linking system, essentially, so that's what
I would prefer.

	Jeff



