Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbTENAdZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 20:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263245AbTENAdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 20:33:24 -0400
Received: from palrel12.hp.com ([156.153.255.237]:38598 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263234AbTENAdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 20:33:23 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16065.37323.886512.881778@napali.hpl.hp.com>
Date: Tue, 13 May 2003 17:46:03 -0700
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@digeo.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm4
In-Reply-To: <20030514001536.GE8978@holomorphy.com>
References: <20030512225504.4baca409.akpm@digeo.com>
	<20030514001536.GE8978@holomorphy.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 13 May 2003 17:15:36 -0700, William Lee Irwin III <wli@holomorphy.com> said:

  William> On Mon, May 12, 2003 at 10:55:04PM -0700, Andrew Morton
  William> wrote:
  >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm4/
  >> Lots of small things.  thread-info-in-task_struct.patch allow
  >> thread_info to be allocated as part of task_struct

  William> AIUI the task_cache is meant to prevent certain task_t
  William> (dear gawd I can't stand those _struct suffixes)
  William> refcounting pathologies because the task_t has its final
  William> put done by the task itself or something on that order, so
  William> it may be better for ia64 to adapt the task_cache to their
  William> purposes instead of wiping it entirely. Also, making the
  William> task_cache treatment uniform apart from its declaration
  William> would allow the #ifdef to be shoved in a header.

  William> Alternatively, one could alter the timing of the final put
  William> on a task_t so as to handle it similarly to the final
  William> mmput() (though here, too it might be more sightly to
  William> #ifdef the necessary bits in headers).

  William> I think there are already outstanding task_t refcounting
  William> bugs, so I'm not entirely sure where we stand wrt. changing
  William> final put mechanics.

All I really care about is that (a) task_struct, thread_info, and
kernel stack remain contiugous and within a single 64MB page and (b)
that it be fast (as usual ;-).  Other than that, it doesn't really
matter where the memory comes from.

	--david
