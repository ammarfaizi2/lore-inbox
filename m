Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTI2QR4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 12:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbTI2QR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 12:17:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:49624 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263172AbTI2QRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 12:17:54 -0400
Date: Mon, 29 Sep 2003 09:13:38 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Pavel Machek <pavel@ucw.cz>
cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: pm: Revert swsusp to 2.6.0-test3 
In-Reply-To: <20030928175853.GF359@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0309290902150.968-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Ok. In that case, can we remove the '#if 0' blocks entirely, or at least 
> > add a big comment on why they are there but disabled?
> 
> Like this?

Pavel, I don't even know where to begin, but I will suggest that you check 
your sources better. I did apply the patch to revert swsusp to the state 
it was in -test3. According to bitkeeper, it's ChangeSet 1.1217.3.31, 
which can be viewed here: 

http://linus.bkbits.net:8080/linux-2.5/patch@1.1217.3.31

It was merged last Thursday night, which means it should have been in 
-test5-bk13. The changelog also appeared on the bk-commits-head list. 


Next, if you're going to patch my code, do *not* do crap like this: 

> +#if 0 
> +     /* Patrick is likely to s/swsusp_/pmdisk_/ in next release,
> +        but #if 0 is needed so that this compiles. */
>       if ((error = swsusp_save()))
>               goto Done;
> 
> @@ -195,6 +198,7 @@
>       } else
>               pr_debug("PM: Image restored successfully.\n");
>       swsusp_free();
> +#endif

I asked you several weeks ago to submit a patch that simply removed the
calls to swsusp. You did not, and you choose here to simply break it, and
add a bullshit comment to it.  

If you're going to 'fix' the code, take a minute to submit a patch that
does not add #ifdef's, and with a comment that actually makes sense to
someone other than you.

And, if you're going to submit a patch, please do so against the current 
release. 


	Pat

