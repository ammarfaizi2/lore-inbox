Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbTGBRBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 13:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTGBRBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 13:01:32 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:9557 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264082AbTGBRBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 13:01:24 -0400
Date: Wed, 2 Jul 2003 10:16:19 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cryptoloop
Message-Id: <20030702101619.52077009.akpm@digeo.com>
In-Reply-To: <UTC200307021521.h62FLbw16702.aeb@smtp.cwi.nl>
References: <UTC200307021521.h62FLbw16702.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2003 17:15:46.0682 (UTC) FILETIME=[93A8DDA0:01C340BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
> +static int
>  +cryptoloop_transfer(struct loop_device *lo, int cmd, char *raw_buf,
>  +		     char *loop_buf, int size, sector_t IV)

You'll note that loop.c goes from (page/offset/len) to (addr/len), and this
transfer function then immediately goes from (addr,len) to
(page/offset/len).

That's rather silly, and it forces the loop driver to play games pushing
pages into lowmem.

Can we keep everything using (page/offset/len) end-to-end?


