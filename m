Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbUKVTAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbUKVTAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbUKVS6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:58:47 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:60861 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262286AbUKVS5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:57:49 -0500
Message-ID: <41A236A8.9000505@namesys.com>
Date: Mon, 22 Nov 2004 10:57:44 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, vs <vs@thebsh.namesys.com>
CC: linux-kernel@vger.kernel.org, mantel@suse.de
Subject: Re: [reiser4 bug] Whoops on module unload
References: <Pine.LNX.4.53.0411221929460.2981@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411221929460.2981@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>Hi,
>
>
>I just picked this up from /dev/vcsa10 (and /var/log/{kernel,messages})...
>seems to have happened upon `rmmod reiser4`. Did not luckily seem to make the
>system unusable.
>
>Kernel-version: SUSE Kernel of the day 20041029
>Reiser4 fs were not mounted at the time of the rmmod (that's logic), but were
>mounted before.
>
>The backtrace does not give much info (and ksymoops neither), so the best I
>could suggest is checking whether these codepaths allow unfreed objects. Since
>the KOTD I'm using is also a month old by now, don't invest too much time into
>this, if at all.
>
>Nov 22 19:29:13 otto kernel: slab error in kmem_cache_destroy(): cache
>`plugin_set': Can't free all objects
>Nov 22 19:29:13 otto kernel:  [kmem_cache_destroy+216/304]
>kmem_cache_destroy+0xd8/0x130
>Nov 22 19:29:13 otto kernel:  [<c0137b88>] kmem_cache_destroy+0xd8/0x130
>Nov 22 19:29:13 otto kernel:  [pg0+276180016/1069949952]
>plugin_set_done+0x10/0x40 [reiser4]
>Nov 22 19:29:13 otto kernel:  [<d0afec30>] plugin_set_done+0x10/0x40 [reiser4]
>Nov 22 19:29:13 otto kernel:  [pg0+276150806/1069949952]
>shutdown_reiser4+0x126/0x270 [reiser4]
>Nov 22 19:29:13 otto kernel:  [<d0af7a16>] shutdown_reiser4+0x126/0x270
>[reiser4]
>Nov 22 19:29:13 otto kernel:  [sys_delete_module+415/432]
>sys_delete_module+0x19f/0x1b0
>Nov 22 19:29:13 otto kernel:  [<c012ba5f>] sys_delete_module+0x19f/0x1b0
>Nov 22 19:29:13 otto kernel:  [do_munmap+289/368] do_munmap+0x121/0x170
>Nov 22 19:29:13 otto kernel:  [<c0141351>] do_munmap+0x121/0x170
>Nov 22 19:29:13 otto kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>Nov 22 19:29:13 otto kernel:  [<c010414f>] syscall_call+0x7/0xb
>
>
>Jan Engelhardt
>  
>
vs, please look into this, Jan, it will probably be several days before 
vs gets to this, as he is a bit swamped this week.

Hans
