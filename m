Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161213AbWJRPtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161213AbWJRPtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161198AbWJRPtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:49:07 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:60806 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161192AbWJRPtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:49:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Gf9KXItGdXcXTvPnroLSDzoioRT3zGq/2aHTrz1SAIqfResIEmkX1EgWiuGT4m94Ex1/r3VLm8A30SOLk0t3z+GjN1eENiWY5IHVd1QHUFvRarCF9vdZahRsv5CgqxliIBHkBzxcXOwgV9Gz/mtIrVKDJUhTNqIKgPKEs/oi2S8=  ;
Message-ID: <45364CE9.7050002@yahoo.com.au>
Date: Thu, 19 Oct 2006 01:48:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc2-mm1
References: <20061016230645.fed53c5b.akpm@osdl.org> <1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> On Mon, 2006-10-16 at 23:06 -0700, Andrew Morton wrote:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm1/
>>
>>
>>- Added the hwmon and i2c trees to the -mm lineup.  These are quilt-style
>>  trees, maintained by Jean Delvare.
> 
> 
> 
> LTP writev tests seems to lockup the machine. reiserfs issue ?

...

> BUG: soft lockup detected on CPU#2!
> 
> Call Trace:
>  <IRQ>  [<ffffffff8024a4ba>] softlockup_tick+0xfa/0x120
>  [<ffffffff8022e10f>] __do_softirq+0x5f/0xd0
>  [<ffffffff80232067>] update_process_times+0x57/0x90
>  [<ffffffff80217e84>] smp_local_timer_interrupt+0x34/0x60
>  [<ffffffff802185db>] smp_apic_timer_interrupt+0x4b/0x80
>  [<ffffffff80326ce0>] __copy_user_nocache+0x20/0x150
>  [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
>  <EOI>  [<ffffffff802b8de0>] reiserfs_get_block+0x0/0x10c0
>  [<ffffffff80295198>] __block_prepare_write+0x158/0x470
>  [<ffffffff802b8de0>] reiserfs_get_block+0x0/0x10c0
>  [<ffffffff802954ca>] block_prepare_write+0x1a/0x30
>  [<ffffffff802b7cea>] reiserfs_prepare_write+0xca/0x140
>  [<ffffffff8024e9d2>] generic_file_buffered_write+0x2b2/0x610

This is likely to be a reiserfs interaction with the pagecache write
deadlock fixes. Chris Mason just now identified a couple of issues
and is going to work on a fix.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
