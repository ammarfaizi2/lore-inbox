Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317571AbSFRTob>; Tue, 18 Jun 2002 15:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317577AbSFRToa>; Tue, 18 Jun 2002 15:44:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22789 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317571AbSFRTo3>;
	Tue, 18 Jun 2002 15:44:29 -0400
Message-ID: <3D0F8D40.2FC13433@zip.com.au>
Date: Tue, 18 Jun 2002 12:42:58 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
References: <200205241004.g4OA4Ul28364@mail.pronto.tv> <1572079531.1022225730@[10.10.2.3]> <3CEE954F.9CB99816@zip.com.au> <200206181326.27860.roy@karlsbakk.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> > > > Any plans to merge this into the main kernel, giving a choice
> > > > (in config or /proc) to enable this?
> > >
> > > I don't think Andrew is ready to submit this yet ... before anything
> > > gets merged back, it'd be very worthwhile testing the relative
> > > performance of both solutions ... the more testers we have the
> > > better ;-)
> >
> > Cripes no.  It's pretty experimental.  Andrea spotted a bug, too.  Fixed
> > version is below.
> 
> Any more plans?
> The patch has been working great for some time now, and I'd really like to see
> this in the official tree

Roy, all we know is that "nuke-buffers stops your machine from locking up".
But we don't know why your machine locks up in the first place.  This just
isn't sufficient grounds to apply it!  We need to know exactly why your
kernel is failing.  We don't know what the bug is.

You have two gigabytes of RAM, yes?  It's very weird that stripping buffers
prevents a lockup on a machine with such a small highmem/lowmem ratio.

I'll have yet another shot at reproducing it.  So, again, could you please
tell me *exactly*, in great deatail, what I need to do to reproduce this
problem?

- memory size
- number of CPUs
- IO system
- kernel version, any applied patches, compiler version
- exact sequence of commands
- anything else you can think of

Have you been able to reproduce the failure on any other machine?

> Also - I guess this patch will eliminate any
> caching whatsoever, and therefore not really a good thing for file or web
> servers?

No, not at all.  All the pagecache is still there - the patch just
throws away the buffer_heads which are attached to those pagecache
pages.

The 2.5 kernel does it tons better.  Have you tried it?

-
