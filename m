Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264226AbUEDEOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbUEDEOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 00:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUEDEOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 00:14:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:23975 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264226AbUEDEOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 00:14:52 -0400
Date: Mon, 3 May 2004 21:14:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: errno
In-Reply-To: <1083634011.952.154.camel@cube>
Message-ID: <Pine.LNX.4.58.0405032111450.1636@ppc970.osdl.org>
References: <1083634011.952.154.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 May 2004, Albert Cahalan wrote:
> 
> The obvious fix would be to stuff errno into the
> task_struct, hmmm?

No. "errno" is one of those fundamentally broken things that should not 
exist. It was wrogn in original UNIX, it's wrong now.

The kernel usage comes not from the kernel wanting to use it per se (the 
kernel has always used the "negative error" approach), but from some 
misguided kernel modules using the user-space interfaces.

The Linux way of returning negative error numbers is much nicer. It's
inherently thread-safe, and it has no performance downsides. Of course, it
does depend on having enough of a result domain that you can always
separate error returns from good returns, but that's true in practice for
all system calls.

Too bad we can't fix broken calling conventions.

		Linus
