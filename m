Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbWECCcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWECCcI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 22:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWECCcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 22:32:07 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:909 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965071AbWECCcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 22:32:06 -0400
Message-ID: <346623523.28293@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Wed, 3 May 2006 10:32:23 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060503023223.GA5915@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
References: <20060502075049.GA5000@mail.ustc.edu.cn> <20060502191000.GA1776@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502191000.GA1776@elf.ucw.cz>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Tue, May 02, 2006 at 09:10:01PM +0200, Pavel Machek wrote:
> > SOC PROPOSAL
> > 
> > 	Rapid linux desktop startup through pre-caching
> 
> Looks nice me...

Thanks.

> > SCHEME/GOAL
> > 	2) kernel module to query the file cache
> > 		- on loading: create /proc/filecache
> > 		- setting up: echo "param value" > /proc/filecache
> > 		- info query: cat /proc/filecache
> > 		- sample sessions:
> > 
> > 		# modprobe filecache
> > 		$ cat /proc/filecache
> > 		# file ALL
> > 		# mask 0
> > 		#
> > 		# ino	size	cached	status	refcnt	name
> > 		0	2929846	3181	D	1	/dev/hda1
> > 		81455	9	9	_	1	/sbin/init
> > 		......
> > 	
> > 		$ echo "file /dev/hda1" > /proc/filecache
> > 		$ cat /proc/filecache
> > 		# file /dev/hda1
> > 		# mask 0
> > 		#
> > 		# idx	len
> > 		0	24
> > 		48	2
> > 		53	5
> > 		......
> 
> Could we use this instead of blockdev freezing/big suspend image
> support? It should permit us to resume quickly (with small image), and
> then do readahead. ... that will give us usable machine quickly, still
> very responsive desktop after resume?

Sure. Indeed I have considered about the possibility to integrate my
work with the foresighted userland-swsusp idea. The added value of
this approach is that user-land tools can do all kinds of smart
processing of the contents, and present users with different policies.

Another imagined user of /proc/filecache is system adms :)

Wu
