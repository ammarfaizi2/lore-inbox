Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130271AbRBZOeg>; Mon, 26 Feb 2001 09:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130368AbRBZOcI>; Mon, 26 Feb 2001 09:32:08 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130253AbRBZO3T>;
	Mon, 26 Feb 2001 09:29:19 -0500
Date: Mon, 26 Feb 2001 12:07:04 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Chris Mason <mason@suse.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Nick Pasich <npasich@crash.cts.com>, reiserfs-list@namesys.com
Subject: Re: [PATCH] Re: reiserfs: still problems with tail conversion
Message-ID: <20010226120704.A12809@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010225183201.D866@arthur.ubicom.tudelft.nl> <1136530000.983155244@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1136530000.983155244@tiny>; from mason@suse.com on Sun, Feb 25, 2001 at 09:40:44PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2001 at 09:40:44PM -0500, Chris Mason wrote:
> This patch should take care of the other cause for null bytes
> in small files.  It has been through a few hours of testing,
> with some of the usual load programs + Erik's code concurrently.
> 
> I'll let things run overnight to try and find more bugs.  The
> patch is against 2.4.2, and does a few things:
> 
> don't dirty the direct->indirect target until all direct items
> have been copied in.  Before it was dirtied for each direct item.
> 
> make the target up to date before dirtying (it was done after).
> 
> don't try to zero the unused part of the target until all bytes
> have been copied.  This was the big bug, it was zeroing previously
> copied bytes.
> 
> Any testing on non-production machines would be appreciated,
> I'll forward to Linus/Alan once I've gotten more feedback.

Yes, this did the trick, I can't repeat it anymore after a first run.
I'll let my code run for a couple of times to stress the system, but at
first glance the bug seems to be fixed.


Thanks for your efforts,
Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
