Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVFGQZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVFGQZc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 12:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVFGQZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 12:25:32 -0400
Received: from [81.2.110.250] ([81.2.110.250]:42162 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261929AbVFGQZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 12:25:21 -0400
Subject: Re: Overcommit problems with 2.6.12-rc4 (on AMD64)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050602101828.GA11794@uio.no>
References: <20050602101828.GA11794@uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118161378.22424.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Jun 2005 17:23:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-06-02 at 11:18, Steinar H. Gunderson wrote:
>   imapd[31528]: segfault at 00000000fff00000 rip 00000000556a1a6d rsp 00000000ffffd394 error 4
>   imapd[31527]: segfault at 00000000fff00000 rip 00000000556a1a6d rsp 00000000ffffcbe4 error 4
>   sh[31530]: segfault at 00000000ffff7ff4 rip 000000005555e556 rsp 00000000ffff7ff8 error 6
>   sh[31531]: segfault at 00000000ffff7e5c rip 00000000555dc575 rsp 00000000ffff7e60 error 6
>   Unable to load interpreter /lib/ld-linux.so.2
>   Unable to load interpreter /lib/ld-linux.so.2
>   (ad infinitum)

You ran out of address space

> Suddenly everything seems to be back to normal (ie. we could swapoff, and the
> programs stopped running out of memory; no changes in the cache used,
> though), and after a quick restart of services, everything is back to normal.
> So to me, it looks like vm.overcommit_memory=2 is broken, at least on AMD64.
> Any ideas why this would happen?

vm.overcommit_memory=2 prevents the possibility of overcommitting - ie
of address space being allocated to someone which is not used. Your swap
allocation data is showing pages allocated not pages that could be
allocated due to page faults. You need to look as the AS figures in
/proc/meminfo to see the address space committed.

Basically it went back to "sane" because you said "ok I might get OOM
but take the gamble", and since many programs allocate lots of space
they never touch it worked.

