Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283658AbRK3OAf>; Fri, 30 Nov 2001 09:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283659AbRK3OAP>; Fri, 30 Nov 2001 09:00:15 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:50962 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S283658AbRK3OAG>; Fri, 30 Nov 2001 09:00:06 -0500
Message-ID: <3C0790A4.4009C357@idb.hist.no>
Date: Fri, 30 Nov 2001 14:59:00 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.1-pre1 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: war war <war@starband.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.16 & Heavy I/O
In-Reply-To: <B7F1F9B7DE30EDF47ADB4F8F44CAC84B@war.starband.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

war war wrote:
> 
> Issue:
> 
> Is it possible to set the disk cache size to a higher value to avoid
> temporary freezing while untarring large files?  Memory is not an
> issue, I have plenty of it.  

Absolutely all free memory may be used for disk caching.  So
no, you can't get a bigger cache because it is already at
the highest possible setting.  You don't have more memory
for this - all is used already.

> The disk drive is a good drive, does
> 29.2MB/s sustained in single user mode, 25MB/s when I have a lot of
> processes open.  Here is what I think is going on.  Sometimes, when I
> untar things, or do things that consume a lot of disk space rapidly,
> they do it VERY quickly, and then the disk rumbles on for 5-20
> seconds after it is done.  What accounts for this?
> 
This is exactly what you should expect with lots of cache:
You run a big untar.
This is written straight to the disk cache RAM, that's why
it finishes very fast.  Because it isn't really on disk - 
it is in the cache.  
You may go on doing other work, the tar is over.  But the
data have to get to disk too, not only the cache.  That's
the rumbling you notice - stuff being written from cache
onto the disk itself.
 
> 
> In essence, the 'tar' command is finished, however, 30-60 seconds
> after it has finished, it is actually still decompressing the data to
> the file on the disk.
> 
It isn't decompressing, merely writing.  All decompressing etc.
that "tar" does is done - but the stuff went into your (big)
disk cache.  What you hear is the uncompressed stuff being
written from cache to disk.

Of course the files are instantly useable even when they aren't yet
written to disk.  This because you actually get stuff from the cache,
never from the disk itself.

> I have not tested ALL kernels for when or where this has started, but
> could someone provide a further explanation as to why the disk
> scheduluer works like this?
It always worked this way.  Forever.
 
> On Solaris, when I untar a file, the disk stops grinding when the tar
> process is finished, and the system is totally usuable.

Synchronously mounted then.  Worse performance, but safer if you
have the bad habit of turning the machine off when you
_believe_ it is finished.

You can force this behaviour under linux too - use
"sync" to force synchronization when you feel you need it.
Or mount syncrhonously - but then you take a performance
hit all the time.
 
> With Linux, when I untar the file, the system may completely lock up
> for 3-5 seconds during the duration after the initial untar (which is
> 30-60 seconds) after the untar processes has ended.

Some disk systems are cpu intensive. SCSI (or properly
tuned IDE using (u)dma and irq unmasking) is much better.

Helge Hafting
