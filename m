Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268746AbUJSMs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268746AbUJSMs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 08:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbUJSMsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 08:48:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21990 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268746AbUJSMsy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 08:48:54 -0400
Date: Tue, 19 Oct 2004 13:48:50 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Delete drivers/pci/syscall.c?
Message-ID: <20041019124850.GM16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, I noticed you touching drivers/pci/syscall.c which made me look
a bit more carefully at that file.  It is broken for machines with
overlapping PCI bus numbers in separate domains.  There's basically no
way to fix this unless we encode the domain into the upper bits of the
bus number.

The information is already available through /proc and /sys.  It's hooked
into the syscall tables of alpha, arm, ia64, ppc, ppc64, sparc and
sparc64.  Whatever's using those syscalls must have some kind of backup
strategy for grovelling around in files.

What would break if we just made those syscalls return -ENOSYS?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
