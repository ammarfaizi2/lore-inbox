Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270486AbTHGU4c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270520AbTHGU4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:56:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:31170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270486AbTHGU4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:56:25 -0400
Date: Thu, 7 Aug 2003 13:58:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: suparna@in.ibm.com, linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH][2.6-mm] Readahead issues and AIO read speedup
Message-Id: <20030807135819.3368ee16.akpm@osdl.org>
In-Reply-To: <200308071341.50834.pbadari@us.ibm.com>
References: <20030807100120.GA5170@in.ibm.com>
	<200308071021.39816.pbadari@us.ibm.com>
	<20030807103930.69e497a7.akpm@osdl.org>
	<200308071341.50834.pbadari@us.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> On Thursday 07 August 2003 10:39 am, Andrew Morton wrote:
>  > Badari Pulavarty <pbadari@us.ibm.com> wrote:
>  > > We should do readahead of actual pages required by the current
>  > > read would be correct solution. (like Suparna suggested).
>  >
>  > I repeat: what will be the effect of this if all those pages are already in
>  > pagecache?
> 
>  Hmm !! Do you think just peeking at pagecache and bailing out if
>  nothing needed to be done, is too expensive ? Anyway, slow read
>  code has to do this later. Doing it in readahead one more time causes
>  significant perf. hit ?

It has been observed, yes.

> And also, do you think this is the most common case ?

It is a very common case.  It's one we need to care for.  Especially when
lots of CPUs are hitting the same file.

There are things we can do to tweak it up, such as adding a max_index to
find_get_pages(), then do multipage lookups, etc.  But not doing it at all
is always the fastest way.

