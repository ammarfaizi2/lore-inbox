Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTJQXzx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 19:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTJQXzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 19:55:53 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:16529 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263645AbTJQXzv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 19:55:51 -0400
Date: Sat, 18 Oct 2003 00:55:26 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Chris Lattner <sabre@nondot.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: [x86] Access off the bottom of stack causes a segfault?
Message-ID: <20031017235526.GB21420@mail.shareable.org>
References: <Pine.LNX.4.53.0310141521130.2240@chaos> <Pine.LNX.4.44.0310141447300.4666-100000@nondot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310141447300.4666-100000@nondot.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Lattner wrote:
> Thanks to everyone for all of the answers. :)  I guess the moral of the
> story is to not perform leaf function optimization on X86.  At least
> frame-pointer elimination is still safe.

Chris,

You _can_ do the leaf optimisation, but you have to be more careful.

Firstly, you'll need to use sigaltstack() to ensure signals are not
delivered on the current stack.

Secondly, you'll need to install a SIGSEGV signal handler which
detects when the kernel doesn't like you accessing below %esp, and
forces the vma to expand by manipulating %esp and doing some accesses,
then returns.

-- Jamie
