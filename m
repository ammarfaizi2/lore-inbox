Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265548AbUGGWdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265548AbUGGWdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 18:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUGGWdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 18:33:24 -0400
Received: from kanga.kvack.org ([66.96.29.28]:27293 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S265548AbUGGWdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 18:33:23 -0400
Date: Wed, 7 Jul 2004 18:33:03 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6-bk] aio not returning error code(?)
Message-ID: <20040707223302.GA6513@kvack.org>
References: <Pine.LNX.4.60.0407071430170.28653@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0407071430170.28653@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 02:42:44PM +0100, Anton Altaparmakov wrote:
> --- bklinux-2.6/fs/aio.c	2004-07-01 11:19:35.000000000 +0100
> +++ bklinux-2.6/fs/aio.c.new	2004-07-07 14:26:19.445631304 +0100
> @@ -1086,7 +1086,7 @@ int fastcall io_submit_one(struct kioctx
>  	if (likely(-EIOCBQUEUED == ret))
>  		return 0;
>  	aio_complete(req, ret, 0);	/* will drop i/o ref to req */
> -	return 0;
> +	return ret;

That's wrong: you now get 2 results for the same operation -- an error on 
the submit, and an event with a return code.  In order for the user code 
to do the right thing, you must only get one or the other.  If io_submit 
fails for a particular iocb, there must be no event returned.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
