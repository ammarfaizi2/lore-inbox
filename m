Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTDDJkm (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 04:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263471AbTDDJkm (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 04:40:42 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:18083 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263441AbTDDJkf (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 04:40:35 -0500
Date: Fri, 4 Apr 2003 11:51:54 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jens Axboe <axboe@suse.de>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       arrays@hp.com, steve.cameron@hp.com
Subject: Re: [PATCH] reduce stack in cpqarray.c::ida_ioctl()
Message-ID: <20030404095154.GA29742@wohnheim.fh-wedel.de>
References: <20030403120308.620e5a14.rddunlap@osdl.org> <20030404003044.GB16832@wohnheim.fh-wedel.de> <20030404080937.GH2072@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030404080937.GH2072@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 April 2003 10:09:37 +0200, Jens Axboe wrote:
> On Fri, Apr 04 2003, Jörn Engel wrote:
> > > +		error = copy_to_user(io, my_io, sizeof(*my_io)) ? -EFAULT : 0;
> > 
> > copy_to_user returns the bytes successfully copied.
> > error is set to -EFAULT, if there was actually data transferred?
> > 
> > How about:
> > +		error = copy_to_user(io, my_io, sizeof(*my_io)) < sizeof(*my_io) ? -EFAULT : 0;
> 
> Pure nonsense! Correct logic, and much nicer to read IMO is:
> 
> 	if (copy_to_user(io, my_io, sizeof(*my_io))
> 		error = -EFAULT;

Yes, you are right. I just couldn't read inline assembler properly.

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster
