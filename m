Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSDDWce>; Thu, 4 Apr 2002 17:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSDDWc1>; Thu, 4 Apr 2002 17:32:27 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:53515 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311749AbSDDWcO>; Thu, 4 Apr 2002 17:32:14 -0500
Message-ID: <3CACD3FE.1323F721@zip.com.au>
Date: Thu, 04 Apr 2002 14:30:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, Arjan Van de Ven <arjanv@redhat.com>
Subject: Re: Linux 2.4.19-pre5-ac2
In-Reply-To: <200204042017.g34KHqv11609@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> ...
> o       Cache more group descriptors on ext2/ext3       (Arjan van de Ven)

[ See below for the rant ]

I'd be interested in knowing what testing was performed, what
workload this addresses, what improvements were observed, etc.

Did anyone consider and/or test removal of the cache altogether,
and adding a touch_buffer() to the backing buffer_head, to allow the
VM to perform the LRU management instead?

Did anyone try leaving the LRU at its current size and seeing if
a touch_buffer() improves the problematic testcase?

If there is indeed a workload which is improved by this patch,
I would like know what it is, please - I would like to see if allowing
the VM to manage the LRU also fixes that workload, because that's
surely better than pinning down 256 kilobytes of memory per mounted
filesystem.

Thanks.




The rant:

Not singling out Arjan; certainly this is not the most egregious
case lately.  But.  Will people please stop sending kernel
patches straight to tree owners without copying the appropriate
mailing list?

There is no benefit in keeping all the other kernel developers
in the dark.  If a patch is not security-related and is not
trivially boring, tree-owners should consider just dropping
the thing if it has not been seen by the other developers.

It's not as if this mailing list is overwhelmed with technical
content, is it?  If people are shy, or are reluctant to disrupt
the social and political ambiance of linux-kernel, there are
other lists, including

	linux-fsdevel@vger.kernel.org
	linux-mm@kvack.org
	netdev@oss.sgi.com
	ext2-devel@lists.sourceforge.net

and of course many others.

-
