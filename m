Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbULFFM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbULFFM7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 00:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbULFFM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 00:12:59 -0500
Received: from peabody.ximian.com ([130.57.169.10]:59023 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261464AbULFFMx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 00:12:53 -0500
Subject: Re: [PATCH] Time sliced CFQ #2
From: Robert Love <rml@novell.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Con Kolivas <kernel@kolivas.org>, Jeff Sipek <jeffpc@optonline.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
In-Reply-To: <CED75073-4743-11D9-9115-000393ACC76E@mac.com>
References: <20041204104921.GC10449@suse.de>
	 <20041204163948.GA20486@optonline.net> <20041205185844.GF6430@suse.de>
	 <20041206002954.GA28205@optonline.net> <41B3BD0F.6010008@kolivas.org>
	 <20041206022338.GA5472@optonline.net> <41B3C54B.1080803@kolivas.org>
	 <CED75073-4743-11D9-9115-000393ACC76E@mac.com>
Content-Type: text/plain
Date: Mon, 06 Dec 2004 00:14:09 -0500
Message-Id: <1102310049.6052.123.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 00:00 -0500, Kyle Moffett wrote:

> What about this:
> 
> nice = x;		/* -20 to 20 */
> ioprio = y;		/* -40 to 40 */
> effective_ioprio = clamp(x+y);	/* -20 to 20 */
> 
> This would allow tuning processes for unusual contrasts with the ioprio 
> call.
> On the other hand, it would allow us to just brute force "adjust" a 
> process with
> the nice command in the usual way without any changes to the "nice" 
> source.
> 
> I also thought of a different effective ioprio calculation that scales
> instead of clamping:

I think the complication of all of this demonstrates the overcomplexity.
I think we need to either

	(1) separate the two values.  we have a scheduling
	    priority (distributing the finite resource of
	    processor time) and an I/O priority (distributing
	    the finite resource of disk bandwidth).
	(2) just have a single value.

Personally, I prefer (1).  But (2) is fine.

What we want to do either way is cleanly separate the concepts in the
kernel.  That way we can decide what we actually expose to user-space.

	Robert Love


