Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289809AbSAPCKs>; Tue, 15 Jan 2002 21:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289813AbSAPCKj>; Tue, 15 Jan 2002 21:10:39 -0500
Received: from w240.z209220232.was-dc.dsl.cnc.net ([209.220.232.240]:13840
	"EHLO yendi.dmeyer.net") by vger.kernel.org with ESMTP
	id <S289817AbSAPCK1>; Tue, 15 Jan 2002 21:10:27 -0500
Date: Tue, 15 Jan 2002 21:10:21 -0500
From: dmeyer@dmeyer.net
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
Message-ID: <20020115211021.A32400@jhereg.dmeyer.net>
Reply-To: dmeyer@dmeyer.net
In-Reply-To: <20020116013811.E5235@khan.acc.umu.se> <Pine.LNX.4.33.0201151639320.1213-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Newsgroups: local.linux.kernel
In-Reply-To: <20020116015513.L32088@suse.de>
Organization: dmeyer.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020116015513.L32088@suse.de> you write:
> On Tue, Jan 15, 2002 at 04:41:08PM -0800, Linus Torvalds wrote:
>  > > #ifndef _LINUX_POSIX_TYPES_H   /* __FD_CLR */
>  > > #include <linux/posix_types.h>
>  > > #endif
>  > If this actally makes any noticeable difference to compilation speed I
>  > could live with it. Does it?
> 
>  I'm sure I read somewhere that gcc is clever enough to know
>  when it hits a #include, it checks for a symbol equal to a
>  mangled version of the filename before including it.
>  (Ie, doing this transparently).
> 
>  Then again, I may have imagined it all.

I'm pretty sure you did, since it's perfectly legal (and occasionally
useful, if gruesome) to do

#define THE_STRUCT struct1
#include "struct_def.h"
#undef THE_STRUCT
#define THE_STRUCT struct2
#include "struct_def.h"

and have both #includes work.  You may be thinking of #import, which
is deprecated except for objective-c, IIRC.

In answer to Linus' question...yes, in a large system redundent
include guards can make a real difference, particularly for headers
which get included by other headers regularly.  OTOH, my last
experience using them was on an underpowered Solaris box, which (a)
didn't have enough memory for all the developers compiling on it and
(b) was running an old Solaris, so its read caching was pretty lame
anyway.  It makes rather a lot of difference if the preprocessor has
to read <linux/posix_types.h> from the disk 20 times or if it can get
it from the file cache 20 times.

-- 
Dave Meyer
dmeyer@dmeyer.net
