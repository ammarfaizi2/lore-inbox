Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWGENAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWGENAU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 09:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWGENAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 09:00:19 -0400
Received: from mail.fieldses.org ([66.93.2.214]:2010 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S964788AbWGENAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 09:00:19 -0400
Date: Wed, 5 Jul 2006 08:59:57 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
Message-ID: <20060705125956.GA529@fieldses.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ABAF7D.8010200@tmr.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 08:24:29AM -0400, Bill Davidsen wrote:
> Theodore Tso wrote:
> >Some of the ideas which have been tossed about include:
> >
> >	* nanosecond timestamps, and support for time beyond the 2038
> 
> The 2nd one is probably more urgent than the first. I can see a general 
> benefit from timestamp in ms, beyond that seems to be a specialty 
> requirement best provided at the application level rather than the bits 
> of a trillion inodes which need no such thing.

What's urgently needed for NFS (and I suspect for most other
applications demanding higher timestamps) isn't really nanosecond
precision so much as something that's guaranteed to increase whenever
the file changes.

Of course, just adding space in the inodes for nanoseconds isn't
sufficient.  XFS, for example, has nanosecond timestamps, but it's still
easy to modify a file twice without seeing the ctime or mtime change.
So either we need a timesource guaranteed to tick faster than the kernel
can process IO, or we have to be willing to, say, add 1 to the
nanoseconds field whenever the time doesn't change between operations.

Or we could add an entirely separate attribute that's guaranteed to
increase whenever the ctime is updated, and that doesn't necessarily
have any connection with time--call it a version number or something.

--b.
