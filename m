Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265255AbUF1WIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUF1WIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUF1WIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:08:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:32425 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265255AbUF1WI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:08:28 -0400
Date: Mon, 28 Jun 2004 15:08:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] signal handler defaulting fix ...
In-Reply-To: <Pine.LNX.4.58.0406281453250.18879@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0406281507090.28764@ppc970.osdl.org>
References: <Pine.LNX.4.58.0406281430470.18879@bigblue.dev.mdolabs.com>
 <20040628144003.40c151ff.akpm@osdl.org> <Pine.LNX.4.58.0406281446460.28764@ppc970.osdl.org>
 <Pine.LNX.4.58.0406281453250.18879@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Jun 2004, Davide Libenzi wrote:
> 
> It's not that the program try to block the signal. It's the kernel that 
> during the delivery disables the signal. Then when the signal handler 
> longjmp(), the signal remains disabled. The next time the signal is raised 
> again, the kernel does not honor the existing handler, but it reset to 
> SIG_DFL.

So? That program is buggy. Setting the signal handler to SIG_DFL causes it 
to be killed with a nice "killed by SIGFPE" message, and now the bug is 
visible, and can be fixed.

Hint: it should have done a siglongjmp().

		Linus
