Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTH0Jfe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 05:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbTH0Jfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 05:35:34 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57480 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263285AbTH0JfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 05:35:24 -0400
Date: Wed, 27 Aug 2003 18:36:10 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: cache limit
In-reply-to: <20030826094634.GP4306@holomorphy.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <19C36C7EA5D3E5indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.04 (WinNT,501)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
References: <20030826094634.GP4306@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for advice.

On Mon, 25 Aug 2003 15:58:47 -0700, Mike Fedyk wrote:

>I doubt that there will be that option in the 2.4 stable series.  I think
>you are trying to fix the problem without understanding the entire picture.
>If there is too much pagechache, then the kernel developers need to know
>about your workload so that they can fix it.  But you have to try -aa first
>to see if it's already fixed.
>
>> This is moderately misguided; essentially the only way userspace can
>> utilize RAM at all is via the pagecache. It's not useful to limit this;
>> you probably need inode-highmem or some such nonsense.
>
>Exactly.  Every program you have opened, and all of its libraries will show
>up as pagecache memory also, so seeing a large pagecache in and of itself
>may not be a problem.
>
>Let's get past the tuning paramenter you want in /proc, and tell us more
>about what you are doing that is causing this problem to be shown.

This problem happened a few month ago and the detailed data does not
remain. Therefore it is difficult to know what is essential cause for
this problem, but, I guessed that pagecache used as I/O cache grew
gradually during system running, and finally it oppressed memory.

Besides this problem, there are many cases where increase of pagecache
causes trouble, I think.
For example, DBMS.
DBMS caches index of DB in their process space.
This index cache conflicts with the pagecache used by other applications,
and index cache may be paged out. It cause uneven response of DBMS.
In this case, limiting pagecache is effective.


On Tue, 26 Aug 2003 02:46:34 -0700, William Lee Irwin III wrote:

>One thing I thought of after the post was whether they actually had in
>mind tunable hard limits on _unmapped_ pagecache, which is, in fact,
>useful. OTOH that's largely speculation and we really need them to
>articulate the true nature of their problem.

I also think that is effective. Empirically, in the case where pagecache
causes memory shortage, most of pagecache is unmapped page. Of course
real problem may not be pagecashe, as you or Mike said.

--------------------------------------------------
Takao Indoh
 E-Mail : indou.takao@soft.fujitsu.com

