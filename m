Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267675AbTBEC2Q>; Tue, 4 Feb 2003 21:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267677AbTBEC2Q>; Tue, 4 Feb 2003 21:28:16 -0500
Received: from 4-088.ctame701-1.telepar.net.br ([200.193.162.88]:15030 "EHLO
	4-088.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267675AbTBEC2P>; Tue, 4 Feb 2003 21:28:15 -0500
Date: Wed, 5 Feb 2003 00:37:38 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andy Chou <acc@CS.Stanford.EDU>
cc: linux-kernel@vger.kernel.org, "" <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 112 potential memory leaks in 2.5.48
In-Reply-To: <20030205011353.GA17941@Xenon.Stanford.EDU>
Message-ID: <Pine.LNX.4.50L.0302050037280.32328-100000@imladris.surriel.com>
References: <20030205011353.GA17941@Xenon.Stanford.EDU>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.50L.0302050037282.32328@imladris.surriel.com>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2003, Andy Chou wrote:

> [BUG] Maybe.
> /u1/acc/linux/2.5.48/drivers/scsi/scsi_scan.c:1730:scsi_report_lun_scan:
> ERROR:LEAK:1706:1730:Memory leak [Allocated from:
> /u1/acc/linux/2.5.48/drivers/scsi/scsi_scan.c:1706:scsi_allocate_request]

This one seems fixed in 2.5 current.

> [BUG]
> u1/acc/linux/2.5.48/drivers/scsi/sr_ioctl.c:188:sr_do_ioctl:
> ERROR:LEAK:85:188:Memory leak [Allocated from:
> /u1/acc/linux/2.5.48/drivers/scsi/sr_ioctl.c:85:scsi_allocate_request]

Bug indeed, I've created a patch to fix the possible leak of
a scsi request, but can't figure out the bounce buffer logic...

> [BUG] Leaking tmp_ba
> /u1/acc/linux/2.5.48/drivers/scsi/st.c:3686:st_attach:
> ERROR:LEAK:3704:3686:Memory leak [Allocated from:
> /u1/acc/linux/2.5.48/drivers/scsi/st.c:3704:kmalloc]

Doesn't seem to be present in 2.5 current.

> [BUG] [GEM] The case where __dev_get_by_index() returns 0,
> followed by goto out.
> /u1/acc/linux/2.5.48/net/ipv4/route.c:2229:inet_rtm_getroute:
> ERROR:LEAK:2166:2229:Memory leak [Allocated from:
> /u1/acc/linux/2.5.48/net/ipv4/route.c:2166:alloc_skb]

Confirmed. I'll take a stab at fixing this one.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
