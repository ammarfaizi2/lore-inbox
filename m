Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSGVCP2>; Sun, 21 Jul 2002 22:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315513AbSGVCP2>; Sun, 21 Jul 2002 22:15:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37639 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315503AbSGVCP2>;
	Sun, 21 Jul 2002 22:15:28 -0400
Message-ID: <3D3B6D57.BB5C0F38@zip.com.au>
Date: Sun, 21 Jul 2002 19:26:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Lord <lord@sgi.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT read and holes in 2.5.26
References: <1026981790.1258.17.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Lord wrote:
> 
> Andrew,
> 
> Did you realize that the new O_DIRECT code in 2.5 cannot read over holes
> in a file.

Well that was intentional, although I confess to not having
put a lot of thought into the decision.  The user wants
O_DIRECT and we cannot do that.  The CPU has to clear the
memory by hand.  Bad.

Obviously it's easy enough to put in the code to clear the
memory out.  Do you think that should be done?
  
>  The old code filled the user buffer with zeros, the new code
> returned EINVAL if the getblock function returns an unmapped buffer.
> With this exception, XFS does work with the new code - with more cpu
> overhead than before due to the once per page getblock calls.

OK, thanks.  Presumably XFS has a fairly heavyweight get_block()?

I'd be interested in seeing just how expensive that O_DIRECT
I/O is, and whether we need to get down and implement a
many-block get_block() interface.  Any numbers/profiles
available?

-
