Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWDGG32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWDGG32 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 02:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWDGG32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 02:29:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:57784 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932311AbWDGG31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 02:29:27 -0400
Subject: Re: Latest linus GIT freezes on my G4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Michael Buesch <mb@bu3sch.de>, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0604021309560.3050@g5.osdl.org>
References: <200604021801.42662.mb@bu3sch.de>
	 <Pine.LNX.4.64.0604021309560.3050@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 08:29:14 +0200
Message-Id: <1144391354.30891.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-02 at 13:10 -0700, Linus Torvalds wrote:
> 
> On Sun, 2 Apr 2006, Michael Buesch wrote:
> > 
> > Latest Linus-GIT tree freezes on boot on my
> > G4 PowerBook.
> > The last kernel messages are:
> > 
> > GMT delta read from XPRAM: 0 minutes, DST: off
> > time_init: decrementer frequency = 18.432000 MHz
> > time_init: processor frequency   = 1499.999994 MHz
> 
> Hmm. Can you try the current one, which has a powerpc update.
> 
> If that still doesn't fix it, doing a "git bisect" to find out where it 
> started going south would be very very helpful.

Looks like it could be the idle loop that is broken... some quick tests
here seem to show that we die on the first msleep, wherever it comes
from (the above messages are not totally relevant because time_init just
happens to be just before console_init which kills the early boot
console, and the crash happens before radeonfb kicks in, which happens
much later).

I'm travelling so I really didn't have a chance to debug this yet
properly, it could be related to Paul's idle loop changes, or not ...
will get back to this next week. It seems like all powermac (or almost)
are broken at the moment.

Ben.

