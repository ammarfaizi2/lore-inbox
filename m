Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUCDFib (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 00:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbUCDFia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 00:38:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:29933 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261462AbUCDFi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 00:38:28 -0500
Date: Wed, 3 Mar 2004 21:38:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: peter@mysql.com, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
Message-Id: <20040303213823.1aa5a270.akpm@osdl.org>
In-Reply-To: <20040304052753.GJ4922@dualathlon.random>
References: <20040228072926.GR8834@dualathlon.random>
	<Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com>
	<20040229014357.GW8834@dualathlon.random>
	<1078370073.3403.759.camel@abyss.local>
	<20040303193343.52226603.akpm@osdl.org>
	<1078371876.3403.810.camel@abyss.local>
	<20040303200704.17d81bda.akpm@osdl.org>
	<20040304045212.GG4922@dualathlon.random>
	<20040303211042.33cd15ce.akpm@osdl.org>
	<20040304052753.GJ4922@dualathlon.random>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
>  > It is a judgement call.  Personally, I wouldn't ship a production kernel
>  > with this patch.  People need to be aware of the tradeoff and to think and
>  > test very carefully.
> 
>  test what? there's no way to know what soft of proprietary software
>  people will run on the thing.

In the vast majority of cases the application was already racy.  It took
davem a very long time to convince me that this was really a bug ;)

>  Personally I wouldn't feel safe to ship a kernel with a known race
>  condition add-on. I mean, if you don't know about it and it's an
>  implementation bug you know nobody is perfect and you try to fix it if
>  it happens, but if you know about it and you don't apply it, that's
>  pretty bad if something goes wrong.  Especially because it's a race,
>  even you test it, it may still happen only a long time later during
>  production. I would never trade performance for safety, if something I'd
>  try to find a more complex way to serialize against the vmas or similar.

Well first people need to understand the problem and convince themselves
that this really is a bug.  And yes, there are surely other ways of fixing
it up.  One might be to put some sequence counter in the mm_struct and
rerun the mprotect if it detects that someone else snuck in with a
usercopy.  Or add an rwsem to the mm_struct, take it for writing in
mprotect.

