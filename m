Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262397AbSI2GHb>; Sun, 29 Sep 2002 02:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262399AbSI2GHb>; Sun, 29 Sep 2002 02:07:31 -0400
Received: from packet.digeo.com ([12.110.80.53]:47265 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262397AbSI2GHb>;
	Sun, 29 Sep 2002 02:07:31 -0400
Message-ID: <3D9699DE.F7528065@digeo.com>
Date: Sat, 28 Sep 2002 23:12:46 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zach Brown <zab@zabbo.net>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.39 list_head debugging
References: <20020929015852.K13817@bitchcake.off.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2002 06:12:47.0364 (UTC) FILETIME=[3B53A440:01C2677F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote:
> 
> ...
> +       BUG_ON(list == NULL);
> +       BUG_ON(list->next == NULL);
> +       BUG_ON(list->prev == NULL);
> +       BUG_ON(list->next->prev != list);
> +       BUG_ON(list->prev->next != list);
> +       BUG_ON((list->next == list) && (list->prev != list));
> +       BUG_ON((list->prev == list) && (list->next != list));
> +


Could we make these just do a printk+dump_stack and continue
on?  A BUG is a bit severe.

If you do this, I suggest you add the text "warning" to
the printk.  People tend to think that the dump_stack output
is an actual oops, and they get all worried.
