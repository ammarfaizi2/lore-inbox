Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUIOB0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUIOB0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 21:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUIOB0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 21:26:37 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:46585 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264917AbUIOB0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 21:26:25 -0400
Message-ID: <41479A43.4040708@namesys.com>
Date: Tue, 14 Sep 2004 18:26:27 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Zarochentcev <zam@namesys.com>
Subject: Re: [PATCH] ReiserFS v3 I/O error handling
References: <414710B7.5080709@suse.com>
In-Reply-To: <414710B7.5080709@suse.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney wrote:

> Hey all -
>
> One of the most common complaints I've heard about ReiserFS is how
> graceless it is in handling critical I/O errors.
>
> ext[23] can handle I/O errors anywhere, with the results being up to the
> system admin to determine: continue, go read only, or panic.
>
> ReiserFS doesn't offer the admin any such choice, instead panicking on
> any I/O error in the journal.
>
> I've posted four patches at:
> ftp://ftp.suse.com/pub/people/jeffm/reiserfs/kernel-v2.6/io-error/
>
> Against 2.6.9-rc2:
> * reiserfs-cleanup-buffer-heads.diff
>     - Cleans up handling of buffer head bitfields - uses
>       the kernel supplied FNS_BUFFER macros instead.
> * reiserfs-cleanup-sb-journal.diff
>     - Cleans up accessing of the journal structure, prefering
> ~           to create a temporary variable in functions that access
> ~           the journal structure non-trivially. Should make 0 difference
> ~           at compile time.
> * reiserfs-write-lock.diff
>     - Fixes two missing reiserfs_write_unlock() calls on error paths
> ~           that are unrelated to the last patch.
> * reiserfs-io-error-handling.diff
>     - Allows ReiserFS to gracefully handle I/O errors in critical
>       code paths. The admin has the option to go read-only or panic.
>       Since ReiserFS has no option to ignore the use of the journal,
> ~          the "continue" method is not enabled.
>
> These patches have seen a lot of testing in the SuSE Linux Enterprise
> Server 9 kernel, and are considered ready for mainline.
>
> Hans - please take a look.
>
> -Jeff
>
> [Resent: The patches initially were attached, and I suspect they were
> too large to make it onto the list.]
>
> --
> Jeff Mahoney
> SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

I am going to let zam review it on my behalf due to urgent personal 
issues.  If he does not respond in seven days, complain to me about it 
and my personal issues will be past me by then.

Hans
