Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSGUNLd>; Sun, 21 Jul 2002 09:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSGUNLd>; Sun, 21 Jul 2002 09:11:33 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:55001 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S314451AbSGUNLd>;
	Sun, 21 Jul 2002 09:11:33 -0400
Date: Sun, 21 Jul 2002 15:14:21 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Mark Spencer <markster@linux-support.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Zaptel Pseudo TDM Bus
Message-ID: <20020721151421.A26656@fafner.intra.cogenit.fr>
References: <Pine.LNX.4.33.0207201814170.25617-100000@hoochie.linux-support.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0207201814170.25617-100000@hoochie.linux-support.net>; from markster@linux-support.net on Sat, Jul 20, 2002 at 06:25:49PM -0500
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Mark Spencer <markster@linux-support.net> :
[...]
> 	Over the past year, Linux Support Services, Inc.  and Zapata
> Telephony, Inc. have been working together on building the "Zaptel" pseudo
> TDM bus architecture, and having at least 7 supported boards in a variety
> of roles (T1, E1, multi-port T1, E1, FXS and FXO with USB, PCI, ISA, and
> Ethernet interfaces), we are now interesting in getting comments on the
> driver architecture and moving towards integration into the 2.5 kernel.

A few remarks after a quick glance at zaptel-0.2.0 
- copy_{to/from}_user() may sleep. Don't call it with spinlock held
  (see Documentation/DocBook/kernel-locking.tmpl)
- avoid unchecked copy_{to/from}_user() and friends.
- the failure paths aren't consistent: sometime goto, sometime not.
- the failure paths don't always do their job regarding kmalloc/kfree balance
- fcstab[] declaration is duplicated
- please put blank lines after variables declarations in function body
- zt_common_ioctl/zt_ctl_ioctl() on less than 14/24 screens would be nice

[...]
> 	I am very interested in seeking comments both on our driver
> framework, and on how to go about submitting this for kernel inclusion if
> appropriate.

The kernel parts are appropriate imho (hint, hint: split these from userspace
code in zaptel package). Cosmetic/CodingStyle issues apart, bugs are lurking
in the code.

-- 
Ueimor
