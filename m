Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWJALmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWJALmV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 07:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWJALmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 07:42:21 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:29831 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932065AbWJALmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 07:42:20 -0400
Message-ID: <451FA997.9050000@garzik.org>
Date: Sun, 01 Oct 2006 07:42:15 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>
Subject: x86 BUG bug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a couple ATA drivers that spit out "foo might be used 
uninitialized" warnings.  Rather than the usual gcc nonsense, it turns 
out that the code follows this pattern:

	type_t foo;

	if (condition 1)
		foo = x;
	else if (condition 2)
		foo = y;
	else
		BUG();

It doesn't warn on other platforms, so I dug into the BUG() code on x86, 
and discovered that it is missing the 'noreturn' attribute found in 
other BUG() definitions.

Being rusty on the gcc asm syntax -- does an inline asm statement permit 
'noreturn'? -- I figured it would be best just to report this, rather 
than create a patch myself.

	Jeff


