Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWDJKRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWDJKRj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWDJKRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:17:39 -0400
Received: from alpha.polcom.net ([83.143.162.52]:33686 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1751121AbWDJKRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 06:17:38 -0400
Date: Mon, 10 Apr 2006 12:17:31 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slow swapon for big (12GB) swap
In-Reply-To: <443A0A6F.2040500@aitel.hist.no>
Message-ID: <Pine.LNX.4.63.0604101205300.31989@alpha.polcom.net>
References: <Pine.LNX.4.63.0604091338030.31989@alpha.polcom.net>
 <443A0A6F.2040500@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2006, Helge Hafting wrote:
> Grzegorz Kulewski wrote:
>
>>  Hi,
>>
>>  I am using big swap here (as a backing for potentially huge tmpfs). And I
>>  wonder why swapon on such big (like 12GB) swap takes about 7 minutes
>>  (continuous disk IO). Is this expected? Why it is like that? Can I do
>>  anything to speed it up? Or maybe remove it into the background with low
>>  priority or something like that?
>
> I don't know why it is slow.  But you can certainly do something like:
>
> nice swapon /dev/yourdisk &

I wouldn't be so sure about this because it is possible that the real work 
is done by some kernel thread not the process...


> Then it will happen in the background and with low priority.  Of course,
> you can't start filling your tmpfs until this completes.

That is no problem.


> I don't think tmpfs+swap was made with this sort of use in mind,
> so you may want to test the performance when you fill up such a
> tmpfs, and compare to the performance of /tmp on a 12GB
> ordinary filesystem.  It seems to me that the advantage of /tmp on
> tmpfs is lost completely if most of it has to be written to disk anyway.
> (Ordinary filesystems are cached too, the "tmpfs advantage" is that
> truly temporary (but possibly long-lived) files are never written
> to disk _if_ you have enough memory.  /tmp on a plain filesystem
> is just as fast due to caching, but may delay other use of the
> disk as the ordinary filesystem writes stuff out so it will be
> saved for the future.)

Well - I use it for /var/tmp for compiling packages in Gentoo. Most 
compiles use < 1MB of it and it is *much* faster that way because 
immendiate data never touch disk. And the disk stays idle the whole time 
so can be put to sleep and should live longer.

There are some compiles that take < 600MB and they are still done in RAM. 
And there are < 4 packages in this system that need extreeme amounts of 
disk (like openoffice for example). They of course are not done in RAM but 
it looks like they are still rather fast (but I don't have any 
meansurements). And the disk is still idle or nearly idle for the most 
part of these 8hs. Time shows that 6,8h is spent in userspace and I 
think it is pretty good.

So, to sum up, I need it in RAM and for the most part of the time (like 
99,99% at least) it is not filled more than 60MB. I could probably make it 
smaller and change to disk when such large package is going to be compiled 
but this will require changing Gentoo scripts or doing things manually and 
I want to avoid that.


Thanks,

Grzegorz Kulewski

