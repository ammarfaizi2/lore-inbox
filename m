Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264860AbUFHGLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbUFHGLI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 02:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbUFHGLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 02:11:08 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:38410 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264862AbUFHGK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 02:10:58 -0400
Subject: Re: 2.6.7-rc3: waiting for eth0 to become free
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Erik Tews <erik@debian.franken.de>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1086649443.21227.44.camel@localhost>
References: <1086648742.1740.1.camel@teapot.felipe-alfaro.com>
	 <1086649443.21227.44.camel@localhost>
Content-Type: text/plain
Date: Tue, 08 Jun 2004 08:11:07 +0200
Message-Id: <1086675067.1658.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-08 at 01:04 +0200, Erik Tews wrote:
> Am Di, den 08.06.2004 schrieb Felipe Alfaro Solana um 0:52:
> > On my laptop, when using a CardBus 3c59x-based NIC, I need to run
> > "cardctl eject" so the system won't freeze when resuming. "cardctl
> > eject" worked fine in 2.6.7-rc2-mm2, even when there were programs with
> > network sockets opened (for example, Evolution mantaining a connection
> > against an IMAP server): the card is ejected (well, not physically),
> > even when there are ESTABLISHED connections.
> > 
> > However, starting with 2.6.7-rc3, "cardctl eject" hangs if a program
> > holds any socket open. After a while the "unregister_netdevice: waiting
> > for eth0 to become free" message starts appearing on the kernel message
> > ring. The only apparent solution is killing that program, ejecting the
> > card from its slot and wait until 3c59x.o usage count reaches zero.
> 
> I have seen similar problems with my prism2 minipci-card. I often unload
> the driver to reset the card, sometimes it hangs during unloading with
> the same message. Would it be possible to add some code to backtrace
> this lock?
> 
> This happens with a lot of recent 2.6 kernels, not always reproduceable.

I can reproduce this consistently with 2.6.7-rc3: launch an ftp session
against a remote server and then try running "cardctl eject". In my
case, it just refuses to unload with an usage count of 1.

