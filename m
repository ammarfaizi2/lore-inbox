Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262989AbUKSAz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbUKSAz5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbUKSAxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 19:53:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:5029 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261217AbUKSAwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 19:52:31 -0500
Date: Thu, 18 Nov 2004 16:52:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Potential security problem in patch: Fix reading /proc/<pid>/mem
 when parent dies.
In-Reply-To: <1100820455.6019.31.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0411181648040.2222@ppc970.osdl.org>
References: <200411181704.iAIH4SSb023079@hera.kernel.org>
 <1100820455.6019.31.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Nov 2004, Alan Cox wrote:
> 
> The original point of this was that if our parent changed then our new
> parent is not aware of our special status. As a result we can send
> random signals to init and since it does not see SIGCLD we can get
> zombies or worse when we exit.

How could we send random signals? That's what the "exit_signal" thing is 
for, and the code does

	if (p->exit_signal != -1)
		p->exit_signal = SIGCHLD;

for that.

Is there any other way to set exit_signal afterwards? If so, I think we 
should have a security check at _that_ point.

		Linus
