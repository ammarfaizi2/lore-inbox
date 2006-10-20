Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946379AbWJTPfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946379AbWJTPfc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992594AbWJTPfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:35:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16107 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946379AbWJTPfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:35:31 -0400
Date: Fri, 20 Oct 2006 08:35:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
In-Reply-To: <Pine.LNX.4.64.0610200810390.3962@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0610200827210.3962@g5.osdl.org>
References: <4537EB67.8030208@drzeus.cx> <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org>
 <45386E0E.7030404@drzeus.cx> <Pine.LNX.4.64.0610200810390.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Oct 2006, Linus Torvalds wrote:
> 
> Use "git diff -M --stat master..for-linus" instead.

Actually, use "git diff -M --stat --summary master..for-linus".

The "--summary" thing generates an additional summary at the end of the 
diffstat that lists deleted/created/moved/copied files, which is nice to 
see. There's a difference between a

   drivers/char/myserial.c  | 50 ++++++++
   1 file changed, 50 insertions(+), 0 deletions(-)

and

   drivers/char/myserial.c  | 50 ++++++++
   1 file changed, 50 insertions(+), 0 deletions(-)
   create mode 100644 drivers/char/myserial.c

because the latter tells that the new lines are actually in a new file, 
while the previous says that you just added lines to an old one.

(Without "--summary", you can't tell the difference between these two 
cases)

And the "-M" flag obviously means the difference between:

 drivers/pci/hotplug/pci_hotplug.h          |  236 ----------------------
 include/linux/pci_hotplug.h                |  236 ++++++++++++++++++++++
 2 files changed, 236 insertions(+), 236 deletions(-)
 delete mode 100644 drivers/pci/hotplug/pci_hotplug.h
 create mode 100644 include/linux/pci_hotplug.h

and

 .../pci/hotplug => include/linux}/pci_hotplug.h    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
 rename drivers/pci/hotplug/pci_hotplug.h => include/linux/pci_hotplug.h (99%)

where the latter version clearly tells you a whole lot more about the 
patch than the non-renaming one.

The reason rename detection isn't on by default is that non-git tools 
don't understand the rename diffs. But if anybody sends me patches, please 
feel free to use "git diff -M" to make them smaller and more readable in 
the face of renames.

		Linus
