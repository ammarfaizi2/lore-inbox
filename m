Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266378AbUGJUE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266378AbUGJUE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 16:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUGJUE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 16:04:58 -0400
Received: from [195.205.111.101] ([195.205.111.101]:37925 "EHLO
	[195.205.111.101]") by vger.kernel.org with ESMTP id S266378AbUGJUEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 16:04:47 -0400
From: Marcin =?iso-8859-2?q?Gibu=B3a?= <mg@iceni.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm7
Date: Sat, 10 Jul 2004 22:04:35 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040708235025.5f8436b7.akpm@osdl.org>
In-Reply-To: <20040708235025.5f8436b7.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200407102204.35889.mg@iceni.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 July 2004 08:50, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-m
>m7/

Hi, 
I've encountered a process locked up in D state while using this kernel. The 
process is mpg123 playing mp3 from ntfs partition. I'm using cfq elevator.

Alt-SysRq-T reveals that:

mpg123        D 00000D33     0 18012  18592                     (NOTLB)
d8c11e28 00200086 37c2b380 00000d33 00000000 37c2b380 00000d33 c8761190
       c8761338 c1253760 c14011e8 00000275 d8c11e30 c02e9c27 00000275 c0127522
       c1253760 00000000 00000001 c8761190 c01272e1 d8c11e6c d8c11e6c c153d480
Call Trace:
 [<c02e9c27>] io_schedule+0xe/0x16
 [<c0127522>] __lock_page+0xa7/0xba
 [<c01272e1>] page_wake_function+0x0/0x36
 [<c01272e1>] page_wake_function+0x0/0x36
 [<c0127966>] do_generic_mapping_read+0x15d/0x2f4
 [<c0127d52>] __generic_file_aio_read+0x198/0x1b6
 [<c0127afd>] file_read_actor+0x0/0xbd
 [<c0127e1f>] generic_file_read+0x68/0x7c
 [<c0260014>] snd_pcm_oss_write1+0x131/0x165
 [<c013e27c>] vfs_read+0x9d/0xc9
 [<c013e436>] sys_read+0x2c/0x42
 [<c01039e1>] sysenter_past_esp+0x52/0x71

-- 
mg

