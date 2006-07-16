Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946146AbWGPHMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946146AbWGPHMW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 03:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946147AbWGPHMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 03:12:22 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:18570 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1946146AbWGPHMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 03:12:22 -0400
Message-ID: <44B9E6D5.2040704@namesys.com>
Date: Sun, 16 Jul 2006 00:12:21 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: 7eggert@gmx.de, Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com>
In-Reply-To: <44B7D97B.20708@suse.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So the Plan 9 and Unix way would be to let the driver parse the number
part of the name after the last slash.  What I don't understand is why
reiserfs is getting involved here, rather than recognizing the driver as
an extension of the namespace, seeing the driver as a mountpoint, and
just passing number to the driver.  There must be something I don't
grasp here, can you help me?

Hans

Jeff Mahoney wrote:

> Bodo Eggert wrote:
>
> >Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> >>On Wednesday 12 July 2006 18:42, Jeff Mahoney wrote:
>
> >>> On systems with block devices containing slashes (virtual dasd, cciss,
> >>> etc), reiserfs will fail to initialize /proc/fs/reiserfs/<dev> due to
> >>> it being interpreted as a subdirectory. The generic block device code
> >>> changes the / to ! for use in the sysfs tree. This patch uses that
> >>> convention.
> >>>
> >>> Tested by making dm devices use dm/<number> rather than dm-<number>
> >>
> >>Your patch handles at most one slash. But the description mentions
> 'slashes'
> >>(ie several slashes)
>
> >Besides that, there is no reason to prevent the user from using many
> slashes.
> >OTOH, I'd prefer propper quoting, but having each driver do this would be
> >insane.
>
>
> The strings aren't user-supplied, they're kernel-internal names of block
> devices, supplied by the driver. At present there is no possibility of
> more than one slash in the name, and I doubt we'll see any new devices
> with one slash in them, never mind more than one.
>
> -Jeff
>
> --
> Jeff Mahoney
> SUSE Labs

