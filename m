Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265291AbUGZNS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbUGZNS0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 09:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbUGZNS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 09:18:26 -0400
Received: from qserv01.quadrics.com ([194.202.174.11]:1481 "EHLO
	qserv01.quadrics.com") by vger.kernel.org with ESMTP
	id S265291AbUGZNSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 09:18:22 -0400
Message-ID: <4105049D.9000008@quadrics.com>
Date: Mon, 26 Jul 2004 14:18:21 +0100
From: David Addison <addy@quadrics.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kaloian Manassiev <kmanassieff@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap + mprotect + malloc strange behaviour
References: <20040726130106.63000.qmail@web13605.mail.yahoo.com>
In-Reply-To: <20040726130106.63000.qmail@web13605.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jul 2004 13:15:41.0984 (UTC) FILETIME=[A6E4E200:01C47312]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kaloian Manassiev wrote:

>Nevermind, I found it :)
>
>I just found out (by reading
>/usr/src/linux-2.4.20-8/Documentation/sysctl/vm.txt)
>that there is a limit on the number of mappings that a
>process may have and that for some reason malloc
>consumes mappings.
>
>I just increased the limit by editing the file
>/proc/sys/vm/max_map_count. This works okay for my
>application...
>
>Does someone know what repercussions this could have
>on the "normal" operation of the system?
>
>Cheers,
>Kaloian.
>
>
>  
>
The glibc malloc heap switches to using mmap()/munmap() for large 
allocations (>=128kbytes ?). This behaviour can be turned off by setting;

export MALLOC_TRIM_THRESHOLD_=-1
export MALLOC_MMAP_MAX_=0

See also the mallopt() library call.


Cheers
Addy.


