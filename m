Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTDRALe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 20:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbTDRALe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 20:11:34 -0400
Received: from [12.47.58.203] ([12.47.58.203]:48891 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262703AbTDRALd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 20:11:33 -0400
Date: Thu, 17 Apr 2003 17:22:12 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct loop_info
Message-Id: <20030417172212.02e0e3a1.akpm@digeo.com>
In-Reply-To: <UTC200304172334.h3HNYgI06614.aeb@smtp.cwi.nl>
References: <UTC200304172334.h3HNYgI06614.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Apr 2003 00:23:22.0802 (UTC) FILETIME=[B8811920:01C30540]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
> Until now as the source already says, we had a very unpleasant
> situation with struct loop_info:

This patch makes me pull faces, sorry.

a) The name "loop_info2" is meaningless.  Something like loop_info64 would
   communicate something to the reader.

b) It is impossible for the reader to tell _why_ loop_info and loop_info2
   exist.  

   It will be especially mysterious in 2.8, where there is no loop_info,
   only a loop_info2.

   Hence covering commentary is compulsory.

c) Could we not save a lot of noise by putting:

	typedef unsigned short legacy_dev_t;	/* <= linux-2.4.x */

   into asm/posix_types.h and then keep all this stuff just in
   <linux/loop.h>?

d) Would it be possible to just add a u64 to the _end_ of the existing
   loop_info and, in the legacy ioctl(), simply massage it?
