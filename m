Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269311AbUINOOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269311AbUINOOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 10:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269317AbUINOOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:14:40 -0400
Received: from [63.81.117.10] ([63.81.117.10]:28204 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S269311AbUINOOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:14:38 -0400
Message-ID: <4146FC39.40104@xfs.org>
Date: Tue, 14 Sep 2004 09:12:09 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alistair@devzero.co.uk
CC: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Copying huge amount of data on ReiserFS, XFS and Silicon Image
 3112 cause oops.
References: <414622C9.1030701@post.pl> <20040914081440.GC5083@frodo> <200409141159.54889.alistair@devzero.co.uk>
In-Reply-To: <200409141159.54889.alistair@devzero.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Sep 2004 14:14:37.0836 (UTC) FILETIME=[2B1494C0:01C49A65]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Tuesday 14 September 2004 09:14, you wrote:
> 
>>
>>Was 4KSTACKS enabled in those kernels (I think so)? - XFS
>>has one known problem with that option when running low on
>>space (patch fixing that is being tested atm) and I think
>>the reiserfs folks had some 4k stack issues as well at one
>>point, so that might be another explanation.
>>
> 
> 
> Just out of interest, how low is "low space"? I've got a few machines I can't 
> reboot running XFS+4K stacks; no problems so far but I'd like to sidestep 
> them if possible.
> 

You would need to be within the size of the physical memory of your
box to having a full filesystem - as a very rough approximation. So 1Gbyte
memory, 1 Gbyte disk free. There is a path when XFS is attempting to
free up pre-reserved disk space to make room for a new write, it
does this by flushing data out to disk. This means it has to work
out where it is physically going to go, which usually results in it
taking less metadata space to reference the data than the worst case
estimate it previously made. For lots of cases this probably still
does not overflow the stack, but if you add in drivers like lvm
and md and a complex scsi driver it probably pushes you over the
limit.

In general though, I would rebuild without the 4K stacks and at least
have the kernel ready for a convenient reboot.

Steve
