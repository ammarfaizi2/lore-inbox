Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUBQXjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUBQXjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:39:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:60579 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266689AbUBQXjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:39:43 -0500
Subject: Radeon issue on x86
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402171503150.2154@home.osdl.org>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
	 <20040217184543.GA18495@lsc.hu>
	 <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
	 <20040217200545.GP1308@fs.tum.de>
	 <Pine.LNX.4.58.0402171214230.2154@home.osdl.org>
	 <20040217225905.GQ1308@fs.tum.de>
	 <Pine.LNX.4.58.0402171503150.2154@home.osdl.org>
Content-Type: text/plain
Message-Id: <1077061068.1080.46.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 10:37:49 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus !

One of the issue I'm having with raeonfb on x86 is the need
to retreive the panel informations out of the BIOS. My current
algorithm is to try to retreive that from the PCI ROM of the
video chip, and if I cannot find any, then look at the BIOS ROM
image in low memory.

However, I got a few reports of that not working. Usually, on
laptops, apparently, the PCI ROM doesn't exist and it can all
be found in the low memory image (I suppose the video BIOS on
these is hidden somewhere with the main BIOS and copied to RAM
at aboot). BUT, some laptops like some Dell inspirons will show
a valid PCI ROM (valid signature) on the video chip, though
this ROM appear to not contain any useable panel information
table :( However, on these, the RAM image do seem to contain
the table... So I would need to reverse my algorithm and
default to the RAM BIOS on laptops at least...

The problem with the RAM image is that it's only there for the
primary display chip that was initialized at boot. So I would
need to "know" which PCI card is the primary display. That's all
x86 architecture black magic, so I'd like your advice on the best
way to do that. Also, that low memory region at c0000, what is
it's exact format ? I currently copied a search routine from
XFree but it does very little verifications in there, I'm a bit
paranoid about picking the wrong thing...

What do you suggest ?

Ben.


