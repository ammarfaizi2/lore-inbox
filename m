Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135275AbRDLTcd>; Thu, 12 Apr 2001 15:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135276AbRDLTcW>; Thu, 12 Apr 2001 15:32:22 -0400
Received: from ns.caldera.de ([212.34.180.1]:5395 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S135278AbRDLTbu>;
	Thu, 12 Apr 2001 15:31:50 -0400
Date: Thu, 12 Apr 2001 21:31:40 +0200
Message-Id: <200104121931.VAA02438@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: Wayne.Brown@altec.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: badly punctuated parameter list in `#define' (2.4.3-ac5 and 2.4.4 -pre2)
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <86256A2C.0068BA0C.00@smtpnotes.altec.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <86256A2C.0068BA0C.00@smtpnotes.altec.com> you wrote:
>
> When compiling 2.4.3-ac5 (and also 2.4.4-pre2) I get this:
>
> /usr/src/linux-2.4.3-ac5/include/asm/rwsem.h:26: badly punctuated parameter list
>  in `#define'
>
> This appears to be due to some code in rwsem.h that is written for a different
> version of gcc. (I'm still using gcc-2.91.66 as specified in
> Documentation/Changes.)  It works for me if I replace it with the code in the
> section labeled /* old gcc */.  Here's a patch to do that:

So the /* old gcc */ part should probably be enabled based on a define for the
old compiler.  The right ifdef seems to be:

  #if __GNUC__ == 2 && __GNUC_MINOR__ < 95

Could you test it this way?

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
