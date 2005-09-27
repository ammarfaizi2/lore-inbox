Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbVI0RCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbVI0RCi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 13:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVI0RCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 13:02:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965013AbVI0RCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 13:02:38 -0400
Date: Tue, 27 Sep 2005 10:02:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sergey Vlasov <vsu@altlinux.ru>
cc: Harald Welte <laforge@gnumonks.org>, linux-usb-devel@lists.sourceforge.net,
       vendor-sec@lst.de, linux-kernel@vger.kernel.org, greg@kroah.com,
       security@linux.kernel.org
Subject: Re: [linux-usb-devel] Re: [Security] [vendor-sec] [BUG/PATCH/RFC]
 Oops while completing async USB via usbdevio
In-Reply-To: <20050927165206.GB20466@master.mivlgu.local>
Message-ID: <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org>
References: <20050925151330.GL731@sunbeam.de.gnumonks.org>
 <Pine.LNX.4.58.0509270746200.3308@g5.osdl.org> <20050927160029.GA20466@master.mivlgu.local>
 <Pine.LNX.4.58.0509270904140.3308@g5.osdl.org> <20050927165206.GB20466@master.mivlgu.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Sep 2005, Sergey Vlasov wrote:
> 
> The initial patch added get_task_struct()/put_task_struct() calls to
> fix this - are they forbidden too?

They are sure as hell not something that a _driver_ is supposed to use.

> It at least has sigio_perm(), which prevents exploiting it to send
> signals to tasks you don't have access to.

And the point is, you can do that _too_.

Do it right. Don't cache pointers to threads. Use the pid.

Your security arguments are _pointless_. As proven by the fact that SIGIO 
happily uses a pid, and gets it right. Try to use _that_ infrastructure 
instead, since that's what it's _meant_ for.

The fact is, having drivers much around with thread locking is not
acceptable. Drivers _will_ get it wrong, and even if they didn't, it's
kernel internal data structures that drivers have no business in touching.

			Linus
