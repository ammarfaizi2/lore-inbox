Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbSKSJWL>; Tue, 19 Nov 2002 04:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSKSJWK>; Tue, 19 Nov 2002 04:22:10 -0500
Received: from web20510.mail.yahoo.com ([216.136.226.145]:27805 "HELO
	web20510.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264702AbSKSJWJ>; Tue, 19 Nov 2002 04:22:09 -0500
Message-ID: <20021119092912.39541.qmail@web20510.mail.yahoo.com>
Date: Tue, 19 Nov 2002 01:29:12 -0800 (PST)
From: vasya vasyaev <vasya197@yahoo.com>
Subject: Re: Machine's high load when HIGHMEM is enabled
To: Andrew Morton <akpm@digeo.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3DC94885.AD5B8A3B@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

Let me try to explain what is this all about...

Box has 1 GB of RAM, it's running oracle database.
After some disk activity disk cache has 400 Mb, so 600
Mb is free
Oracle is tuned for using of 800 Mb of RAM for SGA (as
shared memory segment), so Oracle needs 800 Mb of RAM
to be free before it's start, right ?
So when oracle starts it can't allocate this 800 Mb
for SGA and fails to start...
Where is a problem - in kernel which can't reduce disk
cache to allow allocating of shared memory segment or
in oracle ?

BTW, free doesn't show that shared memory is in use
when oracle is started and requested shared memory
segment is allocated (and ipcs shows it).

We need to control disk cache to reduce it as much as
possible because it's not needed for oracle, much
better is to allow oracle to control the RAM
for it's use.

As to compare, on solaris we mount ufs with
"forcedirectio" mount option, which tells not to use
disk cache.



--- Andrew Morton <akpm@digeo.com> wrote:
> >
> > How can I control amount of memory used for disk
> cache
> > in recent kernels (2.4.18, 19)?
> > ("Cached:" field in `cat /proc/meminfo`)
> > I have to be sure that free memory is not used for
> > caching of disk operations (or how many of it is
> used
> > for caching)
> 
> You have to use it for something else :)
> 
> Sorry, Linux will only leave a few megabytes of
> memory unused,
> for emergency and interrupt-time allocations.
> 
> Why is this a problem?


__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - Let the expert host your site
http://webhosting.yahoo.com
