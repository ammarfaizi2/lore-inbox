Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266036AbUALD0K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 22:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266037AbUALD0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 22:26:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:40428 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266036AbUALD0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 22:26:07 -0500
Date: Sun, 11 Jan 2004 18:58:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Lennert Buytenhek <buytenh@gnu.org>
cc: Felix von Leitner <felix-kernel@fefe.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 sendfile regression
In-Reply-To: <20040110052304.GA25346@gnu.org>
Message-ID: <Pine.LNX.4.58.0401111509360.1825@evo.osdl.org>
References: <20040110000128.GA301@codeblau.de> <20040110052304.GA25346@gnu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Jan 2004, Lennert Buytenhek wrote:

> On Sat, Jan 10, 2004 at 01:01:28AM +0100, Felix von Leitner wrote:
> 
> > strace shows that the process is hanging
> > inside sendfile64 (which should not happen since the socket is
> > non-blocking).
> 
> What if the data you're sending is not in the page cache?

It will always block on the actual page cache, although we could try to 
change that. However, even if it blocks, it should only block at one page 
at a time (or "incidental" blockage due to memory allocations etc).

Blocking for long times implies a bug.

		Linus
