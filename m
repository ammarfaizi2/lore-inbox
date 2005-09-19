Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbVISUlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbVISUlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 16:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbVISUlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 16:41:42 -0400
Received: from ns1.trc-odintsovo.ru ([213.85.88.5]:59084 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932630AbVISUll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 16:41:41 -0400
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Date: Tue, 20 Sep 2005 00:41:57 +0400
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <432AFB44.9060707@namesys.com> <20050916174028.GA32745@infradead.org>
In-Reply-To: <20050916174028.GA32745@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509200041.58346.zam@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Friday 16 September 2005 21:40, Christoph Hellwig wrote:
> more trivial review comments ontop of the previous one, after looking
> at things:
>
>  - please never use list_for_each in new code but list_for_each_entry
>  - never use kernel_thread in new code but kthread_*

done.  thanks Christoph.

>  - do_sendfile duplicates the common sendfile code.  why aren't you
>    using the generic code?

I removed reiser4 version of do_sendfile and replaced it by 
generic_file_sendfile() under reiser4 context.
loop device still works.

>  - there's tons of really useless assertation of the category
>    discussed in the last thread
>  - there's tons of deep pagecache messing in there.  normally this
>    shouldn't be a filesystem, and if this breaks because of VM changes
> you'll have to fix it, don't complain..
>  - you still do your plugin mess in ->readpage.  honsetly could you
>    please explain why mpage_readpage{,s} don't work for you?
>  - (issues with the read/write path already addresses in the previous
> thread) - looking at ->d_count in ->release is wrong
>  - still has security plugin stuff that duplicates LSM
>  - why do underlying attributes change when VFS inode doesn't change?
>    if not please rip out most of getattr_common
>  - link_common S_ISDIR doesn't make sense, VFS takes care of it
>  - please use the generic_readlink infrastructure
>
> additinoal comment is that the code is very messy, very different
> from normal kernel style, full of indirections and thus hard to read.
> real review will take some time.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Thanks,
Alex.
