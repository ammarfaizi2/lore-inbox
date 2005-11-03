Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbVKCFv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVKCFv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 00:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVKCFv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 00:51:27 -0500
Received: from mail2.ispwest.com ([216.52.245.18]:64009 "EHLO
	ispwest-email1.mdeinc.com") by vger.kernel.org with ESMTP
	id S1750881AbVKCFv0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 00:51:26 -0500
X-Modus-BlackList: 216.52.245.25=OK;kjak@ispwest.com=OK
X-Modus-Trusted: 216.52.245.25=YES
Message-ID: <a323eed56c0f4695bec595264cddc4a2.kjak@ispwest.com>
X-EM-APIVersion: 2, 0, 1, 0
X-Priority: 3 (Normal)
Reply-To: "Kris Katterjohn" <kjak@users.sourceforge.net>
From: "Kris Katterjohn" <kjak@ispwest.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Merge __load_pointer() and load_pointer() in net/core/filter.c; kernel 2.6.14
Date: Wed, 2 Nov 2005 21:51:23 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mitchell Blank Jr
> > Kris Katterjohn wrote:
> > Forgive me because this is one of my first attempts at anything related to the
> > kernel, but...
> > 
> > 1) How would I go about benchmarking this?
> 
> The first thing to do is run "size net/core/filter.o" before and after and
> see if your change makes the "text" section larger.
> 
> The risk of putting more stuff into the inlined function is just that
> the rarely-executed path will end up duplicated in a bunch of places, bloating
> the generated code.  It's hard to directly benchmark the effects of this but
> it will generally make the fast-path code less compact in the L1 I-cache
> which (if you do it enough) slows everything down.  Thats one reason why
> kernel developers try to keep a close eye on bloat.
> 
> -Mitch


Before patch:

   text	   data	    bss	    dec	    hex	filename
   2399	      0	      0	   2399	    95f	x/net/core/filter.o

After patch:

   text	   data	    bss	    dec	    hex	filename
   2589	      0	      0	   2589	    a1d	y/net/core/filter.o

After patch without inlining the function:

   text	   data	    bss	    dec	    hex	filename
   2127	      0	      0	   2127	    84f	y/net/core/filter.o


So I guess use my patch and take "inline" off? What do you think?


Thanks


