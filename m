Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVEHLTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVEHLTV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 07:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVEHLTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 07:19:12 -0400
Received: from dsl-202-52-56-051.nsw.veridas.net ([202.52.56.51]:23943 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262844AbVEHLS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 07:18:59 -0400
Subject: Re: [PATCH] Really *do* nothing in while loop
From: James Purser <purserj@ksit.dynalias.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>
In-Reply-To: <427DE086.40307@tls.msk.ru>
References: <20050508093440.GA9873@cip.informatik.uni-erlangen.de>
	 <427DE086.40307@tls.msk.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115551204.3085.0.camel@kryten>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 08 May 2005 21:20:04 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-08 at 19:48, Michael Tokarev wrote:
> Thomas Glanzmann wrote:
> > [PATCH] Really *do* nothing in while loop
> > 
> > Signed-Off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
> > 
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -335,7 +335,7 @@
> >  	stream.next_in = hdr;
> >  	stream.avail_in = hdrlen;
> >  	while (deflate(&stream, 0) == Z_OK)
> > -		/* nothing */
> > +		/* nothing */;
> >  
> >  	/* Then the data itself.. */
> >  	stream.next_in = buf;
> 
> Well, the lack of semicolon is wrong really (and funny).
> 
> But is the whole while loop needed at all?  deflate()
> consumes as much input as it can, producing as much output
> as it can.  So without the loop, and without updating the
> buffer pointers ({next,avail}_{in,out}) it will do just
> fine without the loop, and will return something != Z_OK
> on next iteration.  If this is to mean to flush output,
> it should be deflate(&stream, Z_FLUSH) or something.
> 
> /mjt
> 
> P.S.  What's git@vger.kernel.org for ?
Its the mailing list for git development.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
James Purser
http://ksit.dynalias.com

