Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUAWFAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 00:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUAWFAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 00:00:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:32730 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266511AbUAWFAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 00:00:51 -0500
Subject: swsusp vs  pgdir
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Patrick Mochel <mochel@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1074833921.975.197.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 15:58:41 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've been bored enough today to hack on getting the current
pmdisk/swsusp up on ppc.  The required arch code should be almost
identical.

However, when looking at it, I didn't fully understand how you
actually ensure your page mappings aren't beeing blown away
behind your back during the copy operation on resume, but since
my knowledge of x86 is almost inexistant, I didn't decipher this
from the source code. Could you explain a bit ?

The thing is that you seem to point to the swapper pgdir during
the copy, that is the kernel page tables, but those are beeing
wiped out during the copy potentially, no ?

For PPC, I'm using a simple approach at first by disabling the
data translation on the MMU and using a BAT to keep the .text
mapped, though ultimately, if I want to support POWER4, I'll
have to allocate a temporary hash table in some place that
doesn't get overriden... That means a hook at a higher level in
the resume code path.

Thanks for the details,
Ben.




