Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbTJUGgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 02:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbTJUGgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 02:36:12 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:43438 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262970AbTJUGgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 02:36:08 -0400
Date: Mon, 20 Oct 2003 23:35:36 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: gwh@sgi.com, jbarnes@sgi.com, aniket_m@hotmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Patch to add support for SGI's IOC4 chipset
Message-ID: <20031021063536.GA78855@sgi.com>
References: <3F7CB4A9.3C1F1237@sgi.com> <200310071527.56813.bzolnier@elka.pw.edu.pl> <20031008033809.GA29878@sgi.com> <200310162020.51303.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310162020.51303.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 08:20:51PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> > I will be on a vacation starting tomorrow, so I won't be able to reply
> > until Oct 19th or 20th, in case there are any more issues.  Hopefully this
> > one will be okay  :-)
> 
> I think that after applying attached incremental patch it can go in.

Thanks.  I'll test this and reply with the results.

> - defining IDE_ARCH_ACK_INTR and ide_ack_intr() in sgiioc4.c is a no-op,
>   it should be done <asm/ide.h> to make it work
>   (I think the same problem is present in 2.4.x)

The definition in <include/linux/ide.h> is only used if IDE_ARCH_ACK_INTR is
not defined.  sgiioc4.c defines IDE_ARCH_ACK_INTR before including that file,
so I believe we get the definition we want without touching ide.h, don't we?

> - fix NULL pointer dereference (accessing hwif->name while hwif is NULL)
>   in sgiioc4_ide_setup_pci_device() (was this driver ever tested?)

Yes.  It may be that since name is an array, the value passed to request_region
was the offset of name in the structure.  Since that was never dereferenced,
things worked okay.  In any case, the code was obviously incorrect.

> - make config option SN2 specific
> - replace uint{8,32,64}_t by u{8,32,64}

These look fine.

I'll await a response on the IDE_ARCH_ACK_INTR issue.  Do you want me to send
another patch, or is the previous with your update sufficient?

thanks

jeremy
