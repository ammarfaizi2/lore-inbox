Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268798AbUILSww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268798AbUILSww (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268794AbUILSww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:52:52 -0400
Received: from outbound04.telus.net ([199.185.220.223]:25079 "EHLO
	priv-edtnes27.telusplanet.net") by vger.kernel.org with ESMTP
	id S268788AbUILSw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:52:26 -0400
From: "Wolfpaw - Dale Corse" <admin@wolfpaw.net>
To: <alan@lxorguk.ukuu.org.uk>
Cc: <kaukasoi@elektroni.ee.tut.fi>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified)Denial of Service Attack
Date: Sun, 12 Sep 2004 12:52:29 -0600
Message-ID: <002701c498f9$a7203140$0200a8c0@wolf>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <02b001c498f6$7942bc50$0300a8c0@s>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> On Sul, 2004-09-12 at 18:29, Wolfpaw - Dale Corse wrote:
> > A fair comment :) But look at it this way:
> > 
> > - The TCP RFC was last updated when?
> 
> About 2 months ago. The 793 RFC isn't updated instead new 
> ones are added for the additional features/discoveries.

My fault there :( Sorry.

> > - What is the average time for a tcp packet to fly even across
> >   the world these days? Maybe 300 ms? 1 second? 5?
> > - It is not a secret that the TCP protocol has flaws, take for
> >   example the RST bug, which required among other things, BGP4
> >   to use MD5 encryption to avoid being potentially attacked.
> 
> This is not a TCP flaw, its a combination of poor design by 
> certain vendors, poor BGP implementation and a lack of 
> understanding of what TCP does and does not do. See IPSec. 
> TCP gets stuff from A to B in order and knowing to a 
> resonable degree what arrived. TCP does not proide a security service.
> 
> (The core of this problem arises because certain people treat 
> TCP connection down on the peering session as link down)

Good point :)

> > So this brings me to:
> > 
> > A) Why are the timeouts so long?
> 
> So you don't get random corruption

Hmm. I'll take your word for it, I'm not quite grasping it,
but you know quite a bit more about it then I do :) I would
have thought once a close is sent, the data has all been received
and/or sent anyway, so what would corrupt?

> > C) Socket still re-uses an FD before it is actually completely
> 
> Pardon ?

It _appears_ that when we close a socket (ie with mysql_close) on
the client side, the client side closes the FD properly (though Mysql
doesn't), and then if we call connect (which it does a lot, being a proxy
server) it will reuse that FD. At this point, the Mysql side still hasn't
closed it, and it is sitting in CLOSE_WAIT, where it remains forever, since
it is in use by the client side elsewhere already. Should connect be
checking the "list of not connected, but state other then CLOSED" list
before it decides to use a particular FD? Or is this behavior intentional?

> > sending something to the other side is required, but I can't see why
> > having the other side send something back is part of the protocol. 
> > This could be
> 
> Because packet sizes are finite and not doing so requires an 
> infinite sequence space and thus infinite packet sizes. 
> Reread the TCP specifications more carefully, also look at 
> RFC1337 which discusses some of the real world cases of 
> getting this wrong.

Fair enough, thank you for clarifying it for me :)

Keep up the good work :) (which you do a lot of I might add :)
D.

