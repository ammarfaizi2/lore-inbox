Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbQL1Ex4>; Wed, 27 Dec 2000 23:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130375AbQL1Exq>; Wed, 27 Dec 2000 23:53:46 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:35593 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129667AbQL1Exc>;
	Wed, 27 Dec 2000 23:53:32 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "J . A . Magallon" <jamagallon@able.es>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CCFOUND and more 
In-Reply-To: Your message of "Tue, 26 Dec 2000 21:11:14 BST."
             <20001226211114.A1511@werewolf.able.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Dec 2000 15:22:59 +1100
Message-ID: <8203.977977379@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Dec 2000 21:11:14 +0100, 
"J . A . Magallon" <jamagallon@able.es> wrote:
>Solving other things, I have realized that all that problem on fast
>CC detection (CCFOUND) is easily solved by doing:
>	CC  := $(.................)
>instead of
>	CC = $(.........)
>The find of the suitable CC command is repeated many times along a 
>kernel build. And CC is not anything that can change along a kernel
>build. So former syntax solves all the problems, CC detection can
>be so complex as you want because is done only once.
>
>Is there something I am missing ?

Yes.  Some arch files change CROSS_COMPILE after CC has been set and
expect the change to flow into the definition of CC.  This "feature"
only works because '=' stores the value as text and reevaluates the
text each time, automatically picking up any changes to CROSS_COMPILE.
Using CC := might break m68k and mips.  The makefile redesign for 2.5
will fix this problem once and for all.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
