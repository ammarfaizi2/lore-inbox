Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264285AbUAHLGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 06:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUAHLGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 06:06:14 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:34548 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264285AbUAHLGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 06:06:10 -0500
Date: Thu, 8 Jan 2004 03:07:17 -0800
From: Paul Jackson <pj@sgi.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, matthew@wil.cx
Subject: Re: [PATCH] fs/fcntl.c - remove impossible <0 check in do_fcntl -
 arg is unsigned.
Message-Id: <20040108030717.1e39f9f3.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.56.0401081034200.10083@jju_lnx.backbone.dif.dk>
References: <8A43C34093B3D5119F7D0004AC56F4BC074B2059@difpst1a.dif.dk>
	<Pine.LNX.4.58.0401071846160.2131@home.osdl.org>
	<Pine.LNX.4.56.0401081034200.10083@jju_lnx.backbone.dif.dk>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper wrote:
> I can't argue with that, but I don't think this patch actually decreases
> readabillity. It's still perfectly clear what the remaining code does, and
> if anybody is wondering if 'arg' could ever be <0 then a quick glance at
> the type will answer that.

The basic thought likely to go through the head of someone first
thinking about this bit of logic is that arg has to be between 0 and
_NSIG to be valid.  It then requires a second thought to realize that
since arg is 0, you don't have to check explicitly for arg < 0.

Everytime we can avoid requiring 'a second thought', we (feable minded
humans) win.


> Would you like this sort of patch better if removing the code went
> hand-in-hand with the addition of a one-line comment stating something
> like  /* the test for arg < 0 is not done since arg is unsigned */ or ?

No - such a comment doesn't remove the 'second thought' in this case.
Rather, it emphasizes it.

It is the sort of comment that (1) I find myself writing often, and then
(2) later replacing with code that renders the comment irrelevant.

It's one of those little "reader beware" (caveat lector) comments that
often mark places where a little code refinement can remove a comment.
Whenever a comment that explains why something is or is not done or is
special cased can be replaced with code that just does (or doesn't do)
it or doesn't need a special case, with no loss of form, fit, function
or performance, that's likely a win-win.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
