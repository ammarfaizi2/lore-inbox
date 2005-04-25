Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262581AbVDYKzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbVDYKzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 06:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbVDYKzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 06:55:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:22962 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262581AbVDYKy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 06:54:29 -0400
Date: Mon, 25 Apr 2005 03:53:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] counting bounce pages.
Message-Id: <20050425035357.2919e68f.akpm@osdl.org>
In-Reply-To: <426CC767.8050507@jp.fujitsu.com>
References: <426CC767.8050507@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> This is a patch for counting bounce pages.
>  With this, pages for bounce buffer is coutned and shown in /proc/meminfo.

As it's purely a debug thing, perhaps /proc/vmstat would be a better place
for displaying this info.

>  Because pages for bounce buffer are not counted in anywhere,
>  sometimes it seems that there are many leaked pages.
>  ex)
>  I found 1.7GB of bounce buffer pages in a crash dump of ia64 kernel,
>  which was passed me to check memory usage. :(

whoops.

>  BTW, I'm not sure whether # of bounce buffer should be includeded in Buffers:
>  of /proc/meminfo.

No, "Buffers:" is "the number of bytes allocated to blockdevice pagecache".
Usually this is filesystem metadata.

>  --- linux-2.6.12-rc2-mm3/fs/proc/proc_misc.c~count_bounce	2005-04-25 12:08:28.000000000 +0900
>  +++ linux-2.6.12-rc2-mm3-kamezawa/fs/proc/proc_misc.c	2005-04-25 16:06:39.000000000 +0900
>  @@ -114,7 +114,7 @@ static int uptime_read_proc(char *page, 
>   
>   	return proc_calc_metrics(page, start, off, count, eof, len);
>   }
>  -
>  +extern atomic_t nr_bounce_pages;

Please always put extern declarations into .h files, with the declaration
visible to the definition and to all users.

>  +		"Bounce :      %8lu kB\n"

There's an unneeded space in there.

