Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282962AbRLHJpp>; Sat, 8 Dec 2001 04:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284314AbRLHJpZ>; Sat, 8 Dec 2001 04:45:25 -0500
Received: from hal.astr.lu.lv ([195.13.134.67]:42880 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S282962AbRLHJpP>;
	Sat, 8 Dec 2001 04:45:15 -0500
Message-Id: <200112080945.fB89jAC00998@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] i810_audio fix for version 0.11
Date: Sat, 8 Dec 2001 11:45:10 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Nathan Bryant <nbryant@optonline.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.A41.4.05.10112081022560.23064-100000@ieva06> <200112080925.fB89PJ200926@hal.astr.lu.lv> <3C11DF15.1020107@redhat.com>
In-Reply-To: <3C11DF15.1020107@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 December 2001 11:36, Doug Ledford wrote:
> Andris Pavenis wrote:
> >On Saturday 08 December 2001 10:39, Andris Pavenis wrote:
> >>Sorry, but this patch is still not OK. It still causes system
> >>locking up for me.
> >>
> >>In some cases I have (I added printk in __start_dac):
> >>	dmabuf->count = 0
> >>	dmabuf->ready = 1
> >>	dmabuf->enable = 1
> >>	PCM_ENABLE_OUTPUT set in dmabuf->triger
>
> Actually, since the problem is that there are obviously some "just in
> case" type calls if i810_update_lvi(), the best answer is not to even go
> through all those motions when dmabuf->count == 0.  So, I would add a
> line to i810_update_lvi() that makes it return without doing anything
> when dmabuf->count == 0.  That one line should solve your lockups (and
> finalize the 0.12 version).
>

Why returning non zero from __start_dac() and similar procedures when 
something real has been done there is so bad. Using such return code would
ensure we never try to wait for results of __start_dac() if nothing is done 
by this procedure. I think such way is also more safe against possible future 
modifications as real conditions are only in a single place. Keeping them in 
2 places is possible source of bitrot if driver will be updated in future.

Andris
