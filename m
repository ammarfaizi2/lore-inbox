Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWFHVMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWFHVMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 17:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWFHVMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 17:12:21 -0400
Received: from server1.spsn.net ([195.234.231.102]:37869 "EHLO
	server1.spsn.net") by vger.kernel.org with ESMTP id S964975AbWFHVMU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 17:12:20 -0400
From: Sash <Sash_lkl@linuxhowtos.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Idea about a disc backed ram filesystem
Date: Thu, 8 Jun 2006 23:12:02 +0200
User-Agent: KMail/1.9.1
References: <200606082233.13720.Sash_lkl@linuxhowtos.org> <20060608204306.GA560@csclub.uwaterloo.ca>
In-Reply-To: <20060608204306.GA560@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606082312.02494.Sash_lkl@linuxhowtos.org>
X-Bogosity: Spam, tests=bogofilter, spamicity=1.000000, version=1.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thursday, 8. June 2006 22:43 schrieben Sie:
> On Thu, Jun 08, 2006 at 10:33:13PM +0200, Sascha Nitsch wrote:
> > ....
> > ....
> 
> I am a bit puzzled.  How is your idea different in use than the current
> caching system that the kernel already applies to reads of all block
> devices, other than essentially locking the cached data into ram, rather
> than letting it get kicked out if it isn't used.  Writing is similarly
> cached unless the application asks for it to not be cached.  It is
> flushed out within a certain amount of time, or when there is an idle
> period.  I fail to see where having to explicitly specify something as
> having to be cached in ram and locked in is an improvement over simply
> caching anything that is used a lot from any disk.  Your idea also
> appears to break any application that asks for sync since you take over
> control of when things are flushed to disk. 
> 
> I just don't get it. :)
> 
> Len Sorensen
> 

True, my idea is indeed similar to the existing cache, thats why I had one of the
ideas for the implementation.
If you ever had the possibility to run a database application on a tmpfs you got
to "experience" the difference :)

The idea was simply born to have a fast tmpfs but with the safety of permanent
data storage in case of reboots/crashes without user level app modification.

The problem with the current cache implementation is that I have not much
control about what keeps cached and what not. (which is fine for normal usage).

On a normal server with mixed load my database caches are flushed and
used for other stuff (like mail or webserver cache). If I access the database
files again, they have to be reloaded from disc which slows it down.
Same applies to other applications as well, this is just an example from my
daily work. (~1GB database on a 2GB ram box) and a lot of disc io because
of cache misses with a read/write ratio of ~20:1). Putting that DB into RAM is
dangerous because of the data loss risk.

The idea enables me to have a defined set of files/dirs permanently cached,
and take the choice away from the kernel (for a fixed amount of memory and files).

You are right, the idea in the current form may break application that ask for
sync. Maybe this can be honored by the implementation to access that files
directly.

If someone has a better idea to get the desired effect, feel free to post
them here.

One of the reasons I posted the idea here is to have some useful comments
from people with far more kernel/fs knowledge than I have.

I hope I could clear the clouds a bit.

Sascha Nitsch
