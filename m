Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTDOQAu (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 12:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbTDOQAu 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 12:00:50 -0400
Received: from dialup-65.156.221.203.acc50-nort-cbr.comindico.com.au ([203.221.156.65]:53513
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261710AbTDOQAt (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 12:00:49 -0400
Message-ID: <3E9C2F43.1050908@cyberone.com.au>
Date: Wed, 16 Apr 2003 02:11:47 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
CC: rwhron@earthlink.net, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: BUGed to death
References: <20030415143024.GA10117@rushmore> <20030415155708.GB17152@suse.de>
In-Reply-To: <20030415155708.GB17152@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Tue, Apr 15, 2003 at 10:30:24AM -0400, rwhron@earthlink.net wrote:
> > The patch below eliminates 4 BUG() calls that clearly 
> > cannot happen based on the context.
>
>This looks bogus.
>
> > --- linux-2.5.67-mm2/fs/reiserfs/hashes.c.orig	2003-04-15 10:11:44.000000000 -0400
> > +++ linux-2.5.67-mm2/fs/reiserfs/hashes.c	2003-04-15 10:13:43.000000000 -0400
> > @@ -90,10 +90,6 @@
> >  
> >  	if (len >= 12)
> >  	{
> > -	    	//assert(len < 16);
> > -		if (len >= 16)
> > -		    BUG();
> > -
>
>Imagine I pass in 20. Previously, the BUG triggers. Not any more.
>Ditto the other changes.  Or am _I_ missing something ?
>
Just from the context of the patch, you are right with the first
one. Subsequent bugs can be removed due to their possibility being
eliminated by previous if statements. The code suggests that
len will trivially not be >= 16 at this point, however. So the
patch is ok.

