Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263256AbTJPXMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 19:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTJPXMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 19:12:42 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:57350 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263256AbTJPXMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 19:12:40 -0400
Date: Thu, 16 Oct 2003 16:12:35 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031016231235.GB29279@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <3F8ECA3E.4030208@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8ECA3E.4030208@draigBrady.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This Outlook installation has been found to be susceptible to misuse.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 05:41:34PM +0100, P@draigBrady.com wrote:
> Andrea Arcangeli wrote:
> >Hi Jeff,
> >
> >On Wed, Oct 15, 2003 at 11:13:27AM -0400, Jeff Garzik wrote:
> >
> >>Josh and others should take a look at Plan9's venti file storage method 
> >>-- archival storage is a series of unordered blocks, all of which are 
> >>indexed by the sha1 hash of their contents.  This magically coalesces 
> >>all duplicate blocks by its very nature, including the loooooong runs of 
> >>zeroes that you'll find in many filesystems.  I bet savings on "all 
> >>bytes in this block are zero" are worth a bunch right there.
> >
> >I had a few ideas on the above.
> >
> >if the zero blocks are the problem, there's a tool called zum that nukes
> >them and replaces them with holes. I use it sometime, example:
> 
> Yes post processing with this tool is useful.
> Also note gnu cp (--sparse) inserts holes
> in files also.

As does cpio, rsync and many other archiving and data
transfer utilities.

> I thought a bit about this also and thought
> that in general the overhead of instant block/file
> duplicate merging is not worth it. Periodic
> post processing with a merging tool is
> much more efficient IMHO. Of course this is
> now only possible at the file level, but this
> is all that generally useful I think. I guess
> it's appropriate to plug my merging tool here :-)
> http://www.pixelbeat.org/fslint

What might be worth considering is internal NUL detection.
Build the block-of-zeros detection into the filesystem
write resulting in automatic creation of sparse files.
This could even work with extent based filesystems where
using hashes to identify shared blocks would not.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
