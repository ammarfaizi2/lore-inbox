Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbTDQR5D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbTDQR5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:57:03 -0400
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:9488 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S261848AbTDQR5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:57:02 -0400
Subject: Re: How to identify contents of /lib/modules/*
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, steve.cameron@hp.com
In-Reply-To: <1050502898.28591.76.camel@dhcp22.swansea.linux.org.uk>
References: <20030416020059.GA27314@zuul.cca.cpqcorp.net> 
	<1050502898.28591.76.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Apr 2003 14:08:45 -0400
Message-Id: <1050602925.21408.53.camel@pinhead>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-16 at 10:21, Alan Cox wrote:
> if its an rpm based distro
> 	rpm -qf /lib/modules/[version]/something
> will tell you which kernel owns the file.
> 
> Its a horrible thing to need to do however

I have a worse problem.  :-)   I often run several instances of the
identically version-numbered kernel, all available from the LILO boot
menu, each instance having a different .config or perhaps compiled with
a different gcc.  If each instance wants to share
/lib/modules/[sameversion]/... then I've got a problem.  Ditto for
userspace programs compiled against /usr/include/linux and
/usr/include/asm, where I want the compiled program to correspond very
closely with the currently running kernel.  So...

I "fixed" this problem by creating /lib/modules/BootsAs/,
/usr/include/BootsAs/, etc.  Then, rc.sysinit looks in /proc/cmdline to
figure out what I typed at LILO, greps through /etc/lilo.conf to find
the physical /boot/[xyzzy].vmlinux that was booted, and it creates
symlinks so /lib/modules/[sameversion] -> /lib/modules/BootsAs/[xyzzy]
and so on.  This is also a win when you have several LILO targets that
point to the same kernel.

Kris -- running heavily hacked Slackware.

