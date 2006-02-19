Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWBSQkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWBSQkr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 11:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWBSQkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 11:40:47 -0500
Received: from ms-smtp-05-smtplb.tampabay.rr.com ([65.32.5.135]:30170 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932090AbWBSQkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 11:40:47 -0500
Message-ID: <43F89F55.5070808@cfl.rr.com>
Date: Sun, 19 Feb 2006 11:39:49 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: stern@rowland.harvard.edu, pavel@suse.cz, torvalds@osdl.org,
       mrmacman_g4@mac.com, alon.barlev@gmail.com,
       linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Re: Flames over -- Re: Which is simpler?
References: <20060217210445.GR3490@openzaurus.ucw.cz> <Pine.LNX.4.44L0.0602181531290.4115-100000@netrider.rowland.org> <20060218160242.7d2b5754.akpm@osdl.org> <43F80A06.2090209@cfl.rr.com> <20060218223221.6df891d3.akpm@osdl.org>
In-Reply-To: <20060218223221.6df891d3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>
>>  Hrm... interesting but sounds like that could be sticky.  For instance, 
>>  what if the user script that does the verifying happens to be ON the 
>>  volume to be verified?
> 
> Well that would be a bug.  Solutions would be a) don't put the scripts on a
> removable/power-downable device or b) use tmpfs.
> 

I don't see how it could be a bug, just think of the root on usb case. 
Keeping the program locked in ram would sidestep that issue, but tmpfs 
is pagable right?  Swap on usb?

Also, this user space program isn't going to be able to keep fully up to 
date on what the disk looks like.  Imagine a filesystem that keeps a 
generation counter in the super block and increments it every time it 
writes to the disk.  The user space daemon might read that, then the fs 
changes it, you suspend, and when you wake up, the daemon thinks the 
media changed because it wasn't fully up to date.

