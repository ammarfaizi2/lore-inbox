Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbUAHCsD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUAHCsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:48:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:43441 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263598AbUAHCrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:47:55 -0500
Date: Wed, 7 Jan 2004 18:47:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <juhl@dif.dk>
cc: linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] fs/fcntl.c - remove impossible <0 check in do_fcntl -
 arg is unsigned.
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BC074B2059@difpst1a.dif.dk>
Message-ID: <Pine.LNX.4.58.0401071846160.2131@home.osdl.org>
References: <8A43C34093B3D5119F7D0004AC56F4BC074B2059@difpst1a.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Jan 2004, Jesper Juhl wrote:
> 
> The 'arg' argument to the function do_fcntl in fs/fcntl.c is of type
> 'unsigned long', thus it can never be less than zero (all callers of
> do_fcntl take unsigned arguments as well and pass on unsigned values),

I'm not sure I like these kinds of patches.

I _like_ the code being readable. The fact that the compiler can optimize 
away one of the tests if the type is right is fine. It seems to be 
draconian to remove code that is correct and safe, especially when the 
code has no real downsides to it.

Do we have a compiler that needlessly complains again? 

Sometimes it is the _complaints_ that are bogus. 

		Linus
