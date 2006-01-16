Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWAPLv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWAPLv1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 06:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbWAPLv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 06:51:26 -0500
Received: from picard.linux.it ([213.254.12.146]:11731 "EHLO picard.linux.it")
	by vger.kernel.org with ESMTP id S1751019AbWAPLv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 06:51:26 -0500
Message-ID: <14017.83.103.117.254.1137412285.squirrel@picard.linux.it>
In-Reply-To: <43CB6796.4040104@namesys.com>
References: <20060110235554.GA3527@inferi.kami.home>
    <20060110170037.4a614245.akpm@osdl.org>
    <20060115221458.GA3521@inferi.kami.home>
    <20060116094817.A8425113@wobbly.melbourne.sgi.com>
    <43CB6796.4040104@namesys.com>
Date: Mon, 16 Jan 2006 12:51:25 +0100 (CET)
Subject: Re: 2.6.15-mm3 bisection: git-xfs.patch makes reiserfs oops
From: "Mattia Dongili" <malattia@linux.it>
To: "Hans Reiser" <reiser@namesys.com>
Cc: "Nathan Scott" <nathans@sgi.com>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       linux-xfs@oss.sgi.com, "Jeff Mahoney" <jeffm@suse.com>,
       "Mattia Dongili" <malattia@linux.it>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
>  Nathan Scott wrote:
>>On Sun, Jan 15, 2006 at 11:14:58PM +0100, Mattia Dongili wrote:
[...]
>>>you're right: git-xfs.patch is the bad guy.
>>>
>>>Unfortunately netconsole isn't helpful in capturing the oops (no serial
>>>ports here) but I have two more shots (more readable):
>>>http://oioio.altervista.org/linux/dsc03148.jpg
>>>http://oioio.altervista.org/linux/dsc03149.jpg
>>>
>>>
>>
>>Hmm, thats odd.  It seems to be coming from:
>>reiserfs_commit_page -> reiserfs_add_ordered_list -> __add_jh(inline)
>>
>>I guess XFS may have left a buffer_head in an unusual state (with some
>>private flag/b_private set), somehow, and perhaps that buffer_head has
>>later been allocated for a page in a reiserfs write.  Does this patch,
>>below, help at all?

Yes, it does help, good catch! I'm currently running -mm4, which presented
the same behaviour, with your one liner and I can't reproduce the oops 
anymore (fortunately for my root FS!).

thanks
-- 
mattia
:wq!


