Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUDIAmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 20:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbUDIAmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 20:42:08 -0400
Received: from ozlabs.org ([203.10.76.45]:21913 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261210AbUDIAmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 20:42:05 -0400
Date: Fri, 9 Apr 2004 10:37:37 +1000
From: Anton Blanchard <anton@samba.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Andrew Morton <akpm@osdl.org>, bug-coreutils@gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-ID: <20040409003737.GF18493@krispykreme>
References: <20040406220358.GE4828@hexapodia.org> <20040406173326.0fbb9d7a.akpm@osdl.org> <20040407173116.GB2814@hexapodia.org> <20040407111841.78ae0021.akpm@osdl.org> <20040407192432.GD2814@hexapodia.org> <20040407123455.0de9ffa9.akpm@osdl.org> <20040407194727.GE2814@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407194727.GE2814@hexapodia.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> OK, I can see that one.  But it seems like a pretty small benefit to me
> -- CPU utilization is already really low.

Maybe not to you but it does make a big difference on our 500 disk setup.
At the moment we use dd to do an initial sniff, then ext3 utils to do
O_DIRECT reads/writes. With O_DIRECT read/write in dd we could use it
instead. (We are basically interested in IO performance that a database
would see).

> Um, that sounds like a bad idea to me.  It seems to me it's the kernel's
> responsibility to figure out "hey, looks like a streaming read - let's
> not blow out the buffer cache trying to hold 20GB on a 512M system."  If
> you're saying that the kernel guys have given up and the established
> wisdom is now "you gotta use O_DIRECT if you don't want to throw
> everything else out due to streaming data", well... I'm disappointed.

When you start hitting memory bandwidth limits, O_DIRECT will help you.
Sure it wont be an issue for your dd copy scenario, but I wanted to point
out there are other valid uses for it.

Anton
