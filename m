Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUAEEg6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 23:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUAEEg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 23:36:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:50850 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262794AbUAEEg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 23:36:56 -0500
Date: Sun, 4 Jan 2004 20:36:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
In-Reply-To: <3FF8E4C8.1070604@tmr.com>
Message-ID: <Pine.LNX.4.58.0401042028140.2162@home.osdl.org>
References: <bsgav5$4qh$1@cesium.transmeta.com> <Pine.LNX.4.58.0312252021540.14874@home.osdl.org>
 <3FF5E952.70308@tmr.com> <m365fsu48n.fsf@defiant.pm.waw.pl> <3FF7A910.40703@tmr.com>
 <Pine.LNX.4.58.0401041232440.2162@home.osdl.org> <3FF8BDBB.4060708@tmr.com>
 <Pine.LNX.4.58.0401041824150.2162@home.osdl.org> <3FF8E4C8.1070604@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Jan 2004, Bill Davidsen wrote:
> 
> Your example, which I quoted, *is* standard C. And it avoids duplication 
> of code without extra variables, and is readable. We both agreed it was 
> standard, why have you canged your mind?

Oh, that one. I thought you were talking about the gcc extension.

My version is not what I'd call really readable unless you actually have 
an agenda to access the variable though a pointer. In fact, the only case 
where I have actually seen constructs like that is literally when you want 
to avoid a branch for some specific reason, and you do something like 
this:

	int branchless_code(int *ptr)
	{
		int dummy;

		...
		*(ptr ? ptr : &dummy) = value;
		...
	}

it you'd rather do a unconditional store through a conditional pointer 
than have a conditional store, and you use a dummy "sink" variable to take 
the store if the condition isn't true.

Some compilers apparently generate this kind of code internally from
conditional statements. I've never seen gcc do it, though.

		Linus
