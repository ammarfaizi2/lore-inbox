Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbTGDI3j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 04:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265873AbTGDI3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 04:29:39 -0400
Received: from air-2.osdl.org ([65.172.181.6]:62860 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265871AbTGDI3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 04:29:37 -0400
Date: Fri, 4 Jul 2003 01:44:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: cfriesen@nortelnetworks.com, Andries.Brouwer@cwi.nl, akpm@digeo.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
Message-Id: <20030704014437.20a8d45e.akpm@osdl.org>
In-Reply-To: <3F05300E.AA26A021@pp.inet.fi>
References: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl>
	<3F0411B9.9E11022D@pp.inet.fi>
	<20030703082034.5643b336.akpm@osdl.org>
	<3F04680D.B9703696@pp.inet.fi>
	<3F046A30.6080509@nortelnetworks.com>
	<3F05300E.AA26A021@pp.inet.fi>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu <jari.ruusu@pp.inet.fi> wrote:
>
> Changing transfer function prototype may be a tiny speed improvement for one
>  implementation that happens to use unoptimal API, but at same time be tiny
>  speed degration to other implementations that use more saner APIs. I am
>  unhappy with that change, because I happen to maintain four such transfers
>  that would be subject to tiny speed degration.

Both the source and dest pages are being mapped with a sleeping kmap() at
present.  This way we can stop doing that, which is a significant saving on
highmem and a more significant saving on SMP highmem. (crypto uses kmap_atomic).

Why is the loop driver taking a copy of all the pages btw?  Looks to me
that we can just clone the bio and save an entire copy?

