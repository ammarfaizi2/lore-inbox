Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030527AbWAGSHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030527AbWAGSHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 13:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030526AbWAGSHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 13:07:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55196 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030524AbWAGSHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 13:07:14 -0500
Date: Sat, 7 Jan 2006 10:07:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: sparse triggers OOM killer
In-Reply-To: <20060107111827.GA16133@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0601071004130.3169@g5.osdl.org>
References: <20060107111827.GA16133@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Jan 2006, Sam Ravnborg wrote:
> 
> There was no oops or similar and sparse just exited after a while with
> an errorcode (137).

That's just SIGKILL (128+9). Which is normal for the OOM killer.

> Now I wonder if I have hit a bug in sparse or this is what I should
> expect.

Well, sparse does keep a _lot_ of stuff in memory, and the "do many files 
at once" will basically keep every single one (with full types, full 
linearization etc) in memory at the same time.

It's probably fairly easy to fix: I should just make sparse release all 
the linearizations and symbols when they go out of file scope.

The "do many files at once" thing really was just a quick hack, so the 
lack of memory release is not that susprising.

I'll see what I can do.

		Linus
