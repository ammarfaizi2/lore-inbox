Return-Path: <linux-kernel-owner+w=401wt.eu-S964943AbWL1HTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWL1HTK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 02:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWL1HTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 02:19:10 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:45961 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S964943AbWL1HTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 02:19:09 -0500
Message-ID: <367290328.14058@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 28 Dec 2006 15:19:04 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drop page cache of a single file
Message-ID: <20061228071903.GA5702@mail.ustc.edu.cn>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	"Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <1167275845.15989.153.camel@ymzhang> <20061227194959.0ebce0e4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061227194959.0ebce0e4.akpm@osdl.org>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 07:49:59PM -0800, Andrew Morton wrote:
> On Thu, 28 Dec 2006 11:17:25 +0800
> "Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
> 
> > Currently, by /proc/sys/vm/drop_caches, applications could drop pagecache,
> > slab(dentries and inodes), or both, but applications couldn't choose to
> > just drop the page cache of one file. An user of VOD (Video-On-Demand)
> > needs this capability to have more detailed control on page cache release.
> 
> The posix_fadvise() system call should be used for this.  Probably in
> combination with sys_sync_file_range().

Yanmin: I've been using the fadvise tool from
http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz

It's a nice tool:

% fadvise 
Usage: fadvise filename offset length advice [loops]
      advice: normal sequential willneed noreuse dontneed asyncwrite writewait
% fadvise /var/sparse 0 0x7fffffff dontneed

Regards,
Wu
