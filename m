Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbTK3K5B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 05:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbTK3K5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 05:57:01 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:14285 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S264890AbTK3K45 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 05:56:57 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2.6]: IPv4: strcpy -> strlcpy
Date: Sun, 30 Nov 2003 11:26:22 +0100
User-Agent: KMail/1.5.4
Cc: Timo Kamph <timo@kamph.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, davem@redhat.com
References: <20031127142125.GG8276@jdj5.mit.edu> <1069970946.2138.13.camel@teapot.felipe-alfaro.com> <1070012538.10048.13.camel@hades.cambridge.redhat.com>
In-Reply-To: <1070012538.10048.13.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311301126.24035.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 28 November 2003 10:42, David Woodhouse wrote:
> On Thu, 2003-11-27 at 23:09 +0100, Felipe Alfaro Solana wrote:
> > On Thu, 2003-11-27 at 21:48, Timo Kamph wrote:
> > > > +	strlcpy(label->label, name, sizeof(label->name));
> > >
> > >                                                                       
> > > ^^^^^^ I guess this shoud be label->label, or am I wrong?
> >
> > Oh my god! Two consecutive mistakes with the same patch! I should have
> > some sleep... Here's the one with the typo corrected.
>
> Perhaps we should consider
>
> #define strsizecpy(x, y) strlcpy((x), (y), sizeof(x))

Then we should do:

#define strsizecpy(x, y) strlcpy(x, y, sizeof(x)/sizeof(x[0]))

to rule out passing the wrong variables or dereferencing to much.

Unfortunatly there is no simple way in C to differentiate between array and
pointer.

There is a way with typeof, but that is hackish.


Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/ycXOU56oYWuOrkARAiJ8AJ9wkl1ijJVn5M+lGhUwSwWRxzxxHwCg2nAU
t+9HdAasQDZo/GQFuj9s5ZU=
=py/4
-----END PGP SIGNATURE-----

