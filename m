Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269723AbUICSR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269723AbUICSR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269701AbUICSO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:14:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:23700 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269718AbUICSMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:12:08 -0400
Date: Fri, 3 Sep 2004 11:12:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Yoav Zach <yoav_zach@yahoo.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, yoav.zach@intel.com
Subject: Re: force_sig_info
In-Reply-To: <20040903135835.96953.qmail@web50610.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0409031109100.26393@ppc970.osdl.org>
References: <20040903135835.96953.qmail@web50610.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Sep 2004, Yoav Zach wrote:
>
> The behavior of force_sig_info has changed in kernel 2.6 in
> a way that affects very badly our product - in case the user
> blocks a signal that must be delivered, the disposition of
> the signal is changed to SIG_DFL.

This is very much by design, and it showed real bugs in programs. You 
can't block a signal and expect the kernel to still honor the signal 
handler you had installed. If you blocked it, you're saying "I'm not ready 
to take this signal". And that means that the kernel should refuse to 
deliver it to you.

Why are you blocking signals that you want to get? Sounds like a bug in 
your program.

		Linus
