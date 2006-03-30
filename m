Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWC3KBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWC3KBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWC3KBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:01:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64031 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932148AbWC3KBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:01:08 -0500
Date: Thu, 30 Mar 2006 12:01:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060330100111.GS13476@suse.de>
References: <20060329143758.607c1ccc.akpm@osdl.org> <20060330074534.GL13476@suse.de> <20060330000240.156f4933.akpm@osdl.org> <20060330081008.GO13476@suse.de> <20060330002726.48cf0ffb.akpm@osdl.org> <20060330085134.GP13476@suse.de> <20060330091523.GQ13476@suse.de> <20060330014024.6ada0532.akpm@osdl.org> <20060330094522.GR13476@suse.de> <20060330015630.00d8cba2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330015630.00d8cba2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > > The one-at-a-time logic looks OK from a quick scan.  Do we have logic in
> >  > there to check that we're not overrunning i_size?  (See the pain
> >  > do_generic_mapping_read() goes through).
> > 
> >  do_splice_to() checks that, should I move that checking further down in
> >  case the file is truncated?
> 
> Again, see do_generic_mapping_read()'s ghastly tricks - it checks i_size
> after each readpage().
> 
> i_size can increase or decrease under our feet if we're not holding i_mutex
> (and we don't want to).  So userspace is being silly and the main things we
> need to care about here are to not leak uninitialised data and to not oops.
> A readpage() outside i_size will return either all-zeroes or some valid
> data which isn't actually within i_size any more, so I guess we're OK.

So from the looks of things, worst case is returning zeroes if we
'raced' with someone truncating the file. I'll just leave it as-is for
now.

-- 
Jens Axboe

