Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUAJRuF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUAJRuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:50:05 -0500
Received: from intra.cyclades.com ([64.186.161.6]:41636 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265264AbUAJRuB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:50:01 -0500
Date: Sat, 10 Jan 2004 15:46:38 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: marcelo.tosatti@cyclades.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.23: user/kernel pointer bugs (drivers/char/vt.c,
 drivers/char/drm/gamma_dma.c)
In-Reply-To: <1073592494.18588.77.camel@dooby.cs.berkeley.edu>
Message-ID: <Pine.LNX.4.58L.0401101543410.4057@logos.cnet>
References: <1073592494.18588.77.camel@dooby.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Jan 2004, Robert T. Johnson wrote:

> Both of these bugs look exploitable.  The vt.c patch is
> self-explanatory.
>
> Thanks for looking at this, and let me know if you have any questions.
>
> Best,
> Rob
>
> P.S. Both of these bugs were found using the source code verification
> tool, CQual, developed by Jeff Foster, myself, and others, and available
> from http://www.cs.umd.edu/~jfoster/cqual/.
>
>
> --- drivers/char/vt.c.orig	Thu Jan  8 10:53:01 2004
> +++ drivers/char/vt.c	Wed Jan  7 15:22:17 2004
> @@ -288,7 +288,7 @@
>  	case KDGKBSENT:
>  		sz = sizeof(tmp.kb_string) - 1; /* sz should have been
>  						  a struct member */
> -		q = user_kdgkb->kb_string;
> +		q = tmp.kb_string;
>  		p = func_table[i];
>  		if(p)
>  			for ( ; *p && sz; p++, sz--)

The "q" variable is only used as an argument to put_user() (the kernel is
not reading from that address), so I think it is not a problem.

I think your patch will break the ioctl.

