Return-Path: <linux-kernel-owner+w=401wt.eu-S1753084AbWL1K6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbWL1K6B (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754822AbWL1K6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:58:01 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:34753 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753084AbWL1K6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:58:00 -0500
Message-ID: <367303459.19953@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 28 Dec 2006 18:57:55 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drop page cache of a single file
Message-ID: <20061228105755.GA7152@mail.ustc.edu.cn>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	"Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <1167275845.15989.153.camel@ymzhang> <20061227194959.0ebce0e4.akpm@osdl.org> <367290328.14058@ustc.edu.cn> <20061228022926.4287ca33.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228022926.4287ca33.akpm@osdl.org>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 02:29:26AM -0800, Andrew Morton wrote:
> On Thu, 28 Dec 2006 15:19:04 +0800
> Fengguang Wu <fengguang.wu@gmail.com> wrote:
>
> > Yanmin: I've been using the fadvise tool from
> > http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz
> > 
> > It's a nice tool:
> > 
> > % fadvise 
> > Usage: fadvise filename offset length advice [loops]
> >       advice: normal sequential willneed noreuse dontneed asyncwrite writewait
> > % fadvise /var/sparse 0 0x7fffffff dontneed
> > 
> 
> I was a bit reluctant to point at that because it has nasty hacks to make
> it mostly-work on old glibc's which don't implement posix_fadvise().
> 
> Hopefully if you're running a recent distro, you have glibc support for
> fadvise() and it's possible to write a portable version of that app which
> doesn't need to know about per-arch syscall numbers.

Bad news: it's still broken. posix_fadvise() here just failed silently.
I'm running Debian Etch with libc6=2.3.6.ds1-7.
