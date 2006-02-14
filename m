Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422804AbWBNViF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422804AbWBNViF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422807AbWBNViE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:38:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:53998 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1422804AbWBNViD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:38:03 -0500
Message-ID: <43F24DBA.7090602@am-anger-1.de>
Date: Tue, 14 Feb 2006 22:38:02 +0100
From: Heiko Gerstung <heiko@am-anger-1.de>
User-Agent: Mail/News 1.5 (X11/20060120)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bonding mode 1 works as designed. Or not?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:25672344472c4ac2bbe53bd9833f99fb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, there!

I just set up bonding for a 2.6.12 box in active-backup mode (mode 1)
and found out that every packet is duplicated, despite the fact that the
documentation (Documentation/network/bonding.txt) says:

"active-backup or 1
                 Active-backup policy: Only one slave in the bond is
                 active.  A different slave becomes active if, and only
                 if, the active slave fails.  The bond's MAC address is
                 externally visible on only one port (network adapter)
                 to avoid confusing the switch.  This mode provides
                 fault tolerance.  The primary option affects the
                 behavior of this mode."


My understanding of this mode is:
eth0 and eth1 are in a bonding group, mode=1, miimon=100 ... eth0 is the
active slave and used as long as the physical link is available (checked
by using MII monitoring), at the same time eth1 is totally passive,
neither passing any received packets to the kernel nor sending packets,
if the kernel wants it to do so. As soon as the eth0 link status changes
to "down", eth1 is activated and used, and now eth0 remains silent and
deaf until it becomes the active slave again.

Any comments on that? Is the documentation wrong OR is there a bug in
the implementation of the bonding module?

Thank you in advance,
kind regards,

Heiko



