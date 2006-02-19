Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWBSGDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWBSGDK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 01:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWBSGDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 01:03:10 -0500
Received: from ms-smtp-05-smtplb.tampabay.rr.com ([65.32.5.135]:11775 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1750965AbWBSGDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 01:03:09 -0500
Message-ID: <43F80A06.2090209@cfl.rr.com>
Date: Sun, 19 Feb 2006 01:02:46 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alan Stern <stern@rowland.harvard.edu>, pavel@suse.cz, torvalds@osdl.org,
       mrmacman_g4@mac.com, alon.barlev@gmail.com,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Re: Flames over -- Re: Which is simpler?
References: <20060217210445.GR3490@openzaurus.ucw.cz> <Pine.LNX.4.44L0.0602181531290.4115-100000@netrider.rowland.org> <20060218160242.7d2b5754.akpm@osdl.org>
In-Reply-To: <20060218160242.7d2b5754.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Correct me if I'm wrong, but this really only affects storage devices, yes?
> That narrows the scope of the problem quite some.
> 
> I suspect we could do a very good job of working out whether we're still
> talking to the same fs if filesystem drivers were to help in that.
> 

Exactly, which is why windows involves the filesystem driver.

> But I suspect we could do an even better job if we did that in userspace.
> 
> The logic to determine whether the new device is the same as the old device
> can be arbitrarily complex, with increasing levels of success.  Various
> heuristics can be applied, some of which will involve knowledge of
> filesystem layout, etc.
> 
> So would it not be possible to optionally punt the device naming decision
> up to the hotplug scripts?  So code up there can go do direct-IO reads of
> the newly-present blockdev, use filesytem layout knowledge, peek at UUIDs,
> superblocks, disk labels, partition tables, inode numbering, etc?  Go look
> up a database, work out what that filesystem was doing last time we saw it,
> etc?
> 
> We could of course add things to the filesystems to help this process, but
> it'd be good if all the state tracking and magic didn't have to be locked
> up in the kernel.


Hrm... interesting but sounds like that could be sticky.  For instance, 
what if the user script that does the verifying happens to be ON the 
volume to be verified?

I think this kind of thing is really going to have to be in kernel, like 
a remount.


