Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbVJ2SsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbVJ2SsA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 14:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVJ2SsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 14:48:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:6892 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751253AbVJ2Sr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 14:47:59 -0400
Date: Sat, 29 Oct 2005 19:47:58 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] bluetooth hidp is broken on s390
Message-ID: <20051029184758.GL7992@ftp.linux.org.uk>
References: <20051029110200.GH7992@ftp.linux.org.uk> <1130583949.6428.1.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130583949.6428.1.camel@blade>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 01:05:49PM +0200, Marcel Holtmann wrote:
> Hi Al,
> 
> > 	Bluetooth HIDP selects INPUT and it really needs it to be
> > there - module depends on input core.  And input core is never
> > built on s390...  Marked as broken on s390, for now; if somebody
> > has better ideas, feel free to fix it and remove dependency...
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> basically I think someone should fix the input layer on S390, but I am
> fine with your fix.

There's a problem with that patch, though ;-/  S390 is never defined by
arch/s390/Kconfig; ARCH_S390 is.  From the fast grep it looks like there
is one more place with the same problem: drivers/char/Kconfig has
config HW_CONSOLE
        bool
        depends on VT && !S390 && !UML
        default y
and the second term is always true here.  Why do we have that dependency,
anyway, when s390 doesn't include drivers/char/Kconfig at all?
