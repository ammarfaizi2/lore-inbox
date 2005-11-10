Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVKJM5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVKJM5h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVKJM5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:57:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43411 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750833AbVKJM5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:57:36 -0500
Message-ID: <437343B1.5000809@redhat.com>
Date: Thu, 10 Nov 2005 07:57:21 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] handling 64bit values for st_ino]
References: <20051110003024.GD7992@ftp.linux.org.uk>
In-Reply-To: <20051110003024.GD7992@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>[My apologies, forgot to Cc the first half...]
>
>Date: Thu, 10 Nov 2005 00:27:29 +0000
>From: Al Viro <viro@ftp.linux.org.uk>
>To: Linus Torvalds <torvalds@osdl.org>
>Subject: [PATCH 1/2] handling 64bit values for st_ino
>User-Agent: Mutt/1.4.1i
>
>	We certainly do not want 64bit kernel ino_t, since that would
>screw icache lookups for no good reason; fs with 64bit keys used to
>identify inodes can just use iget5().
>  
>

Has this potential degradation been measured?  This is a lot of extra
complexity which needs to justified by the resulting performance.

>	Fix is pretty cheap and consists of two parts:
>1) widen struct kstat ->ino to u64, add a macro (check_inumber()) to
>be used in callers of ->getattr() that want to store ->ino in possibly
>narrower fields and care about overflows (stuff like sys_old_stat() with
>its 16bit st_ino clearly doesn't ;-)
>

It seems to me that a type with a name which better matches the intended
semantics would be a better choice than u64.  Even something like ino64_t
would help file systems maintainers to correctly implement the appropriate
support.

    Thanx...

       ps
