Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVDMTPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVDMTPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 15:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVDMTPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 15:15:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53172 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261225AbVDMTNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 15:13:41 -0400
Date: Wed, 13 Apr 2005 21:13:39 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>, git@vger.kernel.org
Subject: Re: Re: [ANNOUNCE] git-pasky-0.3
Message-ID: <20050413191339.GD25711@pasky.ji.cz>
References: <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz> <20050413103521.D1798@flint.arm.linux.org.uk> <20050413200307.B19329@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413200307.B19329@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Wed, Apr 13, 2005 at 09:03:07PM CEST, I got a letter
where Russell King <rmk+lkml@arm.linux.org.uk> told me that...
> On Wed, Apr 13, 2005 at 10:35:21AM +0100, Russell King wrote:
> > I tried this today, applied my patch for BE<->LE conversions and
> > glibc-2.2 compatibility (attached, still requires cleaning though),
> > and then tried git pull.  Umm, whoops.
> 
> Here's an updated patch which allows me to work with a BE-based
> cache.  I've just used this to grab and checkout sparse.git.
> 
> Note: it also fixes my glibc-2.2 build problem with the nsec
> stat64 structures (see read-cache.c).
> 
> --- cache.h
> +++ cache.h	Wed Apr 13 11:23:39 2005
> @@ -14,6 +14,12 @@
>  #include <openssl/sha.h>
>  #include <zlib.h>
>  
> +#include <netinet/in.h>
> +#define cpu_to_beuint(x)	(htonl(x))
> +#define beuint_to_cpu(x)	(ntohl(x))
> +#define cpu_to_beushort(x)	(htons(x))
> +#define beushort_to_cpu(x)	(ntohs(x))
> +
>  /*
>   * Basic data structures for the directory cache
>   *

What do the wrapper macros gain us?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
