Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVC2MFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVC2MFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 07:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVC2MEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 07:04:02 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:30443 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262248AbVC2MDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 07:03:22 -0500
Date: Tue, 29 Mar 2005 14:03:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Smets Jan <jan@smets.cx>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Quotaoff -> crash
In-Reply-To: <20050329115136.GA1751@smets.cx>
Message-ID: <Pine.LNX.4.61.0503291400150.19483@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503291306020.19483@yvahk01.tjqt.qr>
 <20050329115136.GA1751@smets.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>When running the quotaoff utility, it suddenly segfaulted and my /home was 'dead'.
>I also noticed that the load of my box was rising very high. After a few minutes 
>the whole server was 'dead'.
>
>If anyone has seen the same problem or has any idea howto solve this problem,
>or howto get more debugging information, please let me know.

I had a similar problem once... upon quotaoff syscall, the system hung in a 
spinlock or something. I dug deep into the assembly code (using kdb), found 
out it hung, but the source code said it should not, so I recompiled all from 
fresh and it was gone. :-/

Since you are getting a SIGSEGV (not SIGKILL?) at least, you should be able 
to hook gdb on it, and grep the EIP. This is of course will only be the 
userspace EIP, but it may show where it's happening (I guess it will be the 
quota syscall nevertheless).



Jan Engelhardt
-- 
No TOFU for me, please.
