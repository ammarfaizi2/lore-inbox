Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbTENAC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 20:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbTENAC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 20:02:59 -0400
Received: from holomorphy.com ([66.224.33.161]:39614 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263693AbTENAC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 20:02:58 -0400
Date: Tue, 13 May 2003 17:15:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm4
Message-ID: <20030514001536.GE8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, davidm@hpl.hp.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030512225504.4baca409.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512225504.4baca409.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 10:55:04PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm4/
> Lots of small things.
> thread-info-in-task_struct.patch
>   allow thread_info to be allocated as part of task_struct

AIUI the task_cache is meant to prevent certain task_t (dear gawd I
can't stand those _struct suffixes) refcounting pathologies because
the task_t has its final put done by the task itself or something
on that order, so it may be better for ia64 to adapt the task_cache to
their purposes instead of wiping it entirely. Also, making the
task_cache treatment uniform apart from its declaration would allow the
#ifdef to be shoved in a header.

Alternatively, one could alter the timing of the final put on a task_t
so as to handle it similarly to the final mmput() (though here, too it
might be more sightly to #ifdef the necessary bits in headers).

I think there are already outstanding task_t refcounting bugs, so I'm
not entirely sure where we stand wrt. changing final put mechanics.

-- wli
