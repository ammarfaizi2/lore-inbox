Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129938AbQKANfI>; Wed, 1 Nov 2000 08:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130296AbQKANe6>; Wed, 1 Nov 2000 08:34:58 -0500
Received: from zeus.kernel.org ([209.10.41.242]:65289 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129938AbQKANer>;
	Wed, 1 Nov 2000 08:34:47 -0500
Date: Wed, 1 Nov 2000 13:32:34 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Christoph Hellwig <hch@caldera.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        sct@redhat.com
Subject: Re: [PATCH] kiobuf/rawio fixes for 2.4.0-test10-pre6
Message-ID: <20001101133234.G1876@redhat.com>
In-Reply-To: <20001027222143.A8059@caldera.de> <200010272123.OAA21478@penguin.transmeta.com> <20001030124513.A28667@caldera.de> <39FDAD99.47FA6A54@mandrakesoft.com> <20001030191712.B27664@caldera.de> <39FDC447.C5DD7864@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <39FDC447.C5DD7864@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Oct 30, 2000 at 01:56:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 30, 2000 at 01:56:07PM -0500, Jeff Garzik wrote:
> 
> Seen it, re-read my question...
> 
> I keep seeing "audio drivers' mmap" used a specific example of a place
> that would benefit from kiobufs.  The current via audio mmap looks quite
> a bit like mmap_kiobuf and its support code... except without all the
> kiobuf overhead.
> 
> My question from above is:  how can the via audio mmap in test10-preXX
> be improved by using kiobufs?  I am not a kiobuf expert, but AFAICS a
> non-kiobuf implementation is better for audio drivers. 

Code reuse.  You may not need every single thing that the kvmap api
gives you --- for example, you may not need the per-mmap refcounting,
because you might be associating your dma buffer with the file
descriptor, not the mmap region --- but if you implement the same
nopage code in every single sound driver, then you end up with a lot
of duplication and you increase (enormously) the number of places you
have to touch if anything ever changes in the vma management code.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
