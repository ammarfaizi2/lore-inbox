Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUHIWbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUHIWbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267323AbUHIWbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:31:46 -0400
Received: from pao-nav01.pao.digeo.com ([12.47.58.24]:35601 "HELO
	pao-nav01.pao.digeo.com") by vger.kernel.org with SMTP
	id S267324AbUHIW3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:29:43 -0400
Date: Mon, 9 Aug 2004 15:24:47 -0700
From: Andrew Morton <akpm@digeo.com>
To: Oskar Berggren <beo@sgs.o.se>
Cc: hugh@veritas.com, vda@port.imtp.ilyichevsk.odessa.ua,
       linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.6.8-rc3 at mm/page_alloc.c:792 and mm/rmap.c:407
Message-Id: <20040809152447.50cd9cda.akpm@digeo.com>
In-Reply-To: <1092087230.14372.36.camel@pitr.ekb.sgsnet.se>
References: <Pine.LNX.4.44.0408092007000.5981-100000@localhost.localdomain>
	<1092087230.14372.36.camel@pitr.ekb.sgsnet.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Aug 2004 22:21:17.0960 (UTC) FILETIME=[30D6E880:01C47E5F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oskar Berggren <beo@sgs.o.se> wrote:
>
> I think I've managed to catch one of the missing lines that you
> mention in todays messages file, and then even more in the
> /var/log/syslog file:
> 
> Aug  9 13:07:59 otukt kernel:  <0>Bad page state at free_hot_cold_page
> (in process 'events/0', page c1090200)
> Aug  9 13:07:59 otukt kernel: flags:0x20000080 mapping:00000000
> mapcount:0 count:0
> Aug  9 13:07:59 otukt kernel: Backtrace:
> Aug  9 13:07:59 otukt kernel:  [bad_page+109/153] bad_page+0x6d/0x99
> Aug  9 13:07:59 otukt kernel:  [free_hot_cold_page+81/270]
> free_hot_cold_page+0x51/0x10e
> Aug  9 13:07:59 otukt kernel:  [sk_free+191/258] sk_free+0xbf/0x102
> Aug  9 13:07:59 otukt kernel:  [sk_common_release+87/203]
> sk_common_release+0x57/0xcb
> Aug  9 13:07:59 otukt kernel:  [inet_release+82/96]
> inet_release+0x52/0x60
> Aug  9 13:07:59 otukt kernel:  [sock_release+149/225]
> sock_release+0x95/0xe1
> Aug  9 13:07:59 otukt kernel:  [__crc_bio_get_nr_vecs+4158660/6507043]
> xprt_socket_autoclose+0x26/0x63 [sunrpc]
> Aug  9 13:07:59 otukt kernel:  [worker_thread+464/655]
> worker_thread+0x1d0/0x28f
> Aug  9 13:07:59 otukt kernel:  [__crc_bio_get_nr_vecs+4158622/6507043]
> xprt_socket_autoclose+0x0/0x63 [sunrpc]

hm.  There was a page double-freeing bug in the nfs/networking code
which Dave Miller fixed just a few days ago.  I'd suggest that you retest
using the latest tree from ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/
