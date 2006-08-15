Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbWHOG0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbWHOG0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 02:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbWHOG0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 02:26:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20174 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965215AbWHOG0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 02:26:17 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: What's in kbuild.git for 2.6.19 
In-reply-to: Your message of "Tue, 15 Aug 2006 13:53:37 +1000."
             <20560.1155614017@kao2.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Aug 2006 16:25:59 +1000
Message-ID: <25740.1155623159@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 12:02:09AM -0700, Keith Owens wrote:
>Sam Ravnborg (on Sun, 13 Aug 2006 21:45:03 +0200) wrote:
>>Outstanding kbuild issues (I should fix a few of these for 2.6.18):
>>o make -j N is not as parallel as expected (latest report from Keith
>>  Ownens but others has complained as well). I assume it is a kbuild
>>  thing but has no clue how to fix it or debug it further.
>
>It is the make jobserver code.  make -j<n> causes the various make
>tasks to communicate and work out how many versions are currently
>running, to avoid overrunning the -j<n> value.  Every recursive
>invocation of make subtracts one from the -j value, reducing the value
>that is left when make finally get down to doing some useful work
>instead of just recursing.  Jobserver problems are yet another reason
>why recursive make is bad.
>
>kbuild is full of recursive make.  The user cannot just add an excess
>to <n>, the number of recursive invocations changes from kernel to
>kernel as people try to fix bugs in makefile generation, so the
>required excess value keeps changing.

The jobserver in make 3.80 is buggy.  3.80 appears to work for parallel
builds using a single Makefile, with recursive make it can lose
jobserver tokens.  make 3.81 works fine.  Now to persuade SuSE to
upgrade to make 3.81.

