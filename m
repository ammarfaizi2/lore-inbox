Return-Path: <linux-kernel-owner+w=401wt.eu-S1161124AbXALWLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161124AbXALWLH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbXALWLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:11:07 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:22139 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161124AbXALWLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:11:05 -0500
Message-ID: <45A80771.5000908@tls.msk.ru>
Date: Sat, 13 Jan 2007 01:10:57 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Zan Lynx <zlynx@acm.org>
CC: Chris Mason <chris.mason@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       dean gaudet <dean@arctic.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: Disk Cache, Was: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru>	 <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>	 <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org>	 <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org>	 <20070112202316.GA28400@think.oraclecorp.com> <45A7F396.4080600@tls.msk.ru>	 <45A7F4F2.2080903@tls.msk.ru>  <45A7F7A7.1080108@tls.msk.ru> <1168637967.183616.9.camel@localhost>
In-Reply-To: <1168637967.183616.9.camel@localhost>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zan Lynx wrote:
> On Sat, 2007-01-13 at 00:03 +0300, Michael Tokarev wrote:
> [snip]
>> And sure thing, withOUT O_DIRECT, the whole system is almost dead under this
>> load - because everything is thrown away from the cache, even caches of /bin
>> /usr/bin etc... ;)  (For that, fadvise() seems to help a bit, but not alot).
> 
> One thing that I've been using, and seems to work well, is a customized
> version of the readahead program several distros use during boot up.

[idea to lock some (commonly-used) cache pages in memory]

> Something like that could keep your system responsive no matter what the
> disk cache is doing otherwise.

Unfortunately it's not.  Sure, things like libc.so etc will be force-cached
and will start fast.  But not my data files and other stuff (what an
unfortunate thing: memory usually is smaller in size than disks ;)

I can do usual work without noticing something's working with the disks
intensively, doing O_DIRECT I/O.  For example, I can run large report on
a database, which requires alot of disk I/O, and run a kernel compile at
the same time.  Sure, disk access is alot slower, but disk cache helps alot,
too.  My kernel compile will not be much slower than usual.  But if I'll
turn O_DIRECT off, the compile will take ages to finish.  *And* the report
running, too!  Because the system tries hard to cache the WRONG pages!
(yes I remember fadvise &Co - which aren't used by the database(s) currently,
and quite alot of words has been said about that, too;  I also noticied it's
slower as well, at least currently.)

/mjt
