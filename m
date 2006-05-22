Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWEVR7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWEVR7I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWEVR7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:59:07 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:40351 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751097AbWEVR7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:59:07 -0400
Message-ID: <4471FBDE.8010506@oracle.com>
Date: Mon, 22 May 2006 10:58:54 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rdunlap@xenotime.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmap tracking
References: <20060518155357.04066e9c.rdunlap@xenotime.net>	<4471EA2C.4010401@oracle.com> <20060522103915.53e03867.akpm@osdl.org>
In-Reply-To: <20060522103915.53e03867.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was scratching my head over this patch trying to think of any bug in
> recent years which it would have detected.  I failed.

2.4 nfs used to require that it be able to kmap entire RPCs for them to
make forward progress.  Its file->write() required RPC forward progress
before it would return.  And some callers were holding kmaps across
file->write() calls.  So with enough concurrent callers doing that the
system would get stuck.

We used the patch to see who the callers were when the system got into
that state.

One of them was core dumping, believe it or not.  2.6 elf_core_dump()
still holds a kmap across file->write(), which seems unwise, but I
haven't gotten to seeing if it's worth worrying about or not.

So maybe these days the kmap story is less dreadful and it isn't as
helpful, but that's what we used it for.

- z
