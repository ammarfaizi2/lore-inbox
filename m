Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbTJNTf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 15:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbTJNTf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 15:35:57 -0400
Received: from nondot.cs.uiuc.edu ([128.174.245.159]:15802 "EHLO nondot.org")
	by vger.kernel.org with ESMTP id S262484AbTJNTcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 15:32:35 -0400
Date: Tue, 14 Oct 2003 14:48:43 -0500 (CDT)
From: Chris Lattner <sabre@nondot.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [x86] Access off the bottom of stack causes a segfault?
In-Reply-To: <Pine.LNX.4.53.0310141521130.2240@chaos>
Message-ID: <Pine.LNX.4.44.0310141447300.4666-100000@nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any interrupt causes the return address to be pushed onto the
> stack. This will overwrite any data you've put there. In principle,
> in user-mode, you can write below the stack-pointer because an
> interrupt uses the kernel stack. However, your data will still
> get corrupted by signal delivery, etc. So as to not corrupt your
> user-mode stack, the kernel calls your signal code, just like
> a nested call. This means the new return address will be below
> the non-signal user-mode stack-pointer value. This will surely
> corrupt anything you have written below the stack-pointer.

Thanks to everyone for all of the answers. :)  I guess the moral of the
story is to not perform leaf function optimization on X86.  At least
frame-pointer elimination is still safe.

Thanks again,

-Chris

-- 
http://llvm.cs.uiuc.edu/
http://www.nondot.org/~sabre/Projects/

