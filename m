Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319465AbSILHAT>; Thu, 12 Sep 2002 03:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319466AbSILHAT>; Thu, 12 Sep 2002 03:00:19 -0400
Received: from packet.digeo.com ([12.110.80.53]:12723 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319465AbSILHAS>;
	Thu, 12 Sep 2002 03:00:18 -0400
Message-ID: <3D804036.4C000672@digeo.com>
Date: Thu, 12 Sep 2002 00:20:22 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] sard changes for 2.5.34
References: Your message of "Wed, 11 Sep 2002 19:42:26 PDT."
	             <3D7FFF12.24B0FDAA@digeo.com> <200209120640.g8C6eTD00198@eng4.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2002 07:05:01.0575 (UTC) FILETIME=[B6708970:01C25A2A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
> 
>     kstat should be a lighter-weight per-cpu thing.  But the current
>     disk accounting in there would make it 12 kilobytes per CPU.
> 
>     My vote: remove the disk accounting from kernel_stat and use this.
> 
> I have a patch from another contributor that takes disk stats out of
> kstat and puts them into their own global structure.  I'll give that
> some attention.

OK, that's a start.  I think there was some work done on making
kernel_stat percpu as well.

Cleaning up and speeding up kernel_stat is a spearate exercise
of course, but as we need to change userspace we may as well roll
it all up together.

>     > What follows works, but needs refinements.  Comments welcome.
> 
>     What are those refinements?
> 
> A couple I mentioned in my message: double collection of stats, and an
> ugly hd_struct added to gendisk.  In addition, we should remove the
> restriction on which and how many disks are reported on.
> 
> Lastly, a bit of a philosophical question.  /proc/stat and (with this
> patch) /proc/diskstats provide some of the same information. Should
> 
>     a) all of it appear in /proc/stat?
> 
>     b) all of it appear in /proc/diskstats?
> 
>     c) keep the current (limited) info in /proc/stat (for backward
>        compatibility) and introduce the expanded info in
>        /proc/diskstats?
> 
> My preference is b, but I'm open to other opinions.

b).  Let's get the kernel right and change userspace to follow.  We have
another accounting patch which breaks top(1), so Rik has fixed it (and
is feeding the fixes upstream).

>     What userspace tools are available for interpreting this
>     information?
> 
> None that I'm aware of, although /proc/diskstats is formatted in a
> program-friendly way.  Sample output (warning: wide):

Does it work with the utilities at http://linux.inet.hr/?  What is the
relationship with the 2.4 sard work?  (I've never used sard, so words
of one syllable please ;))

If we can get this work playing nicely with those existing sard tools,
get the kernel_stat stuff cleaned up and get the relevant userspace
tools working and merged upstream then we have a neat bundle to submit.
