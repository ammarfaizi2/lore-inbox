Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267617AbUBTATo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUBTATo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:19:44 -0500
Received: from mail.shareable.org ([81.29.64.88]:26240 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267626AbUBTAPP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:15:15 -0500
Date: Fri, 20 Feb 2004 00:13:47 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Clayton Weaver <cgweav@email.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stty utf8
Message-ID: <20040220001347.GB5590@mail.shareable.org>
References: <20040219185347.A94A23CE24D@ws3-4.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219185347.A94A23CE24D@ws3-4.us4.outblaze.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clayton Weaver wrote:
> In an application that is taking input in utf-8,
> if I want to search, compare, yada yada, I need
> to convert to wchar_t first (for iswspace() et al),

No, most search and compare operations are done directly on UTF-8,
and it's much more efficient to do that than convert to wchar_t.

> Why would not terminals do the same thing?

Because they're made of logic chips which you can't change now, have
ROMs, must be compatible with the VT100 and ANSI escape sequences,
must run over an 8-bit channel...

Mostly because that's the way terminals are.  You could design a _new_
terminal protocol but it's not going to be useful because you want to
talk with the existing terminals.

> Done that way, Jamie's delete example is
> backspace-space-backspace and remove sizeof(wchar_t)
> from the input.

You could store wchar_t in the terminal queue, but what would be the
point?  Removing a UTF-8 character from the input is _trivial_.

> Ok, it takes more space than operating on the utf-8
> encoding directly, but otherwise why not?

Because there's no point.

-- Jamie
