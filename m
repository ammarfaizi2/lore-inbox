Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSKHUQb>; Fri, 8 Nov 2002 15:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbSKHUQb>; Fri, 8 Nov 2002 15:16:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43023 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261310AbSKHUQ2>; Fri, 8 Nov 2002 15:16:28 -0500
Date: Fri, 8 Nov 2002 12:19:20 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Douglas Gilbert <dougg@torque.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: sscanf("-1", "%d", &i) fails, returns 0
In-Reply-To: <Pine.LNX.4.33L2.0211081153480.32726-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0211081211141.4471-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 Nov 2002, Randy.Dunlap wrote:
?
> Sure, it looks cleaner that way, although gcc has already put <*dig>
> in a local register; i.e., it's not pulled from memory for each test.
> Here's a (tested) version that does that.

Why do you have that "dig" pointer at all? It's not really used.

Why not just do

	+	char digit;
	...

	+	digit = str;
	+	if (digit == '-')
	+		digit = str[1];


(and maybe it should also test for whether signed stuff is even alloed or 
not, ie maybe the test should be "if (is_sign && digit == '-')" instead)

		Linus

