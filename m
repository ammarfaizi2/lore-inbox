Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161112AbVKDChO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161112AbVKDChO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 21:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161116AbVKDChO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 21:37:14 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:51718 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1161115AbVKDChM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 21:37:12 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: herbert@13thfloor.at (Herbert Poetzl)
Subject: Re: do_sendfile ppos check ...
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20051103175642.GB18015@MAIL.13thfloor.at>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EXrRU-0006eK-00@gondolin.me.apana.org.au>
Date: Fri, 04 Nov 2005 13:36:36 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> wrote:
> 
> which passes ppos as NULL, which in turn leads to an oops ...

But do_sendfile will set ppos to &in_file->f_pos if it's NULL.
Why isn't that working?

> @@ -731,7 +731,8 @@ asmlinkage ssize_t sys_sendfile(int out_
>                return ret;
>        }
> 
> -       return do_sendfile(out_fd, in_fd, NULL, count, 0);
> +       pos = 0;
> +       return do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
> }

The last argument is meant to be zero if you check the history.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
