Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266347AbUHIP5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266347AbUHIP5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUHIPzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:55:02 -0400
Received: from the-village.bc.nu ([81.2.110.252]:36809 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266347AbUHIPwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:52:33 -0400
Subject: Re: dynamic /dev security hole?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Lammerts <eric@lammerts.org>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, Greg KH <greg@kroah.com>,
       albert@users.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408090025590.26834@vivaldi.madbase.net>
References: <20040808162115.GA7597@kroah.com>
	 <1091969260.5759.125.camel@cube>
	 <20040808175834.59758fc0.Ballarin.Marc@gmx.de>
	 <20040808162115.GA7597@kroah.com>
	 <20040809000727.1eaf917b.Ballarin.Marc@gmx.de>
	 <Pine.LNX.4.58.0408090025590.26834@vivaldi.madbase.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092062974.14153.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 15:49:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-09 at 05:40, Eric Lammerts wrote:
> Just an idea for a fix for this problem: If udev would change the
> permissions to 000 and ownership to root.root just before it unlinks
> the device node, the copy would become useless.

Unfortunately not the whole story. The permissions are checked at open
time not on read/write/ioctl so once I have the device opened you
lose. That means you may have to fix the permissions and ownership
before trying to unload the device. The unload will fail if it is still
busy but if not then nobody will be able to open the dev node and
whatever file it now points to.


