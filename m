Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbUBVDVk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 22:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbUBVDVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 22:21:39 -0500
Received: from adsl-63-194-240-129.dsl.lsan03.pacbell.net ([63.194.240.129]:39173
	"EHLO mikef-fw.mikef-fw.matchmail.com") by vger.kernel.org with ESMTP
	id S261655AbUBVDVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 22:21:37 -0500
Message-ID: <4038203D.3090906@matchmail.com>
Date: Sat, 21 Feb 2004 19:21:33 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> 
> On Sat, 21 Feb 2004, Chris Wedgwood wrote:
> 
>>Forcing paging will push this down to acceptable levels but it's a
>>really irritating solution --- I'm still trying to think of a better
>>way to stop the dentries from using such a disproportionate amount of
>>memory.
> 
> 
> Why?
> 
> It's quite likely that especially on a fairly idle machine, the dentry 
> cache really _should_ be the biggest single memory user.
> 
> Why? Because an idle machine tends to largely be dominated by things like 
> "updatedb" and friends running. If there isn't any other real activity, 
> there's no reason for a big page cache, nor is there anything that would 
> put memory pressure on the dentries, so they grow as much as they can.
> 
> Do you see any actual bad behaviour from this?
> 
> 		Linus

Yes, see another message from me in this thread where I cat all files in 
my drive with 700MB slab (mostly dentries), and 100MB page cache after 
it's done.

Other than that the machine is idle over the weekend.  During the week 
it serves files over samba and knfsd in addition to exporting ~20 KDE 
desktops over VNC, and imap to ~4 users.  The desktops get little use at 
the moment though.

So having a small page cache should be detrimental to this machine.

http://www.matchmail.com/stats/lrrd/matchmail.com/srv-lnx2600.matchmail.com.html

The url above will show graphs for the machine in question.  But these 
graphs should be particularly interesting:

I'm swapping ocassionally, but only ~5 of the 20 KDE desktops are in use 
during the week:
http://www.matchmail.com/stats/lrrd/matchmail.com/srv-lnx2600.matchmail.com-swap.html
http://www.matchmail.com/stats/lrrd/matchmail.com/srv-lnx2600.matchmail.com-memory.html

I have a lot of open inodes, and when that goes down, so does the size 
of my slab:
http://www.matchmail.com/stats/lrrd/matchmail.com/srv-lnx2600.matchmail.com-open_inodes.html

This is to show the disk activity that should have enlarged my page cache:
http://www.matchmail.com/stats/lrrd/matchmail.com/srv-lnx2600.matchmail.com-iostat.html

Mike

