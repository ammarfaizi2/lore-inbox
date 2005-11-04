Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161125AbVKDDRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbVKDDRD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 22:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161123AbVKDDRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 22:17:03 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:60166 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1161125AbVKDDRB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 22:17:01 -0500
Date: Fri, 4 Nov 2005 14:16:49 +1100
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: do_sendfile ppos check ...
Message-ID: <20051104031649.GA25858@gondor.apana.org.au>
References: <20051103175642.GB18015@MAIL.13thfloor.at> <E1EXrRU-0006eK-00@gondolin.me.apana.org.au> <20051104031012.GD22020@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104031012.GD22020@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 04:10:13AM +0100, Herbert Poetzl wrote:
> 
> currently investigating ... probably a removal of
> the 'unnecessary' check (*ppos) would be a better
> approach, something like:
> 
> --- linux-2.6/fs/read_write.c   2005-10-28 23:59:02.000000000 +0200
> +++ linux-2.6/fs/read_write.c   2005-11-03 17:28:50.000000000 +0100
> @@ -719,9 +719,6 @@
>        	current->syscr++;
>        	current->syscw++;
> 
> -       if (*ppos > max)
> -               retval = -EOVERFLOW;
> -

This still doesn't make sense.  If ppos came in as NULL, it should
have become non-NULL long before it reaches this part of the function.

Look at the top of the do_sendfile function, it sets ppos if it is NULL.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
