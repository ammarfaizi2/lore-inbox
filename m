Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262671AbVBBWcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbVBBWcR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbVBBVUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:20:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:28555 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262912AbVBBVIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:08:41 -0500
Date: Wed, 2 Feb 2005 13:08:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Lennert Van Alboom <lennert.vanalboom@ugent.be>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       alexn@dsv.su.se, kas@fi.muni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Memory leak in 2.6.11-rc1?
In-Reply-To: <1107371221.5540.81.camel@localhost>
Message-ID: <Pine.LNX.4.58.0502021138120.2362@ppc970.osdl.org>
References: <20050121161959.GO3922@fi.muni.cz>  <20050124125649.35f3dafd.akpm@osdl.org>
  <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org> 
 <200502021030.06488.lennert.vanalboom@ugent.be>  <Pine.LNX.4.58.0502020758400.2362@ppc970.osdl.org>
  <1107366560.5540.39.camel@localhost>  <Pine.LNX.4.58.0502021008350.2362@ppc970.osdl.org>
 <1107371221.5540.81.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Feb 2005, Dave Hansen wrote:
> 
> Strangely enough, it seems to be one single, persistent page.  

Ok. Almost certainly not a leak. 

It's most likely the FIFO that "init" opens (/dev/initctl). FIFO's use the 
pipe code too.

If you don't want unreclaimable highmem pages, then I suspect you just 
need to change the GFP_HIGHUSER to a GFP_USER in fs/pipe.c

		Linus
