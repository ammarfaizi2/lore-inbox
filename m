Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVDNWL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVDNWL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 18:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVDNWL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 18:11:59 -0400
Received: from pirx.hexapodia.org ([199.199.212.25]:39558 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261531AbVDNWLy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 18:11:54 -0400
Date: Thu, 14 Apr 2005 15:11:53 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Stefan Seyfried <seife@suse.de>, Herbert Xu <herbert@gondor.apana.org.au>,
       Pavel Machek <pavel@ucw.cz>, Andreas Steinmetz <ast@domdv.de>,
       linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050414221153.GE27881@hexapodia.org>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <20050414065124.GA1357@elf.ucw.cz> <20050414080837.GA1264@gondor.apana.org.au> <200504141104.40389.rjw@sisk.pl> <20050414171127.GL3174@waste.org> <425EC41A.4020307@suse.de> <20050414195352.GM3174@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414195352.GM3174@waste.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 12:53:52PM -0700, Matt Mackall wrote:
> On Thu, Apr 14, 2005 at 09:27:22PM +0200, Stefan Seyfried wrote:
> > Matt Mackall wrote:
> > > Any sensible solution here is going to require remembering passwords.
> > > And arguably anywhere the user needs encrypted suspend, they'll want
> > > encrypted swap as well.
> > 
> > But after entering the password and resuming, the encrypted swap is
> > accessible again and my ssh-key may be lying around in it, right?
> 
> No. Because it's been zeroed in the resume process.

Zeroing the entire swsusp region is a big job, especially if you want to
do it in a FIPS-conformant manner.  Hard to test that you've done it
right and not missed any bits.

Much much easier to securely erase just the key storage.

And unless I'm missing something, you meant to say "it will have been
zeroed" (after the patch under discussion is merged), right?  The
current state of the art (as of 2.6.12-rc2) is that mlocked regions are
written to the swsusp region and may linger there indefinitely after
resume.

(I haven't read the code, that's just my understanding of the
discussion.)

> > Zeroing out the suspend image means "write lots of megabytes to the
> > disk" which takes a lot of time.
> 
> Zero only the mlocked regions. This should take essentially no time at
> all. Swsusp knows which these are because they have to be mlocked
> after resume as well. If it's not mlocked, it's liable to be swapped
> out anyway.

Ooof, that sounds complicated and error-prone, and likely to break
silently (a la input entropy gathering).

-andy
