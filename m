Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVBWVeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVBWVeQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVBWVeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:34:09 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:12460 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261604AbVBWVbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:31:55 -0500
Date: Wed, 23 Feb 2005 21:31:16 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Ammar T. Al-Sayegh" <ammar@kunet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:483!
In-Reply-To: <009d01c519e8$166768b0$7101a8c0@shrugy>
Message-ID: <Pine.LNX.4.61.0502232108500.14780@goblin.wat.veritas.com>
References: <009d01c519e8$166768b0$7101a8c0@shrugy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005, Ammar T. Al-Sayegh wrote:
> 
> I recently installed Fedora RC3 on a new server.
> The kernel is 2.6.10-1.741_FC3smp.

I can't really speak for Fedora RC3 kernels,
perhaps there's some special patch in there that happens to
trigger it for you, but certainly there have been occasional
other reports of this BUG with vanilla kernel.org kernels.

> The server
> crashes every few days. When I examine /var/log/messages,
> I find the following line just before the crash:
> 
> Feb 22 23:50:35 hostname kernel: ------------[ cut here ]------------
> Feb 22 23:50:35 hostname kernel: kernel BUG at mm/rmap.c:483!
> 
> No further debug lines are given to diagnose the
> source of the problem.

It's odd that you get no more lines, but it doesn't really
matter in this case.  Sadly, the debug info accompanying this
BUG has done very little to shed light on its causes (and it's
on my todo list to change it to something less of a hindrance).

> I have been using kernel 2.4 for few years now without
> any problem. This is the first time I see this problem
> with kernel 2.6. I'm not sure if this is related to
> the kernel itself, the new hardware, or some other
> installed software. I'm thinking about downgrading to
> kernel 2.4. Do you think this will resolve this issue?

Downgrading to 2.4 will most certainly stop that particular
BUG, since 2.4 has no equivalent.  But it won't necessarily
fix the underlying issue.

> Any suggestion on what else I can do to mitigate this
> problem?

The first thing to do is to give memtest86 a good (say
overnight) run.  Many of the rmap.c BUG reporters have
subsequently found memtest86 failures, and we believe those
instances are accounted for by bad memory.  And if that's so
in your case, you don't really want to be running 2.4 on it.

But not all cases could be accounted in that way.  If you
report back that memtest86 ran cleanly, then I'll have to
rework a debug patch against your Fedora RC3 kernel to try
to give us more info - though quite possibly you cannot afford
such experiments on this server, and will revert to 2.4 for now.

Hugh
