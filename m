Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264323AbTKZUJd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTKZUJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:09:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16607 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264323AbTKZUJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:09:25 -0500
To: torvalds@osdl.org
Cc: pavel@suse.cz, axboe@suse.de, bug-binutils@gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: ionice kills vanilla 2.6.0-test9 was [Re: [PATCH] cfq + io
 priorities (fwd)]
References: <Pine.LNX.4.44.0311211455510.13789-100000@home.osdl.org>
From: Nick Clifton <nickc@redhat.com>
Date: Wed, 26 Nov 2003 20:06:00 +0000
In-Reply-To: <Pine.LNX.4.44.0311211455510.13789-100000@home.osdl.org> (Linus
 Torvalds's message of "Fri, 21 Nov 2003 15:05:23 -0800 (PST)")
Message-ID: <m3ptfehp3r.fsf@redhat.com>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> You can trivially see if with a simple assembly file like
>
> 	start:
> 		.long 1,2,3,a
> 	a=(.-start)/4
>
> where 2.13.90 as shipped by SuSE will get it right (and generate a
> list of 1,2,3,4), while 2.14.90 from Fedora core will generate
> 1,2,3,16.

It appears that the 2.14.90.0.6 release of binutils used with the
Fedora code needs the patch below applied.  This patch has been
committed to the 2_14 branch and the mainline binutils sources.

Cheers
        Nick Clifton
        Binutils Maintainer

-----------------------------------------------------------------------
gas/ChangeLog
2003-04-30  Alan Modra  <amodra@bigpond.net.au>

	* app.c (do_scrub_chars): Revert 2003-04-23 and 2003-04-22 changes.

Index: gas/app.c
===================================================================
RCS file: /repositories/repositories/sourceware/src/gas/app.c,v
retrieving revision 1.23
diff -c -3 -p -r1.23 app.c
*** gas/app.c	23 Apr 2003 17:51:41 -0000	1.23
--- gas/app.c	26 Nov 2003 20:02:32 -0000
*************** do_scrub_chars (get, tostart, tolen)
*** 1294,1300 ****
  	    }
  	  else if (state == 1)
  	    {
- 	      if (IS_SYMBOL_COMPONENT (ch))
  		state = 2;	/* Ditto.  */
  	    }
  	  else if (state == 9)
--- 1294,1299 ----

