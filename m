Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbTIBB4c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 21:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263412AbTIBB4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 21:56:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:43662 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263411AbTIBB4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 21:56:31 -0400
Date: Mon, 1 Sep 2003 18:57:02 -0700
From: Dave Olien <dmo@osdl.org>
To: Petri Koistinen <petri.koistinen@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sparse warning: bitmap.h: bad constant expression
Message-ID: <20030902015702.GA10265@osdl.org>
References: <Pine.LNX.4.56.0309012249230.14789@dsl-hkigw4a35.dial.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0309012249230.14789@dsl-hkigw4a35.dial.inet.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem seems to be that sparse currently will only accept array
declarations with a size that can be evaluated at compile time to
a fixed value.  So an array declaration of the form:

int asize;
int data[asize];

will fail.  sparse needs to be modified to recognize this type of 
declaration with a variable array size.  That'll take a few hours of
someone's time to fix.

On Mon, Sep 01, 2003 at 10:59:21PM +0300, Petri Koistinen wrote:
> Hi!
> 
> If I try to compile latest kernel with "make C=1" I'll get many warning
> messages from sparse saying:
> 
> warning: include/linux/bitmap.h:85:2: bad constant expression
> warning: include/linux/bitmap.h:98:2: bad constant expression
> 
> Sparse doesn't seem to like DECLARE_BITMAP macros.
> 
> #define DECLARE_BITMAP(name,bits) \
>         unsigned long name[BITS_TO_LONGS(bits)]
> 
> So what is wrong with this and how it could be fixed so that sparse
> wouldn't complain?
> 
> Best regards,
> Petri Koistinen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
