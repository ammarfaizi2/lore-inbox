Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbTDQOUI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbTDQOUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:20:08 -0400
Received: from havoc.daloft.com ([64.213.145.173]:26766 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261412AbTDQOUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:20:07 -0400
Date: Thu, 17 Apr 2003 10:32:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
Message-ID: <20030417143202.GA18749@gtf.org>
References: <3E9DFC11.50800@pobox.com> <1050585430.31390.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050585430.31390.32.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 02:17:16PM +0100, Alan Cox wrote:
> On Iau, 2003-04-17 at 01:57, Jeff Garzik wrote:
> > The patch below is the conservative, obvious patch.  It only kicks in 
> > when __builtin_constant_p() is true, and it only applies to the i386 
> > arch.  
> 
> You are assuming the compiler is smart about stuff - it doesnt know
> SSE/MMX for page copies etc. For small copies it should alays win, but

Prior to my patch, __constant_memcpy was -already- only used for small,
constant-size copies.

Therefore, my patch applied __builtin_memcpy only to small,
constant-size copies.  The existing kernel custom-memcpy code continued
to perform as expected.

You and Linus both seem to think MMX/SSE/SSE2 is somehow in the
equation, but I do not see that at all.  I left those paths alone.
Clarification/LART requested...


> isn't it best if so to use __builtin_memcpy without our existing
> macros not just trust the compiler ?

hum, I didn't parse this at all:
Use of __builtin_memcpy implies trusting the compiler :)

Maybe you meant s/without/with/ ?

	Jeff



