Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbUKIBMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbUKIBMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUKIBJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:09:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:24480 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261320AbUKIBFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:05:30 -0500
Date: Mon, 8 Nov 2004 17:05:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christian Kujau <evil@g-house.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: Oops in 2.6.10-rc1
In-Reply-To: <419005F2.8080800@g-house.de>
Message-ID: <Pine.LNX.4.58.0411081656550.2301@ppc970.osdl.org>
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz>
 <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de>
 <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org>
 <20041107130553.M49691@g-house.de> <418E4705.5020001@g-house.de>
 <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org> <20041107182155.M43317@g-house.de>
 <418EB3AA.8050203@g-house.de> <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>
 <418F6E33.8080808@g-house.de> <Pine.LNX.4.58.0411080951390.2301@ppc970.osdl.org>
 <418FDE1F.7060804@g-house.de> <419005F2.8080800@g-house.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Nov 2004, Christian Kujau wrote:
> 
> >>>Looking at the list (appended), I don't see anything obvious, but hey, if 
> >>>it was obvious it wouldn't have been merged in the first place. 
> 
> yes, i'll look for changes regarding PCI. i've started to compile the -bk
> snapshots too. there i can do less wrong things. when i have the "bad" -bk
> snapshot i'll use "bk" itself again to find the detailed change leading to
> the oops.

Actually, looking a bit closer, I think the PCI merge we just looked at 
was the PCI merge that happened _after_ 2.6.10-rc1. And since 2.6.10-rc1 
already oopsed for you, it shouldn't be an issue.

I think the _real_ PCI merge we should have looked at is:

	ChangeSet@1.2000.1.7, 2004-10-19 16:59:19-07:00, torvalds@ppc970.osdl.org
	  Merge PCI updates

and in particular, that merged the PCI changes from

	ChangeSet@1.1988.2.81, 2004-10-19 14:48:04-07:00, greg@kroah.com
	  PCI: fix up pci_save/restore_state in via-agp due to api change.
	  
	  Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

with my pre-PCI-merge tree at:

	ChangeSet@1.2000.1.6, 2004-10-19 15:06:19-07:00, torvalds@ppc970.osdl.org
	  Merge bk://bart.bkbits.net/ide-2.6
	  into ppc970.osdl.org:/home/torvalds/v2.6/linux

(all of these revision numbers are relative to a pristine 2.6.10-rc1 
tree: remember that they change with merges, so they may not be the same 
in your tree. "bk changes -a" is your friend).

So what I'd like you to do is to take the pre-PCI-merge tree, and see if 
that works for you

	# assuming a 2.6.10-rc1 tree
	bk undo -a1.2000.1.6

and if that works, then try the post-PCI-merge tree:

	# assuming a 2.6.10-rc1 tree
	bk undo -a1.2000.1.7

(I just checked: the above numbers are actually valid even in the current
-bk tree, so you don't have to first go to 2.6.10-rc1, you can just start 
from a current tree)

Thanks for testing, and sorry for the confusion with the more recent PCI 
merge.

		Linus
