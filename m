Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317986AbSHHV1P>; Thu, 8 Aug 2002 17:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317994AbSHHV1P>; Thu, 8 Aug 2002 17:27:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45834 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317986AbSHHV1O>; Thu, 8 Aug 2002 17:27:14 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Date: 8 Aug 2002 14:30:35 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aiuntr$80g$1@cesium.transmeta.com>
References: <3D51A7DD.A4F7C5E4@zip.com.au> <Pine.LNX.4.44.0208081312330.8705-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0208081312330.8705-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> Guys, this discussion is getting ridiculous.
> 
> Doing a bit allocator should be trivial, but it's hard to know when a bit
> is to be free'd. You can't just do it at "exit()" time, because even if
> pid X exits, that doesn't mean that X can be re-used: it may still be used
> as a pgid or a tid by some other process Y.
> 
> So if you really want to take this approach, you need to count the uses of
> "pid X", and free the bitmap entry only when that count goes to zero. I
> see no such logic in Bill Irwin's code, only a comment about last use
> (which doesn't explain how to notice that last use).
> 

Even so, we need to maintain Not Recently Used semantic.  A discussion
on #kernel seems to have ended up with recommending a design target of
"no pid reuse within 30 seconds", with 1 second being an absolute
requirement.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
