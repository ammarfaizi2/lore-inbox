Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTLDCJH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 21:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTLDCJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 21:09:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:18662 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263102AbTLDCJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 21:09:01 -0500
Date: Wed, 3 Dec 2003 18:08:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
In-Reply-To: <3FCE8CF5.4030006@pobox.com>
Message-ID: <Pine.LNX.4.58.0312031807080.2055@home.osdl.org>
References: <1070485676.4855.16.camel@nucleon> <20031203214443.GA23693@wohnheim.fh-wedel.de>
 <Pine.LNX.4.58.0312031600460.2055@home.osdl.org> <3FCE8CF5.4030006@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Dec 2003, Jeff Garzik wrote:
> Linus Torvalds wrote:
> >
> > And that in turn causes problems. You get all kinds of interesting
> > deadlock schenarios when write-out requires more memory in order to
> > succeed. So you need to get careful. Reading ends up being the much easier
> > case (doesn't have the same deadlock issues _and_ you could do it in-place
> > anyway).
>
>
> FWIW zisofs and ntfs have to do this too, since X on-disk compressed
> pages must be expanded to X+Y in-memory pages...

Note how zisofs only has to handle the read-only case. cramfs does the
same.

Reading is trivially done by having a few extra buffers (either through
the buffer cache or explicit buffering).

Writing is the more interesting case. I don't know how well NTFS does in
low-memory circumstances.

(Which is by no means to say that it is somehow impossible to get right:
you just have to be careful).

		Linus
