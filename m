Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUBPKQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 05:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUBPKQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 05:16:13 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:63963 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S265494AbUBPKQH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 05:16:07 -0500
To: bcollins@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS in 2.4.25-rc1 -- video1394
Mail-Copies-To: never
X-Face: ,MPrV]g0IX5D7rgJol{*%.pQltD?!TFg(`c8(2pkt-F0SLh(g3mIFYU1GYf]C/GuUTbr;cZ5y;3ALK%.OL8A.^.PW14e/,X-B?Nv}2a9\u-j0sSa
References: <873c9kebhw.fsf@mirexpress.internal.placard.fr.eu.org>
	<20040209175731.GN1042@phunnypharm.org>
	<873c9j3nm4.fsf@mirexpress.internal.placard.fr.eu.org>
From: Roland Mas <roland.mas@free.fr>
Date: Mon, 16 Feb 2004 11:16:04 +0100
In-Reply-To: <873c9j3nm4.fsf@mirexpress.internal.placard.fr.eu.org> (Roland
 Mas's message of "Mon, 09 Feb 2004 23:16:19 +0100")
Message-ID: <87hdxrnxcr.fsf@mirexpress.internal.placard.fr.eu.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Mas, 2004-02-09 23:16:19 +0100 :

> Ben Collins, 2004-02-09 12:57:31 -0500 :
>
> [...]
>
>> Looks to me like it is failing in alloc_dma_iso_ctx(), and then
>> calling free_dma_iso_ctx() where it encounters some bad data. I
>> can't see off hand where this might happen. Was there any message
>> prior to this, like maybe a video1394 error message?
>
> There were messages before that, yes.  Here come bits of my kern.log.

[...]

>   If there's anything else I can povide, just say so, I just can't
> think of anything.

  I have new data: if I reduce the "Frame Buffers" (tooltip: "The
number of frames that will be buffered to prevent underrun")
configuration entry in Kino from 300 to 50, then Kino doesn't crash
and the kernel doesn't oops.  On the other hand, only three seconds
can be exported to the camcorder before what's transmitted becomes a
flashing blue/white screen, with small blocks of image transmitted
occasionnally.  During the same time, top(1) displays my XFree86
process as using a very large amount of CPU (more than 95%, and load
indeed goes from about 0 to about 1).  Since my CPU *should* be fast
enough (Athlon 2200+, 1 GB of RAM), I now think the bug is at least
partially in userspace.  If you have ideas on how to debug further,
I'd be glad to hear about them, otherwise I'll turn my attention to
Kino's maintainer and/or author.  My personal (hence probably wrong)
interpretation is that Kino tried to allocate lots and lots of space
for its 300 buffers, doesn't check the result, and tries to access the
freshly (non-)allocated space.

  I still think the kernel shouldn't oops, but if I can find a
userspace fix, I won't mind that much :-)

Roland.
-- 
Roland Mas

- Ogenki desuka, yau de poêle ?
- Genki desu, ture en zinc.
