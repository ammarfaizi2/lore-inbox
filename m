Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313200AbSC1RyY>; Thu, 28 Mar 2002 12:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313196AbSC1RyV>; Thu, 28 Mar 2002 12:54:21 -0500
Received: from air-2.osdl.org ([65.201.151.6]:3200 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S313197AbSC1RyM>;
	Thu, 28 Mar 2002 12:54:12 -0500
Date: Thu, 28 Mar 2002 09:53:52 -0800
From: Bob Miller <rem@osdl.org>
To: Adam Kropelin <akropel1@rochester.rr.com>, davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.7-dj2] Compile Error
Message-ID: <20020328095352.A6291@doc.pdx.osdl.net>
In-Reply-To: <200203281216.32590@xsebbi.de> <00c801c1d655$d8e75cd0$02c8a8c0@kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2002 at 07:41:14AM -0500, Adam Kropelin wrote:
> ----- Original Message -----
> From: "Sebastian Roth" <xsebbi@gmx.de>
> To: <linux-kernel@vger.kernel.org>
> Sent: Thursday, March 28, 2002 6:17 AM
> Subject: [2.5.7-dj2] Compile Error
> 
> 
> > Hi there,
> >
> > make bzImage says:
> > make[1]: Entering directory `/usr/src/linux-2.5-dj/kernel'
> > make all_targets
> > make[2]: Entering directory `/usr/src/linux-2.5-dj/kernel'
> > gcc -D__KERNEL__ -I/usr/src/linux-2.5-dj/include -Wall
> > -Wstrict-prototypes -Wno-
> > trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> > -pipe -mpref
> > erred-stack-boundary=2 -march=i686 -malign-functions=4
> > -DKBUILD_BASENAME=acct
> >   -c -o acct.o acct.c
> > acct.c:235: parse error before `do'
> > acct.c:378: parse error before `do'
> > acct.c:384: parse error before `&'
> 
> <snip>
> 
> I'm a "me too" on this.
> 
> I see some discussion a few days ago where Grega Fajdiga had the same problem on
> stock 2.5.7. There didn't seem to be a resolution other than Bob Miller saying:
> 
> > You have CONFIG_BSD_PROCESS_ACCT not set
> > but the compile errors you're getting are for code in acct.c that
> > will only compile if CONFIG_BSD_PROCESS_ACCT is SET.
> 
> Same is true here except stock 2.5.7 *does* compile and -dj2 does not. Same
> config modulo symbol differences.
> 
> Downloaded multiple times, made mrproper, etc.
> 
> Failing .config for -dj2 is below.
> 
> --Adam
> 
> CONFIG_X86=y

Stuff deleted...

In looking at kernel/acct.c it looks like someone tried to change acct.c
to no longer conditionally compile based on CONFIG_BSD_PROCESS_ACCT.
The problem is that other files that conditionally compile with
CONFIG_BSD_PROCESS_ACCT (include/linux/acct.h and others) where not changed.

So if you build with CONFIG_BSD_PROCESS_ACCT not set you're build will
break.  I'm in the process of generating a patch that will make acct.c
again conditionally compile based on CONFIG_BSD_PROCESS_ACCT.  This
should be done in a little bit and I'll post.

Dave, where did you get the patch for acct.c?

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
