Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbTESVlT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTESVlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:41:19 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:17800 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S262951AbTESVlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:41:18 -0400
Subject: Re: rfcomm-tty driver->put_char
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
       viro@ftp.uk.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <1053379016.1475.66.camel@pegasus>
References: <1053199887.9218.50.camel@imladris.demon.co.uk>
	 <1053379016.1475.66.camel@pegasus>
Content-Type: text/plain
Organization: 
Message-Id: <1053381250.21582.14.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Mon, 19 May 2003 22:54:10 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: marcel@rvs.uni-bielefeld.de, bluez-devel@lists.sourceforge.net, viro@ftp.uk.linux.org, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 22:16, Marcel Holtmann wrote:
> > Once possible solution is to implement our own put_char() routine which
> > _does_ always allow the character to be queued, rather than allowing
> > tty_default_put_char() to call rfcomm_tty_write() which will fail.
> 
> After some more tests, I plan to push this change.

Note that I recommend this for 2.4 _only_. For 2.5 the correct fix is to
fix the tty_driver API, so you can perhaps let this 'bug' remain there
for a while. I seem to be the only person using an rfcomm modem for
dialin anyway, and 2.5 doesn't even get as far as a login prompt on that
box, let alone support V.110 dialin over ISDN which is also required, so
I really won't miss it :)

The write_room() function is documented to return the number of
characters which can _currently_ be pushed to the tty driver. The n_tty
code has no business thinking that the value returned from write_room()
will be valid at _any_ point in the future, and the fact that put_char()
is not permitted to return any success/failure indication like write()
can is just bizarre.

-- 
dwmw2


