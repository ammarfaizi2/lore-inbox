Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262987AbVEHVnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbVEHVnY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 17:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbVEHVnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 17:43:24 -0400
Received: from smtp04.auna.com ([62.81.186.14]:4832 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S262987AbVEHVnS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 17:43:18 -0400
Date: Sun, 08 May 2005 21:43:05 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] Really *do* nothing in while loop
To: linux-kernel@vger.kernel.org
References: <20050508093440.GA9873@cip.informatik.uni-erlangen.de>
	<427DE086.40307@tls.msk.ru>
In-Reply-To: <427DE086.40307@tls.msk.ru> (from mjt@tls.msk.ru on Sun May  8
	11:48:54 2005)
X-Mailer: Balsa 2.3.1
Message-Id: <1115588585l.7394l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.08, Michael Tokarev wrote:
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

This changes the code in the corner case when deflate(...) IS NOT Z_OK
in the first iteration.
Old code: next_in is not assigned if deflate(&stream, 0) != Z_OK
New code: next_is is _always_ assigned

Other point is if old code was wrong...hidden bug ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam16 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


