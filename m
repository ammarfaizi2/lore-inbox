Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268149AbUIPPQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268149AbUIPPQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268147AbUIPPQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 11:16:52 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:19552 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268191AbUIPPGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:06:19 -0400
Subject: Re: PATCH: tty drivers take two
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916143057.GA15163@devserv.devel.redhat.com>
References: <20040916143057.GA15163@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095347152.2006.17.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Sep 2004 10:05:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-16 at 09:30, Alan Cox wrote:
> - Switch rocket to tty_wakeup()
> - Switch mxser to ldisc/tty_wakeup()
> - Fix moxa to ldisc/tty_wakeup()
> - Fix riscom8 to ldisc/tty_wakeup
> - Amiserial to ldisc/tty_wakeup

Alan:

I was applying the ldisc changes
to the synclink drivers and had a question
regarding the tty_wakeup() helper.

>From what I see, all drivers who call tty_wakeup()
also do wake_up_interruptible(&tty->write_wait);
at the same time.

Would it be reasonable to add that to the
helper and remove it from the individual drivers.

In my first pass on the synclink drivers (before
I saw the new tty_wakeup helper), I created
a write_wakeup wrapper that does the same thing
as tty_wakeup but also moved
wake_up_interruptible(&tty->write_wait);
into the wrapper. This works for me.

-- 
Paul Fulghum
paulkf@microgate.com

