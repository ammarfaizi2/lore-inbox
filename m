Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbUKSBK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbUKSBK0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUKSBGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:06:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:63977 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262883AbUKSBEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 20:04:11 -0500
Subject: Re: Potential security problem in patch: Fix reading
	/proc/<pid>/mem when parent dies.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411181648040.2222@ppc970.osdl.org>
References: <200411181704.iAIH4SSb023079@hera.kernel.org>
	 <1100820455.6019.31.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411181648040.2222@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100822457.6579.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 19 Nov 2004 00:00:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-11-19 at 00:52, Linus Torvalds wrote:
> How could we send random signals? That's what the "exit_signal" thing is 
> for, and the code does
> 
> 	if (p->exit_signal != -1)
> 		p->exit_signal = SIGCHLD;
> 
> for that.
> 
> Is there any other way to set exit_signal afterwards? If so, I think we 
> should have a security check at _that_ point.

Ok that makes sense now I look harder at it. While it was added to
protect agains that case the code you quote already covers all the cases
I can see. We can clone new threads but they too will get reparented or
will simply kill us.


