Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269436AbRHLVn5>; Sun, 12 Aug 2001 17:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269437AbRHLVnr>; Sun, 12 Aug 2001 17:43:47 -0400
Received: from fungus.teststation.com ([212.32.186.211]:22283 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S269436AbRHLVnj>; Sun, 12 Aug 2001 17:43:39 -0400
Date: Sun, 12 Aug 2001 23:43:28 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Bjorn Wesen <bjorn@sparta.lu.se>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: alloc_area_pte: page already exists
In-Reply-To: <Pine.LNX.3.96.1010812140743.1163B-100000@medusa.sparta.lu.se>
Message-ID: <Pine.LNX.4.30.0108122311230.27979-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2001, Bjorn Wesen wrote:

> I looked into this and I can't figure out how to actually use this. It
> seems as if schedule_task doesn't take a copy of the incoming tq_struct
> but actually uses it as-is - and this poses a problem of creating the
> tq_struct in the first place.
> 
> You can't kmalloc it, because then the task called by the tq_struct will
> need to kfree itself and I'm pretty sure the kernel won't enjoy that.

I think you can kmalloc it as __run_task_queue (assuming that is the only
consumer of tasks ...) moves the queued tasks to a private list and then
never references an element after the 'routine' of that element has been
called.

smbfs does this in fs/smbfs/sock.c (and if that's wrong I'd like to know :)
and so does reiserfs in fs/reiserfs/journal.c.

/Urban

