Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTELDsV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 23:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTELDsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 23:48:21 -0400
Received: from dp.samba.org ([66.70.73.150]:7661 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261871AbTELDsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 23:48:19 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Parse new-style boot parameters just before initcalls 
In-reply-to: Your message of "Sat, 10 May 2003 18:19:36 +0200."
             <Pine.SOL.4.30.0305101735410.20755-100000@mion.elka.pw.edu.pl> 
Date: Mon, 12 May 2003 12:05:48 +1000
Message-Id: <20030512040100.C7B972C0D7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.SOL.4.30.0305101735410.20755-100000@mion.elka.pw.edu.pl> you w
rite:
> 
> Hi,
> 
> I've redone this patch. I've tested it and works okay for me.
> It is as minimal as possible and I hope it can go in 2.5 soon.

Only one request, that you push this slightly more, and make
setup_arch() call parse_early_args().  Does that break something?

That way the arch-specific parsing in setup_arch() can be converted to
__setup (but doesn't need to be: archs can take their time).

ie. we already have two-stage parsing, it'd be nice not to make it
three.

Minor nitpick:

> @@ -241,7 +279,7 @@ static int __init unknown_bootoption(cha
>  		val[-1] = '=';
> 
>  	/* Handle obsolete-style parameters */
> -	if (obsolete_checksetup(param))
> +	if (obsolete_test_checksetup(param))
>  		return 0;
> 

Change comment to /* Ignore early params: already done in
parse_early_args */ or something, and maybe rename
obsolete_test_checksetup() to is_early_setup().

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
