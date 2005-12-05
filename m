Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVLEQyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVLEQyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 11:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVLEQyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 11:54:05 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:54179 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750833AbVLEQyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 11:54:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=eMHlMxMK2Q8xDKfWmT96B3IlZ+A8wPJ2shUIXPXYAIjyBN9xU7MMwXwjR1/mMJvDdS6UhED1Llw4QxSa/jU7yrNb8qk9UgdQnewIqZmeELFv8nSqicx4QFABbh35Hahy0o7ggkk7RMYAonMh87yKx/cXEKqsB28Tz4uhdOz6ppw=
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for
	benchmarks
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dirk Henning Gerdes <mail@dirk-gerdes.de>, axboe@suse.de,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051201172520.7095e524.akpm@osdl.org>
References: <1133443051.6110.32.camel@noti>
	 <20051201172520.7095e524.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 08:54:16 -0800
Message-Id: <1133801656.21429.148.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 17:25 -0800, Andrew Morton wrote:
> Dirk Henning Gerdes <mail@dirk-gerdes.de> wrote:
> >
> >  For doing benchmarks on the I/O-Schedulers, I thought it would be very
> >  useful to disable the pagecache.
> 
> That's an FAQ.   Something like this?
> 
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> Add /proc/sys/vm/drop-pagecache.  When written to, this will cause the kernel
> to discard as much pagecache and reclaimable slab objects as it can.
> 
> It won't drop dirty data, so the user should run `sync' first.

BTW, (a while ago) I tried doing similar thing from user-space 
using POSIX_FADV_DONTNEED on a file. While it worked great to 
get rid of the pagecache pages for few files, since I had to 
run this on each and every file in the filesystem - it ended 
up bloating inode, dentry slabs :( I really wanted to find out 
what files are really cached in the pagecache to run this on.

Thanks,
Badari

