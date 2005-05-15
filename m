Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVEOMdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVEOMdU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 08:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbVEOMdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 08:33:20 -0400
Received: from [61.48.53.251] ([61.48.53.251]:38375 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261618AbVEOMdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 08:33:14 -0400
Date: Sun, 15 May 2005 04:22:19 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200505151122.j4FBMJa01073@adam.yggdrasil.com>
To: mpm@selenic.com, pasky@ucw.cz
Subject: Re: Mercurial 0.4e vs git network pull
Cc: git@vger.kernel.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       mercurial@selenic.com, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 May 2005 10:54:05 +0200, Petr Baudis wrote:
>Dear diary, on Thu, May 12, 2005 at 10:57:35PM CEST, I got a letter
>where Matt Mackall <mpm@selenic.com> told me that...
>> Does this need an HTTP request (and round trip) per object? It appears
>> to. That's 2200 requests/round trips for my 800 patch benchmark.

>Yes it does. On the other side, it needs no server-side CGI. But I guess
>it should be pretty easy to write some kind of server-side CGI streamer,
>and it would then easily take just a single HTTP request (telling the
>server the commit ID and receiving back all the objects).

	I don't understand what was wrong with Jeff Garzik's previous
suggestion of using http/1.1 pipelining to coalesce the round trips.
If you're worried about queuing too many http/1.1 requests, the client
could adopt a policy of not having more than a certain number of
requests outstanding or perhaps even making a new http connection
after a certain number of requests to avoid starving other clients
when the number of clients doing one of these transfers exceeds the
number of threads that the http server uses.

	Being able to do without a server side CGI script might
encourage deployment a bit more, both for security reasons and
effort of deployment.

	In any case, using httpd or ftp makes it easier to deploy
servers in cases where it might be harder to modify firewall rules,
so I am glad to see that, even if it is through a CGI script.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
