Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbULFHUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbULFHUL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 02:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbULFHUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 02:20:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46245 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261258AbULFHUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 02:20:02 -0500
Date: Mon, 6 Dec 2004 08:19:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Robert Love <rml@novell.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Con Kolivas <kernel@kolivas.org>,
       Jeff Sipek <jeffpc@optonline.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time sliced CFQ #2
Message-ID: <20041206071923.GC10498@suse.de>
References: <20041204104921.GC10449@suse.de> <20041204163948.GA20486@optonline.net> <20041205185844.GF6430@suse.de> <20041206002954.GA28205@optonline.net> <41B3BD0F.6010008@kolivas.org> <20041206022338.GA5472@optonline.net> <41B3C54B.1080803@kolivas.org> <CED75073-4743-11D9-9115-000393ACC76E@mac.com> <1102310049.6052.123.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102310049.6052.123.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06 2004, Robert Love wrote:
> On Mon, 2004-12-06 at 00:00 -0500, Kyle Moffett wrote:
> 
> > What about this:
> > 
> > nice = x;		/* -20 to 20 */
> > ioprio = y;		/* -40 to 40 */
> > effective_ioprio = clamp(x+y);	/* -20 to 20 */
> > 
> > This would allow tuning processes for unusual contrasts with the ioprio 
> > call.
> > On the other hand, it would allow us to just brute force "adjust" a 
> > process with
> > the nice command in the usual way without any changes to the "nice" 
> > source.
> > 
> > I also thought of a different effective ioprio calculation that scales
> > instead of clamping:
> 
> I think the complication of all of this demonstrates the overcomplexity.
> I think we need to either
> 
> 	(1) separate the two values.  we have a scheduling
> 	    priority (distributing the finite resource of
> 	    processor time) and an I/O priority (distributing
> 	    the finite resource of disk bandwidth).
> 	(2) just have a single value.

They are inherently seperate entities, I don't think mixing them up is a
good idea. IO priorities also includes things like attempting to
guarentee disk bandwidth, it isn't always just a 'nice' value.

But lets not get carried away in a pointless discussion. The actual
setting and query interface for io priorities is by far the smallest and
least critical piece of code :-)

-- 
Jens Axboe

