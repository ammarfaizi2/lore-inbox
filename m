Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132487AbRCZQtn>; Mon, 26 Mar 2001 11:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132466AbRCZQtd>; Mon, 26 Mar 2001 11:49:33 -0500
Received: from marine.sonic.net ([208.201.224.37]:23667 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S132491AbRCZQtR>;
	Mon, 26 Mar 2001 11:49:17 -0500
X-envelope-info: <dhinds@sonic.net>
Message-ID: <20010326084809.A11493@sonic.net>
Date: Mon, 26 Mar 2001 08:48:09 -0800
From: David Hinds <dhinds@sonic.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 aic7xxx breaks pcmcia
In-Reply-To: <22779.985590853@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <22779.985590853@ocs3.ocs-net>; from Keith Owens on Mon, Mar 26, 2001 at 05:14:13PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2001 at 05:14:13PM +1000, Keith Owens wrote:
> 2.2.19 Documentation/Changes says pcmcia-cs 3.0.14.  I am using 3.1.21
> and it breaks if you compile the kernel with scsi support then try to
> compile pcmcia.  clients/apa1480_stub.c in 3.1.21 has
>   #include <../drivers/scsi/aic7xxx.h>
> but in 2.2.19 that file is drivers/scsi/aic7xxx/aic7xxx.h.  You need at
> least pcmcia-cs 3.1.25 for kernel 2.2.19 with scsi support.

Correct.  It is not just the header file that is at issue, though; the
whole build procedure for the aic7xxx driver changed.

> In the kernel and associated utilities I want to remove lines like
>   #include <../drivers/scsi/aic7xxx.h>
> and replace them with
>   #include "aic7xxx.h"
> with the Makefile specifying -I $(TOPDIR)/drivers/scsi (2.2.18) or -I
> $(TOPDIR)/drivers/scsi/aic7xxx (2.2.19).  Hard coding long path names
> for #include is bad, especially when they contain '..'.  It stops
> kernel developers moving code around and makes it difficult to do some
> of the things I plan for the 2.5 Makefile rewrite.  David, how easy
> would it be to change pcmcia to this style of include?

It would not be too hard to do what you suggest, but would make for
very long CPPFLAGS.  Which is inconvenient if you like to actually see
what's going on when you do a build.  I think more of the include
files at issue should probably be in the kernel include tree, and not
hidden in the driver tree.  That would make the issue moot.

What are the things you're planning that will cause trouble?  I would
also think it would be less of an issue with 2.5 if there is some hope
that in-kernel PCMCIA is going to be the standard.

-- Dave
