Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbTLZHIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 02:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbTLZHIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 02:08:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:26290 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264920AbTLZHIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 02:08:35 -0500
Date: Thu, 25 Dec 2003 23:08:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andy Isaacson <adi@hexapodia.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
In-Reply-To: <20031226005840.A30827@hexapodia.org>
Message-ID: <Pine.LNX.4.58.0312252303090.14874@home.osdl.org>
References: <1072403207.17036.37.camel@clubneon.clubneon.com>
 <bsgav5$4qh$1@cesium.transmeta.com> <Pine.LNX.4.58.0312252021540.14874@home.osdl.org>
 <20031226005840.A30827@hexapodia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Dec 2003, Andy Isaacson wrote:
> 
> But doesn't the first one potentially let the compiler avoid spilling to
> memory, if b and c are both in registers?

Sure, and you can do it as

	tmp = d;
	a ? b = tmp : c = tmp;

instead if you want to. It all depends on what b/c actually are (ie maybe
they are memory-backed anyway).

The point being that there are no actual _advantages_ to being
non-standard. And there are definitely disadvantages. Lack of portability
being one, semantic confusion being another (the semantic confusion is
more visible in C++, since there lvalue'ness is more complex. But it's
visible in C too, where the gcc extensions can cause buggy programs that
_should_ give syntax errors to possibly compile to unexpected results).

		Linus
