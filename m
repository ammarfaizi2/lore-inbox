Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262834AbVEHJtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbVEHJtY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 05:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbVEHJtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 05:49:07 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:55388 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262834AbVEHJs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 05:48:59 -0400
Message-ID: <427DE086.40307@tls.msk.ru>
Date: Sun, 08 May 2005 13:48:54 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Cc: LKML <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>
Subject: Re: [PATCH] Really *do* nothing in while loop
References: <20050508093440.GA9873@cip.informatik.uni-erlangen.de>
In-Reply-To: <20050508093440.GA9873@cip.informatik.uni-erlangen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Glanzmann wrote:
> [PATCH] Really *do* nothing in while loop
> 
> Signed-Off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
> 
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -335,7 +335,7 @@
>  	stream.next_in = hdr;
>  	stream.avail_in = hdrlen;
>  	while (deflate(&stream, 0) == Z_OK)
> -		/* nothing */
> +		/* nothing */;
>  
>  	/* Then the data itself.. */
>  	stream.next_in = buf;

Well, the lack of semicolon is wrong really (and funny).

But is the whole while loop needed at all?  deflate()
consumes as much input as it can, producing as much output
as it can.  So without the loop, and without updating the
buffer pointers ({next,avail}_{in,out}) it will do just
fine without the loop, and will return something != Z_OK
on next iteration.  If this is to mean to flush output,
it should be deflate(&stream, Z_FLUSH) or something.

/mjt

P.S.  What's git@vger.kernel.org for ?
