Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266153AbUALLcR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 06:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266156AbUALLcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 06:32:17 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:22472 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S266153AbUALLcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 06:32:16 -0500
Date: Mon, 12 Jan 2004 06:31:23 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Felix von Leitner <felix-kernel@fefe.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 sendfile regression
Message-ID: <20040112113123.GA18485@gnu.org>
References: <20040110000128.GA301@codeblau.de> <20040110052304.GA25346@gnu.org> <Pine.LNX.4.58.0401111509360.1825@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401111509360.1825@evo.osdl.org>
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 06:58:55PM -0800, Linus Torvalds wrote:

> > > strace shows that the process is hanging
> > > inside sendfile64 (which should not happen since the socket is
> > > non-blocking).
> > 
> > What if the data you're sending is not in the page cache?
> 
> It will always block on the actual page cache, although we could try to 
> change that.

My impression is that this is the reason why AIO sendfile was attempted.
Although my wild guess is that that probably would only work on raw block
devices and still not on regular filesystem files.


> However, even if it blocks, it should only block at one page 
> at a time (or "incidental" blockage due to memory allocations etc).
> 
> Blocking for long times implies a bug.

(Even if it only blocks a page at a time, it will happily block on the
next page and the one after that as long as there is write space in the
destination socket?)


--L
