Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270723AbUJURBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270723AbUJURBz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270763AbUJURBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:01:31 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:9307 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S270723AbUJURAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:00:45 -0400
Subject: Re: Linux v2.6.9 (Strange tty problem?)
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul <set@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1098373052.17052.141.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
	 <20041021024132.GB6504@squish.home.loc>
	 <1098349651.17067.3.camel@localhost.localdomain>
	 <1098364808.2815.38.camel@deimos.microgate.com>
	 <1098373052.17052.141.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1098378042.10324.8.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 21 Oct 2004 12:00:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 10:37, Alan Cox wrote:
> On Iau, 2004-10-21 at 14:20, Paul Fulghum wrote:
> > This restores the original behavior for
> > devices that have not yet implemented ldisc->hangup()
> > and should work with the new locking.
> 
> Unfortunately that re-introduces another existing unfixed problem.

I also realized that the original code *only*
called ldisc->close if the current ldisc != N_TTY.

So I was wrong in interpreting this as using
ldisc->close to indicate hangup in a general sense
because it does not apply to N_TTY.
So depending on this behavior is wrong,
and implementing ldisc->hangup is the way to go.

I'm working on the PPP ldisc now.

-- 
Paul Fulghum
paulkf@microgate.com

