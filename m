Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268685AbUJUPxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268685AbUJUPxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270735AbUJUPwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 11:52:15 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:14169 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S270742AbUJUPrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 11:47:25 -0400
Subject: Re: Linux v2.6.9 (Strange tty problem?)
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul <set@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1098364808.2815.38.camel@deimos.microgate.com>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
	 <20041021024132.GB6504@squish.home.loc>
	 <1098349651.17067.3.camel@localhost.localdomain>
	 <1098364808.2815.38.camel@deimos.microgate.com>
Content-Type: text/plain
Message-Id: <1098373647.3289.9.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 21 Oct 2004 10:47:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 08:20, Paul Fulghum wrote:
> I was thinking a reasonable solution would be
> to queue work in tty_do_hangup() if ldisc->hangup()
> is not defined (== NULL) to switch the ldisc back to N_TTY.

Nevermind, I now see why this won't work.

tty_set_ldisc() calls flush_scheduled_work() so
it can't be called from a work routine on the
default events queue.

I'll now look at adding the hangup() method to ppp_*.c

-- 
Paul Fulghum
paulkf@microgate.com

