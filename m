Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVKLLNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVKLLNi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 06:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVKLLNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 06:13:38 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:63457 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932310AbVKLLNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 06:13:37 -0500
Date: Sat, 12 Nov 2005 03:13:20 -0800
From: Paul Jackson <pj@sgi.com>
To: Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Some debugging patches on top of -mm
Message-Id: <20051112031320.40543ae4.pj@sgi.com>
In-Reply-To: <20050905195001.GA10223@localhost.localdomain>
References: <20050905195001.GA10223@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander,

This patch, known as page-owner-tracking-leak-detector.patch has
apparently been sitting in Andrew's *-mm for the last two months.

I just noticed it now, when reading mm/page_alloc.c.

I'd like to know if the #ifdef's and CONFIG_PAGE_OWNER specific code
can be removed from page_alloc.c, and put in a header file.  Ideally,
you patch would add just one line to the __alloc_pages() code - a call
to set_page_owner() that either became no code (a static inline empty
function) or a call to your code, if this feature was CONFIG enabled.

The *.c files are where all the logic comes together, and it is vital
to the long term readability of these files that we avoid #ifdef's in
these files.  Any one feature can be ifdef'd in, with seeming little
harm to the readability of the code (especially in the eyes of the
author of that particular bit of ifdef'd code ;).  But imagine what
a deity-awful mess these files would be if we had all been doing that
over the years with our various favorite features.

I am not sure which header file - quite possibly in a new header
file just for this feature (unless others have the good sense to
recommend better.)  Static inline code that is only called from
one place should work fine in a header file, at least technically.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
