Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267721AbTBYGmQ>; Tue, 25 Feb 2003 01:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267731AbTBYGmQ>; Tue, 25 Feb 2003 01:42:16 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:64149 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id <S267721AbTBYGmQ>; Tue, 25 Feb 2003 01:42:16 -0500
To: "sudharsan vijayaraghavan" <my_goal@rediffmail.com>
Cc: linux-kernel@vger.kernel.org, narendiran_srinivasan@satyam.com
Subject: Re: Unresolved symbol error in __wake_up_sync
References: <20030225064001.20937.qmail@webmail17.rediffmail.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 24 Feb 2003 22:52:26 -0800
In-Reply-To: <20030225064001.20937.qmail@webmail17.rediffmail.com>
Message-ID: <524r6sua1h.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Feb 2003 06:52:29.0424 (UTC) FILETIME=[76B1E700:01C2DC9A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    sudharsan> We wrote a module in which we used
    sudharsan> wake_up_interruptible, wake_up_interruptible_sync calls
    sudharsan> and when I compiled it into a module with the
    sudharsan> appropriate Macros, it gets compiled properly.  But
    sudharsan> once, when I try to load the module with insmod, I get
    sudharsan> __wake_up_sync - unresolved symbol?  What module should
    sudharsan> I load to get out this error?

You don't need to load another module, since __wake_up_sync is part of
the kernel.  You are probably running into a problem with module
versions.  When you do:

    $ grep __wake_up_sync /proc/ksyms 

you will probably get something like:

    c01147e0 __wake_up_sync_R08c2a6b5

The _R08c2a6b5 part of the symbol name is the version, which comes
from the ".ver" files in your kernel include tree.  You will have to
include <linux/modversions.h> to get the correct definition for
__wake_up_sync.

By the way, 2.4.7 is an extremely old kernel, and you may avoid
problems by moving to something newer.

Best,
  Roland
