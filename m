Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTEAGSi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 02:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTEAGSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 02:18:38 -0400
Received: from [12.47.58.20] ([12.47.58.20]:4770 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262709AbTEAGSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 02:18:36 -0400
Date: Wed, 30 Apr 2003 23:31:43 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [BUG] 2.5.68-mm2 and list.h
Message-Id: <20030430233143.575d7af1.akpm@digeo.com>
In-Reply-To: <873cjznq7v.fsf@lapper.ihatent.com>
References: <20030423012046.0535e4fd.akpm@digeo.com>
	<873cjznq7v.fsf@lapper.ihatent.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2003 06:30:51.0683 (UTC) FILETIME=[36081730:01C30FAB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@ihatent.com> wrote:
>
> kernel BUG at include/linux/list.h:140!
> Call Trace:
>  [<c019e462>] devfs_d_revalidate_wait+0x181/0x18d

Yes.  Apparently, devfs has some programming flaws.


For now, please just delete the new debug tests in
include/linux/list.h:list_del():

#include <linux/kernel.h>       /* BUG_ON */
static inline void list_del(struct list_head *entry)
{
	BUG_ON(entry->prev->next != entry);
	BUG_ON(entry->next->prev != entry);
	__list_del(entry->prev, entry->next);
}

Those BUG_ON's.
