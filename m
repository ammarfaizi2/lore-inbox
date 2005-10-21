Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbVJUUgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbVJUUgP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 16:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965153AbVJUUgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 16:36:15 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:36164 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965154AbVJUUgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 16:36:14 -0400
Message-ID: <43595131.3030709@oracle.com>
Date: Fri, 21 Oct 2005 13:36:01 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [RFC] page lock ordering and OCFS2
References: <20051017222051.GA26414@tetsuo.zabbo.net> <20051017161744.7df90a67.akpm@osdl.org> <43544499.5010601@oracle.com> <435928BC.5000509@oracle.com> <20051021175730.GD22372@infradead.org>
In-Reply-To: <20051021175730.GD22372@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Oct 21, 2005 at 10:43:24AM -0700, Zach Brown wrote:
>
>>It introduces block_read_full_page() and truncate_inode_pages() derivatives
>>which understand the PG_fs_misc special case.  It needs a few export patches to
>>the core, but the real burden is on OCFS2 to keep these derivatives up to date.
>
> The way you do it looks nice, but the exports aren't a big no-way.  That
> stuff is far too internal to be exported.  Either we can get Andrew to
> agree on moving those bits into the codepath for all filesystems or
> we need to do some hackery where every functions gets renamed to __function
> with an argument int cluster_aware and we have to functions inling them,
> one normal and one for cluster filesystems.

Yeah, I can certainly appreciate that line of reasoning.  I'm happy to do that
work, but it'd be nice to get some assurance that it won't be wasted effort.
Andrew, is this a reasonable direction to take things in?  We'd avoid the
exports by introducing some wrappers and helpers to the core that OCFS2 would
call..

- z
