Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTDXLOW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 07:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbTDXLOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 07:14:22 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:32983 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S261631AbTDXLOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 07:14:21 -0400
Date: Thu, 24 Apr 2003 23:13:17 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Fix SWSUSP & !SWAP
In-reply-to: <20030424024613.053fbdb9.akpm@digeo.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Pavel Machek <pavel@suse.cz>, cat@zip.com.au, mbligh@aracnet.com,
       gigerstyle@gmx.ch, geert@linux-m68k.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1051182797.2250.10.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1051136725.4439.5.camel@laptop-linux> <1584040000.1051140524@flay>
 <20030423235820.GB32577@atrey.karlin.mff.cuni.cz>
 <20030423170759.2b4e6294.akpm@digeo.com> <20030424001733.GB678@zip.com.au>
 <1051143408.4305.15.camel@laptop-linux>
 <20030423173720.6cc5ee50.akpm@digeo.com> <20030424091236.GA3039@elf.ucw.cz>
 <20030424022505.5b22eeed.akpm@digeo.com> <20030424093534.GB3084@elf.ucw.cz>
 <20030424024613.053fbdb9.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-24 at 21:46, Andrew Morton wrote:
> > > Sorry, I still don't get it.  Go through the steps for me:
> > > 
> > > 1) suspend writes pages to disk
> > > 
> > > 2) machine is shutdown
> > > 
> > > 3) restart, journal replay

Corruption comes here. The journal reply tidies things up that shouldn't
be tidied up. They shouldn't be tidied up because once we reload the
image, things should be in the same state as prior to suspend. If replay
frees a block (thinking it wasn't properly linked or something similar),
it introduces corruption.

> swapfiles are not journalled - the swap a_ops write direct to the swapfile's
> blocks with submit_bio().  Journal replay wouldn't touch the swapfile.
> 
> I can see that locating the swapfile for the resume-time swapon could be a
> problem, but the corruption thing still escapes me.

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

