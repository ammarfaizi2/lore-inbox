Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVJaJBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVJaJBI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 04:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVJaJBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 04:01:08 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:10125 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932284AbVJaJBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 04:01:06 -0500
Subject: Re: [PATCH] bluetooth hidp is broken on s390
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Marcel Holtmann <marcel@holtmann.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>
In-Reply-To: <20051029184758.GL7992@ftp.linux.org.uk>
References: <20051029110200.GH7992@ftp.linux.org.uk>
	 <1130583949.6428.1.camel@blade>  <20051029184758.GL7992@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 31 Oct 2005 10:01:00 +0100
Message-Id: <1130749260.5863.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-29 at 19:47 +0100, Al Viro wrote:
> On Sat, Oct 29, 2005 at 01:05:49PM +0200, Marcel Holtmann wrote:
> > Hi Al,
> > 
> > > 	Bluetooth HIDP selects INPUT and it really needs it to be
> > > there - module depends on input core.  And input core is never
> > > built on s390...  Marked as broken on s390, for now; if somebody
> > > has better ideas, feel free to fix it and remove dependency...
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > basically I think someone should fix the input layer on S390, but I am
> > fine with your fix.

And since there isn't a Bluetooth device on s390 (yet), we can live with
the broken input core for now. Would be nicer if the input layer would
work but there are more important things..

> There's a problem with that patch, though ;-/  S390 is never defined by
> arch/s390/Kconfig; ARCH_S390 is.  From the fast grep it looks like there
> is one more place with the same problem: drivers/char/Kconfig has
> config HW_CONSOLE
>         bool
>         depends on VT && !S390 && !UML
>         default y
> and the second term is always true here.  Why do we have that dependency,
> anyway, when s390 doesn't include drivers/char/Kconfig at all?

.. e.g. this one. I tried to cleanup the Kconfig for s390 once. After
the patch has grown over 2000 lines of code I gave up. If you have the
feeling that this should be fixed I'll give it another try. At least the
issue with ARCH_S390/ARCH_S390X vs. S390/S390_64 should be fixed.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


