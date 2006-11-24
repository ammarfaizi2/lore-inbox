Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966256AbWKXXIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966256AbWKXXIF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 18:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935103AbWKXXIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 18:08:05 -0500
Received: from relay.rinet.ru ([195.54.192.35]:40139 "EHLO relay.rinet.ru")
	by vger.kernel.org with ESMTP id S932502AbWKXXIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 18:08:04 -0500
Message-ID: <45677B3F.60202@mail.ru>
Date: Sat, 25 Nov 2006 02:07:43 +0300
From: Michael Raskin <a1d23ab4@mail.ru>
User-Agent: Thunderbird 2.0a1 (X11/20060809)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1+ memory problem
References: <45614A95.6090102@mail.ru> <4566F26D.2010404@mail.ru>
In-Reply-To: <4566F26D.2010404@mail.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (relay.rinet.ru [195.54.192.35]); Sat, 25 Nov 2006 02:08:02 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Raskin wrote:
> Also I have uploaded contents of /proc/page_owner after loosing more 
> than 100M. (220M used, 29M - on page_owner, lessthan 50M - for 
> processes). 

Top 3 entries:

89361 times:
Page allocated via order 0, mask 0x280d2
[0xc0159f31] __handle_mm_fault+1809
[0xc011318a] do_page_fault+314
[0xc04111c4] error_code+116
Can be anything. But if I understand anything, this memory is used 
because someone has requested a page that is swapped out. So the memory 
must be used, but not reflected in meminfo, and not by a process?


35560 times:
Page allocated via order 0, mask 0x201d2
[0xc0152ec2] __do_page_cache_readahead+450
[0xc015309a] do_page_cache_readahead+74
[0xc014d7b5] filemap_nopage+325
[0xc0159919] __handle_mm_fault+249
[0xc011318a] do_page_fault+314
[0xc04111c4] error_code+116
- is reflected in cache usage statistics, I guess..

6185 times:
Page allocated via order 0, mask 0x200d2
[0xc014e069] generic_file_buffered_write+329
[0xc014e814] __generic_file_aio_write_nolock+612
[0xc014eb85] generic_file_aio_write+85
[0xc01b26ff] ext3_file_write+63
[0xc016b23c] do_sync_write+204
[0xc016b9a7] vfs_write+167
[0xc016c2a7] sys_write+71
[0xc010303a] sysenter_past_esp+95
- negligible, really..
