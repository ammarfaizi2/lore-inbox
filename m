Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263753AbTIBRwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263833AbTIBRuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:50:11 -0400
Received: from holomorphy.com ([66.224.33.161]:14210 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263753AbTIBRVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:21:45 -0400
Date: Tue, 2 Sep 2003 10:22:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Petri Koistinen <petri.koistinen@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sparse warning: bitmap.h: bad constant expression
Message-ID: <20030902172248.GL4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Petri Koistinen <petri.koistinen@iki.fi>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0309012249230.14789@dsl-hkigw4a35.dial.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0309012249230.14789@dsl-hkigw4a35.dial.inet.fi>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 10:59:21PM +0300, Petri Koistinen wrote:
> If I try to compile latest kernel with "make C=1" I'll get many warning
> messages from sparse saying:
> warning: include/linux/bitmap.h:85:2: bad constant expression
> warning: include/linux/bitmap.h:98:2: bad constant expression
> Sparse doesn't seem to like DECLARE_BITMAP macros.
> #define DECLARE_BITMAP(name,bits) \
>         unsigned long name[BITS_TO_LONGS(bits)]
> So what is wrong with this and how it could be fixed so that sparse
> wouldn't complain?

Basically, this thing is intended to be used with a constant bits
argument that's constant folded etc. at all times, but sparse doesn't
know that.

One way to deal with it is to turn the thing into a giant macro.


-- wli
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Mon, Sep 01, 2003 at 10:59:21PM +0300, Petri Koistinen wrote:
> If I try to compile latest kernel with "make C=1" I'll get many warning
> messages from sparse saying:
> warning: include/linux/bitmap.h:85:2: bad constant expression
> warning: include/linux/bitmap.h:98:2: bad constant expression
> Sparse doesn't seem to like DECLARE_BITMAP macros.
> #define DECLARE_BITMAP(name,bits) \
>         unsigned long name[BITS_TO_LONGS(bits)]
> So what is wrong with this and how it could be fixed so that sparse
> wouldn't complain?

Basically, this thing is intended to be used with a constant bits
argument that's constant folded etc. at all times, but sparse doesn't
know that.

One way to deal with it is to turn the thing into a giant macro.


-- wli
