Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbTJMMBa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 08:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbTJMMBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 08:01:30 -0400
Received: from asplinux.ru ([195.133.213.194]:1550 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S261685AbTJMMB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 08:01:27 -0400
From: Kirill Korotaev <kk@sw.ru>
Reply-To: kk@sw.ru
Organization: SWsoft
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] Invalidate_inodes can be very slow
Date: Mon, 13 Oct 2003 16:02:20 +0400
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200310131318.09234.kk@sw.ru> <200310131545.01779.kk@sw.ru> <20031013115458.GI16158@holomorphy.com>
In-Reply-To: <20031013115458.GI16158@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310131602.20479.kk@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch can be tested quite easily. Main changes are in
> > invalidate_list. This path can be triggered by umount/quota off.
> > So I tested it the following way:
> > 1. mounting/working/umounting partition (and turning quota on/off)
> > 2. running memeater to call prune_icache when partition was mounted
> > to test that lists are ok.
> > All other places should be ok, since simple list_add/list_del is
> > inserted.
>
> Sorry if I was unclear, I had in mind SMP performance testing of mount
> and unmount -heavy workloads, like uni setups with many automounted fs's,
> not stability testing per se.
Oh, sorry for misunderstanding.
In our internal testcase on 8-CPU 8Gb RAM machine with 4gb split kernel
w/o this patch mount/umount test longs in many-many (>10) times longer.
Moreover, during the test machine is very slow (due to lock_kernel)
and typing simple commands takes up to 30 seconds or so.
I think such a long hangs are due to number of umounts executed
subsequently. But ofcourse it's not numbers, just for you to know where
the patch comes from :)

Kirill

