Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263729AbTDHAai (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263905AbTDHAaa (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 20:30:30 -0400
Received: from [12.47.58.221] ([12.47.58.221]:49504 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263881AbTDHA2s (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 20:28:48 -0400
Date: Mon, 7 Apr 2003 17:40:27 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: jiffies is UL
Message-Id: <20030407174027.6f2c7b2d.akpm@digeo.com>
In-Reply-To: <200304080036.h380aBFH009252@hraefn.swansea.linux.org.uk>
References: <200304080036.h380aBFH009252@hraefn.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2003 00:40:17.0519 (UTC) FILETIME=[6D311FF0:01C2FD67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/linux/time.h linux-2.5.67-ac1/include/linux/time.h
> --- linux-2.5.67/include/linux/time.h	2003-03-06 17:04:37.000000000 +0000
> +++ linux-2.5.67-ac1/include/linux/time.h	2003-03-07 14:57:13.000000000 +0000
> @@ -31,7 +31,7 @@
>   * Have the 32 bit jiffies value wrap 5 minutes after boot
>   * so jiffies wrap bugs show up earlier.
>   */
> -#define INITIAL_JIFFIES ((unsigned int) (-300*HZ))
> +#define INITIAL_JIFFIES ((unsigned long) (-300*HZ))
>  

No, this is deliberate.  It triggers a wrap from 0x00000000ffffffff to
0x0000000100000000 after 5 minutes uptime on 64-bit machines, which has found
bugs.

The fix is to add a comment, so this patch stops coming out ;)


