Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263226AbUEGHUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUEGHUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 03:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbUEGHUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 03:20:14 -0400
Received: from smtp1.BelWue.de ([129.143.2.12]:61919 "EHLO smtp1.BelWue.DE")
	by vger.kernel.org with ESMTP id S263226AbUEGHUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 03:20:06 -0400
Date: Fri, 7 May 2004 09:19:58 +0200 (CEST)
From: Oliver Tennert <tennert@science-computing.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH [NFSd] NFSv3/TCP
In-Reply-To: <16539.12572.90447.543633@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.44.0405070910440.5030-100000@picard.science-computing.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2004, Neil Brown wrote:

> On Friday May 7, tennert@science-computing.de wrote:
> > Hi Neil (and others),
> >
> > is there any reason why current 2.4 kernels do not allow for
> > NFSSVC_MAXBLKSIZE to become as large as 32k?
>
> Yes.
> At server thread creation, you need to be able to
>    kmalloc(NFSSVC_MAXBLKSIZE+1024)
> (or close to that) once per thread.  On most architectures this is a
> high-order alloc_pages and can often fail.
> Also, on every UDP write request, the server needs to 'kmalloc' a buffer
> to hold the whole request (actually on every request that is
> fragmented, but write is most common).  On most architectures, this
> kmalloc will again require allocative several contiguous pages, which
> can fail.
>
> So this patch is only safe if you have a large-patch arch or only use
> NFS over TCP.

So isn't it unsafe either with the NFSSVC_MAXBLKSIZE set to the original
8k? Or is it just less unsafe, then?

Anyway, I assure you the lockups occurred exactly when
server-side NFSv3/TCP got into the vanilla kernel at 2.4.19, and the only
significant difference I could see was this. I always used NFSv3/TCP
before then, and had no problems whatsoever. After that, I had to switch
to UDP.


>
> There was once a patch floating around which allowed a larger
> NFSSVC_MAXBLKSIZE on architectures with large page sizes, but it never
> got properly submitted I think.
>
>
> >
> > The problem is when I use NFSv3/TCP with a 2.4.25, say, on the server
> > side, as well as on the client side, I am experiencing lockups when
> > copying medium-sized or large files from the NFS fs to a local fs.
>
> There must be some other cause.  Increasing the NFSSVC_MAXBLKSIZE is
> just hiding a real problem I suspect.
>

If only the coincidence was not so clear.

Best regards and thanks

Oliver

__
________________________________________creating IT solutions

Dr. Oliver Tennert			science + computing ag
phone   +49(0)7071 9457-598		Hagellocher Weg 71-75
fax     +49(0)7071 9457-411		D-72070 Tuebingen, Germany
O.Tennert@science-computing.de		www.science-computing.de



