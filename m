Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbULTRi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbULTRi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 12:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbULTRi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 12:38:26 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:52140 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261589AbULTRiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 12:38:05 -0500
Message-ID: <41C70DF2.80101@nortelnetworks.com>
Date: Mon, 20 Dec 2004 11:37:54 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Al Hooton <al@hootons.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ioctl assignment strategy?
References: <1103067067.2826.92.camel@chatsworth.hootons.org> <20041215004620.GA15850@kroah.com> <41C04FFA.6010407@nortelnetworks.com> <20041217234854.GA24506@kroah.com>
In-Reply-To: <20041217234854.GA24506@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Rethink the way you want to control your device.  Seriously, a lot of
> ioctls can be broken down into single device files, single sysfs files,
> or other such things (a whole new fs as a last resort too.)

Actually, my particular case is likely not a good example.  We've got a misc 
char driver giving access to a lot of miscellaneous features we've added to the 
kernel,.  We originally (a few years back) used new syscalls, but then we 
started supporting a bunch more arches, and having to patch all of them just to 
add syscall numbers sucked.

Some of it could easily be moved to /proc or /sys, but if you do it that way, 
how do you handle returning unusual error values?  Other stuff involves multiple 
stages of registration, then getting handles returned, and doing new calls with 
those handles.  I don't see how this would tie nicely into the read/write paradigm.

What's the big problem with ioctls anyways?  I mean, in a closed environment 
where I'm writing both the userspace and the kernelspace side of things.

Chris
