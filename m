Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWEDM2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWEDM2a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 08:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWEDM2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 08:28:30 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:4546 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932277AbWEDM23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 08:28:29 -0400
Message-ID: <346745706.15764@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 4 May 2006 20:28:30 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060504122830.GA6205@mail.ustc.edu.cn>
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

On Tue, May 02, 2006 at 09:10:01PM +0200, Pavel Machek wrote:
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

Badari's usage case inspired me that on suspension we can
- first invoke a user-land tool to do all the cache
  status-logging/analyzing/selective-dropping jobs
- then let the kernel write all the remaining caches(made up of many
  small chunks) to the suspend image

And do the reverse things on restoring.
With that we moved all the strategies to userspace.

Wu
