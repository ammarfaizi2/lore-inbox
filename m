Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbVI0Q7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVI0Q7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 12:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbVI0Q7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 12:59:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48769 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965005AbVI0Q7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 12:59:52 -0400
Date: Tue, 27 Sep 2005 09:59:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Sergey Vlasov <vsu@altlinux.ru>, Harald Welte <laforge@gnumonks.org>,
       linux-usb-devel@lists.sourceforge.net, vendor-sec@lst.de,
       linux-kernel@vger.kernel.org, greg@kroah.com, security@linux.kernel.org
Subject: Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC]
 Oops while completing async USB via usbdevio
In-Reply-To: <1127840281.10674.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0509270943400.3308@g5.osdl.org>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org> 
 <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org>  <20050927160029.GA20466@master.mivlgu.local>
  <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <1127840281.10674.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Sep 2005, Alan Cox wrote:
> 
> Which doesn't take very long to arrange. Relying on pids is definitely a
> security problem we don't want to make worse than it already is. 

The thing is, the current code is _worse_. 

MUCH worse.

And it's worse exactly because it does things really wrong. The suggested
patch then just _continues_ to do things really wrong, and then tries to
paper over the bugs.

Which is why I refuse to apply it. Use a pid and do it right.

If the code cannot be made to use fasync itself, then it can at least be
made to do the same _checks_ that fasync does (easy enough: just save away
uid/euid, and do the same signal checks by hand). Until such a time than
the driver writer sees the light.

		Linus
