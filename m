Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130071AbRB1Gsu>; Wed, 28 Feb 2001 01:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130072AbRB1Gsl>; Wed, 28 Feb 2001 01:48:41 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:39186 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S130071AbRB1Gs3>; Wed, 28 Feb 2001 01:48:29 -0500
Date: Wed, 28 Feb 2001 02:02:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Reserved memory for highmem bouncing  
In-Reply-To: <E14XuMy-0004ZW-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102272021120.7124-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

I have a question about the highmem page IO deadlock fix which is in
2.4.2-ac. (the emergency memory thing)

The old create_bounce code used to set PF_MEMALLOC on the task flags and
call wakeup_bdflush(1) in case GFP_BUFFER page allocation failed. That was
broken because flush_dirty_buffers() could try to flush a buffer pointing
to highmem page, which would end up in create_bounce again, but with
PF_MEMALLOC.

Have you tried to make flush_dirty_buffers() only flush buffers pointing
to lowmem pages in case the caller wants it to do so?

This way you can call flush_dirty_buffers() with the guarantee you're
going to free useful (lowmem) memory. This also throttles high mem writes
giving priority to low mem ones.


