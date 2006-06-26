Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWFZGB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWFZGB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 02:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWFZGBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 02:01:55 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:10369 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932452AbWFZGBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 02:01:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=gaN6bD4rYJNlGK8d6TjyjijfxubuoVVlWIi7l3zufFFFSDNVX/zRrFUFqDRWrNZ5tzOCKTvJd8sTk99z9fFi58Eie4wie7zI9wzEe1YHIKFXLZuMWfZIRJrl+8M3p7HH/gtasTCBfUX5Y9qTNv1hLupqA8FS5x3R/4T2Px6Heo8=  ;
Message-ID: <449F7857.4070806@yahoo.com.au>
Date: Mon, 26 Jun 2006 16:01:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Nick Piggin <npiggin@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [patch] 2.6.17: lockless pagecache
References: <20060625163930.GB3006@wotan.suse.de> <6bffcb0e0606251026gbd121dam83c1b763b8cba02d@mail.gmail.com>
In-Reply-To: <6bffcb0e0606251026gbd121dam83c1b763b8cba02d@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski wrote:
> Hi Nick,
> 
> On 25/06/06, Nick Piggin <npiggin@suse.de> wrote:
> 
>> Updated lockless pagecache patchset available here:
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.17/lockless.patch.gz 
>>
>>
> 
> "make O=/dir oldconfig" doesn't work.
> 
> [michal@ltg01-fedora linux-work]$ LANG="C" make O=../linux-work-obj/ 
> oldconfig

Hmm, I can't see how I did that.

npiggin@didi:~/x$ zcat lockless.patch.gz | diffstat
  drivers/mtd/devices/block2mtd.c |    7 -
  fs/buffer.c                     |    4
  fs/inode.c                      |    2
  include/asm-arm/cacheflush.h    |    4
  include/asm-parisc/cacheflush.h |    4
  include/linux/fs.h              |    2
  include/linux/mm.h              |    6
  include/linux/page-flags.h      |   26 ++--
  include/linux/pagemap.h         |   74 ++++++++++++
  include/linux/radix-tree.h      |   67 +++++++++++
  include/linux/swap.h            |    1
  lib/radix-tree.c                |  240 +++++++++++++++++++++++++++------------
  mm/filemap.c                    |  242 ++++++++++++++++++++++++++++++----------
  mm/hugetlb.c                    |    8 -
  mm/migrate.c                    |   21 ++-
  mm/page-writeback.c             |   40 ++----
  mm/readahead.c                  |    7 -
  mm/swap_state.c                 |   43 +++++--
  mm/swapfile.c                   |    6
  mm/truncate.c                   |    6
  mm/vmscan.c                     |   20 ++-
  21 files changed, 619 insertions(+), 211 deletions(-)

I recall there was a bit of noise recently about problems building
into an external working directory?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
