Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbVJUV6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbVJUV6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 17:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbVJUV6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 17:58:39 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:24110 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S965179AbVJUV6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 17:58:38 -0400
Message-ID: <4359645B.1080906@oracle.com>
Date: Fri, 21 Oct 2005 14:57:47 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: hch@infradead.org, linux-kernel@vger.kernel.org, adilger@clusterfs.com
Subject: Re: [RFC] page lock ordering and OCFS2
References: <20051017222051.GA26414@tetsuo.zabbo.net>	<20051017161744.7df90a67.akpm@osdl.org>	<43544499.5010601@oracle.com>	<435928BC.5000509@oracle.com>	<20051021175730.GD22372@infradead.org>	<43595131.3030709@oracle.com> <20051021135931.6065bbd1.akpm@osdl.org>
In-Reply-To: <20051021135931.6065bbd1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> All those games with PG_fs_misc look awfully similar to lock_page() - I'd
> have thought there's some room for rationalising code in there.

Yeah, it's very much like a secondary restricted page lock.  Instead of
sleeping when you can't get the page lock, you can also try acquiring this sort
of secondary page lock bit which lets you do *very* specific things.  Maybe
it's not *that* weird, I just didn't think that the core would be interested in
supporting that notion.  I can try rolling a patch to see what a more sensible
API would look like.

> The overall approach would be to avoid adding overhead and complexity for
> other filesystems and to only export symbols which constitute a sensible
> API:

*nod*

- z
