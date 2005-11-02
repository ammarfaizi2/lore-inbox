Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbVKBXLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbVKBXLJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 18:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965337AbVKBXLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 18:11:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:36030 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965336AbVKBXLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 18:11:08 -0500
Date: Thu, 3 Nov 2005 10:11:07 +1100
From: Nathan Scott <nathans@sgi.com>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS information leak during crash
Message-ID: <20051103101107.O6239737@wobbly.melbourne.sgi.com>
References: <20051102212722.GC6759@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20051102212722.GC6759@fi.muni.cz>; from kas@fi.muni.cz on Wed, Nov 02, 2005 at 10:27:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jan,

On Wed, Nov 02, 2005 at 10:27:22PM +0100, Jan Kasprzak wrote:
> 	Hello, world!\n
> 
> I have found that after the system crash (e.h. a hard reset or a power
> failure) XFS corrupts files which have been written to just before the crash:
> The result is that those files contain data from random blocks on the
> disk (e.g. from previously deleted files). This can have security/privacy
> implications - users can see the contents of other users' old files.

If you think you have found a security issue, it would be courteous
to at least discuss this with the maintainers first.  And since you
are a frequent linux-xfs list poster too, it seems a bit odd that
you're reporting this on linux-kernel instead... *shrug*, whatever.

This issue affects every filesystem, right?  Or are you claiming its
only XFS affected here?  Have you run your parallel-buffered-writers
test case on any other filesystems?  I'd be interested in the results,
in particular, with all of the data=xxx modes of other filesystems.

> either). Does XFS support a something like ext3's "data=ordered" mount
> option? 

No, it doesn't.

> Otherwise it is pretty unusable on multi-user systems.

That's a ridiculous assertion.  While this small metadata vs. buffered-
data-write window exists on _any_ filesystem not using a data=ordered/
data=journaled mode (which I believe is quite a common mode of operation
even on filesystems that offer those modes), it is impossible to exploit
this in any sane way.  You'd think people on a multi-user system might
actually notice the machine being frequently rebooted while you try to
tickle this window to get at "interesting" uninitialised freespace, no?

Having said that, a data=ordered mode for XFS would be a nice feature.
It just hasn't reached the top of our priority list, and its not been
offered up as a patch by anyone yet.  If anyone's interested in writing
this, they should coordinate with hch and myself - there's a fair bit
of I/O path work being done at the moment, which in the end will make
a data=ordered mode alot easier to implement.

cheers.

-- 
Nathan
