Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266567AbUGPUPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266567AbUGPUPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 16:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266570AbUGPUPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 16:15:31 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:52237 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266567AbUGPUP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 16:15:29 -0400
Date: Fri, 16 Jul 2004 22:15:23 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
Message-ID: <20040716201523.GC5518@pclin040.win.tue.nl>
References: <87llhjlxjk.fsf@devron.myhome.or.jp> <20040716164435.GA8078@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040716164435.GA8078@ucw.cz>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: COLLEGEOFNEWCALEDONIA: mailhost.tue.nl 1189; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2004 at 01:35:59AM +0900, OGAWA Hirofumi wrote:

:: KDGKBENT ioctl can use 256 entries (0-255), but it was defined as
:: key_map[NR_KEYS] (NR_KEYS == 255). The code seems also thinking it's 256.
:: 
:: 	key_map[0] = U(K_ALLOCATED);
:: 	for (j = 1; j < NR_KEYS; j++)
:: 		key_map[j] = U(K_HOLE);

I think the code has no opinion. It was 128 in 2.4.
I am not aware of assumptions on NR_KEYS.
So, do not think this is an off-by-one error.
Vojtech did this intentionally.

However, I have no objections. In fact loadkeys uses 256.

On Fri, Jul 16, 2004 at 06:44:35PM +0200, Vojtech Pavlik wrote:

> The patch might cause problems, though, because some apps may (in
> old versions are) using a char variable to index up to NR_KEYS,
> which leads to an endless loop.

The binaries will still work. If the utility is recompiled, against
recent kernel headers, then the person doing that is responsible
for the result.

I just checked kbd, but there are no such char variables there.
Do you have specific utilities in mind? Is X OK?

Andries
