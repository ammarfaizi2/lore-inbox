Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWFMEc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWFMEc7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 00:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932873AbWFMEc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 00:32:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59875 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932497AbWFMEc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 00:32:59 -0400
Date: Tue, 13 Jun 2006 14:32:31 +1000
From: Nathan Scott <nathans@sgi.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
Message-ID: <20060613143230.A867599@wobbly.melbourne.sgi.com>
References: <E1Foqjw-00010e-Ln@candygram.thunk.org> <Pine.LNX.4.61.0606101237020.23706@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0606101237020.23706@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Sat, Jun 10, 2006 at 12:48:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 12:48:27PM +0200, Jan Engelhardt wrote:
> 
> >1) Move i_blksize (optimal size for I/O, reported by the stat system
> >   call).  Is there any reason why this needs to be per-inode, instead
> >   of per-filesystem?

Sorry, missed this on the first reading - yes, there are reasons
for doing this per inode, as Jan points out...

> I do not know much about XFS's realtime feature, but from what I have read 
> about it so far, it sounds to be a potential source where i_blksize might 
> differ from the regular filesystem. A guess, though.

Such a change would would indeed break XFS, in exactly the way you
suggest Jan - the realtime subvolume does typically use a different
blocksize from the data subvolume (the realtime extent size is used,
and this can be set per-inode too), and there would now be no way to
distinguish this preferred IO size difference.

cheers.

-- 
Nathan
