Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVAXQw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVAXQw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 11:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVAXQuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 11:50:19 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:46486 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261532AbVAXQtl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 11:49:41 -0500
Subject: Re: kernel oops!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sergey Vlasov <vsu@altlinux.ru>, ierdnah <ierdnah@go.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501230956100.4191@ppc970.osdl.org>
References: <1106437010.32072.0.camel@ierdnac>
	 <Pine.LNX.4.58.0501222223090.4191@ppc970.osdl.org>
	 <20050123161512.149cc9de.vsu@altlinux.ru>
	 <Pine.LNX.4.58.0501230956100.4191@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106509705.6154.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 Jan 2005 15:44:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-23 at 18:22, Linus Torvalds wrote:
> I think it's only the tty_ldisc_ref_wait() thing that can deadlock (and 
> even that is likely safe if you just specify an order - "masters first" or 
> something). Adding a nonblocking "tty_ldisc_ref()" looks safe, ie 
> something like the appended.

Yes.

> This has the problem (apart from the fact that it's obviously totally
> untested ;) that it looks like every single pty function would need to do
> it, so it would be nicer if "tty_ldisc_ref_wait()" would just always get
> both references (ie do the ordering). Alan?

Almost every user of tty_ldisc_ref_* doesn't need to lock two objects
and
the code at that layer has no knowledge of pty/tty pairs. The needed
info is exposed however in order to do this since the tty knows if its a
tty/pty pair. I'll take a look - chances are it can be buried in
tty_ldisc_ref.

I'm dubious this is the actual bug although vhangup on a pty might
trigger it I guess.

Alan

