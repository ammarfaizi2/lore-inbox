Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbTGHDWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 23:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265009AbTGHDWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 23:22:48 -0400
Received: from stratnet.net ([12.162.17.40]:64369 "EHLO umhlanga.STRATNET.NET")
	by vger.kernel.org with ESMTP id S264929AbTGHDWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 23:22:46 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: hch@infradead.org, jmorris@intercode.com.au, TSPAT@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: crypto API and IBM z990 hardware support
References: <OF1BACB1D3.F4409038-ONC1256D57.00247A0A-C1256D57.002701D8@de.ibm.com>
	<Mutt.LNX.4.44.0307021913540.31308-100000@excalibur.intercode.com.au>
	<20030707080929.A1848@infradead.org>
	<20030707.195350.39170946.davem@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 07 Jul 2003 20:37:09 -0700
In-Reply-To: <20030707.195350.39170946.davem@redhat.com>
Message-ID: <52adbp1yfu.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Jul 2003 03:37:12.0269 (UTC) FILETIME=[37AAAFD0:01C34502]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Christoph> crypto/arch/ sounds like a bad idea.  We really should
    Christoph> avoid arch code outside arch/ and include/asm*.  So
    Christoph> arch/<foo>/crypto/ as suggested by Thomas is much
    Christoph> better.
   
    David> I totally disagree.  I think the way we do things today is
    David> _STUPID_.  We put arch code far away from the generic
    David> version which makes finding stuff very difficult for people
    David> inspecting the code for the first time.

    David> For example, the fact that I have to go groveling in
    David> arch/foo/lib/whoknowswhatfile.whoknowswhatextension to look
    David> at the memcpy/checksum/whatever implementation is
    David> completely busted.

I see your point.  Still, I think there is a lot to be said for
keeping arch code in arch/xxx and include/asm-xxx.  It means that
someone working on a new port (I don't necessarily mean a totally new
arch, but also adding support for some new CPU model or platform) has
a well-defined set of directories to look at.

It's also nice that the xxx-arch maintainers can say "we are the rulers
of arch/xxx and include/asm-xxx" and know that any changes outside of
those directories have to go through lkml.

By the way, I agree that it would be good if <asm/string.h> had
something like

        /* See arch-xxx/lib/string.S for implementation of these */

Still, I don't think I would like it if we had

        alpha/ arm/ arm26/ cris/ h8300/ i386/ ia64/ m68k/ m68knommu/
        mips/ mips64/ parisc ppc/ ppc64/ s390/ sh/ sparc/ sparc64/ um/
        v850/ x86_64/ generic/

directories scattered all over the source tree.

 - Roland
