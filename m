Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWEBTKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWEBTKg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWEBTKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:10:36 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8428 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750714AbWEBTKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:10:36 -0400
Date: Tue, 2 May 2006 21:10:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060502191000.GA1776@elf.ucw.cz>
References: <20060502075049.GA5000@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502075049.GA5000@mail.ustc.edu.cn>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> SOC PROPOSAL
> 
> 	Rapid linux desktop startup through pre-caching

Looks nice me...

> SCHEME/GOAL
> 	2) kernel module to query the file cache
> 		- on loading: create /proc/filecache
> 		- setting up: echo "param value" > /proc/filecache
> 		- info query: cat /proc/filecache
> 		- sample sessions:
> 
> 		# modprobe filecache
> 		$ cat /proc/filecache
> 		# file ALL
> 		# mask 0
> 		#
> 		# ino	size	cached	status	refcnt	name
> 		0	2929846	3181	D	1	/dev/hda1
> 		81455	9	9	_	1	/sbin/init
> 		......
> 	
> 		$ echo "file /dev/hda1" > /proc/filecache
> 		$ cat /proc/filecache
> 		# file /dev/hda1
> 		# mask 0
> 		#
> 		# idx	len
> 		0	24
> 		48	2
> 		53	5
> 		......

Could we use this instead of blockdev freezing/big suspend image
support? It should permit us to resume quickly (with small image), and
then do readahead. ... that will give us usable machine quickly, still
very responsive desktop after resume?

								Pavel
-- 
Thanks for all the (sleeping) penguins.
