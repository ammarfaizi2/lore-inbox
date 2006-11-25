Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967115AbWKYTEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967115AbWKYTEK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 14:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967117AbWKYTEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 14:04:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34000 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967115AbWKYTEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 14:04:08 -0500
Date: Sat, 25 Nov 2006 11:03:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Raskin <a1d23ab4@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1+ memory problem
Message-Id: <20061125110331.10f2dd42.akpm@osdl.org>
In-Reply-To: <45677B3F.60202@mail.ru>
References: <45614A95.6090102@mail.ru>
	<4566F26D.2010404@mail.ru>
	<45677B3F.60202@mail.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006 02:07:43 +0300
Michael Raskin <a1d23ab4@mail.ru> wrote:

> Michael Raskin wrote:
> > Also I have uploaded contents of /proc/page_owner after loosing more 
> > than 100M. (220M used, 29M - on page_owner, lessthan 50M - for 
> > processes). 
> 
> Top 3 entries:
> 
> 89361 times:
> Page allocated via order 0, mask 0x280d2
> [0xc0159f31] __handle_mm_fault+1809
> [0xc011318a] do_page_fault+314
> [0xc04111c4] error_code+116
> Can be anything. But if I understand anything, this memory is used 
> because someone has requested a page that is swapped out. So the memory 
> must be used, but not reflected in meminfo, and not by a process?
> 
> 
> 35560 times:
> Page allocated via order 0, mask 0x201d2
> [0xc0152ec2] __do_page_cache_readahead+450
> [0xc015309a] do_page_cache_readahead+74
> [0xc014d7b5] filemap_nopage+325
> [0xc0159919] __handle_mm_fault+249
> [0xc011318a] do_page_fault+314
> [0xc04111c4] error_code+116
> - is reflected in cache usage statistics, I guess..
> 
> 6185 times:
> Page allocated via order 0, mask 0x200d2
> [0xc014e069] generic_file_buffered_write+329
> [0xc014e814] __generic_file_aio_write_nolock+612
> [0xc014eb85] generic_file_aio_write+85
> [0xc01b26ff] ext3_file_write+63
> [0xc016b23c] do_sync_write+204
> [0xc016b9a7] vfs_write+167
> [0xc016c2a7] sys_write+71
> [0xc010303a] sysenter_past_esp+95
> - negligible, really..

What you should do is to cause the system to free as many pages as possible
before looking ad /proc/page_owner.  For example, build `usemem' from
http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz, run

	usemem -m N  (where N is the number of megabytes which the machine has)

a couple of times.  Then check /proc/meminfo, and look to see which pages
are left over in /proc/page_owner.

Thanks.
