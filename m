Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTDEUrg (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 15:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbTDEUrg (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 15:47:36 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:41232
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262652AbTDEUrf (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 15:47:35 -0500
Date: Sat, 5 Apr 2003 12:54:11 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: "Mudama, Eric" <eric_mudama@maxtor.com>
cc: "'Chuck Ebbert '" <76306.1226@compuserve.com>,
       "'linux-kernel '" <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: Fixes for ide-disk.c
In-Reply-To: <785F348679A4D5119A0C009027DE33C102E0D069@mcoexc04.mlm.maxtor.com>
Message-ID: <Pine.LNX.4.10.10304051227170.29290-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Apr 2003, Mudama, Eric wrote:

> In either case, according to the spec, when a FLUSH CACHE (normal or EXT,
> doesn't matter) completes with "good" status (0x50) all the write cache has
> been successfully flushed to the disk.
> 
> A 48-bit sized drive should still commit dirty data when issued the 28-bit
> FLUSH CACHE command, it will simply have problems reporting potential error
> locations if it gets a fatal error on the write.  
> 
> > You will not be allowed to push off the 48-bit feature set rules.
> > Regardless if the new smart data is set the the GPL and not Smart
> > Logs.
> 
> I don't understand what you mean.  I am looking at the ATA7 r1a spec now,
> and don't see the 48-bit specific feature set rules that you're referring to
> being "pushed off".

This is the result of a flush cache error returning a failure and the
device logging the error.  If it was a 48-bit command it should commit to
the GPL (smart extentions), otherwise a 28-bit would commit to 28-bit
smart logs.  Since the Linux does not track the returns on completion, the
report of any flush cache error is worthless.  Since the error reports the
LBA where it happened but that request is long gone, the data is toast.

It will take 2.7 or later to address the data integrity and recovery on a
device that fails completion on a flush.  This is a bad host, but the host
is getting smarter.  The difference is this host's author knows the
issues, and just needs to communicate them out.

> >If you are suggesting a pole for completion on the FLUSH, say so.
> >Otherwise, standard non-data INTQ completion is default.
> 
> Clearing of the busy bit with a status of 0x50 is what to look for.  Polled
> or INTQ doesn't matter.
> 
> If the drive reports 0x50 without a completely clean write cache, it is
> broken.

This is a DEVICE side problem, the HOST can only respond to the content
returned in the taskfiles.  The DEVICE can LIE all day long and the HOST
can only follow the lead cue from the DEVICE.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

