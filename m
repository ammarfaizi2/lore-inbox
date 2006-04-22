Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWDVTw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWDVTw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWDVTw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:52:57 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:12228 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751104AbWDVTw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:52:56 -0400
Subject: Re: [PATCH] 'make headers_install' kbuild target.
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
In-Reply-To: <20060422132032.GB5010@stusta.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org>
	 <20060422093328.GM19754@stusta.de>
	 <1145707384.16166.181.camel@shinybook.infradead.org>
	 <20060422123835.GA5010@stusta.de>
	 <1145710123.11909.241.camel@pmac.infradead.org>
	 <20060422132032.GB5010@stusta.de>
Content-Type: text/plain
Date: Sat, 22 Apr 2006 14:36:04 +0100
Message-Id: <1145712964.11909.258.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 15:20 +0200, Adrian Bunk wrote:
> Why can't the splitting happen incrementally?

It can, and has already started that way. There's no reason why the
'make headers_export' mechanism can't work with that -- it already does,
because it exports the include/mtd directory and nothing from
include/linux/mtd -- as I said, ideally the mechanism ends up being just
'cp -a' on certain directories. And then it can be abolished. We've got
a long way to go before we get there, though.

> Assume you have a header include/linux/foo.h:
> - Add an #include <kabi/linux/foo.h> at the top.
> - Move the part of the contents that is part of the userspace ABI to 
>   include/kabi/linux/foo.h.

Absolutely. That's what I've done with MTD headers already, although the
directory names are different. The directory names don't _matter_
either, because important part was that the files themselves are cleaned
up.

Linus isn't keen on splitting it into a new directory, and I don't want
to start off by demanding that. As I said, the important part of the
above is the bit where one of us goes to the file with an editor and
identifies the public parts vs. the private parts, then splits them up
-- possibly with #ifdef __KERNEL__, but _preferably_ into separate
files. And it doesn't _matter_ which directories we put those files
into, for now. I don't want to talk about it _yet_ because it's just
taking attention away from the real problem.

The more we screw around with such minutiae, the less likely we are to
get traction with Linus -- despite the fact that almost everyone who's
expressed an opinion is _agreeing_ with you about where we want to end
up.

We need to keep it simple and unintrusive to start with. Concentrate on
the _contents_ and then we can deal with the less important details
later.

-- 
dwmw2

