Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317744AbSFSCS2>; Tue, 18 Jun 2002 22:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317746AbSFSCS1>; Tue, 18 Jun 2002 22:18:27 -0400
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:15364
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S317744AbSFSCS0>; Tue, 18 Jun 2002 22:18:26 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: imipak@yahoo.com
X-Envelope-Sender: stevie@qrpff.net
Message-Id: <5.1.0.14.2.20020618213403.00aa4720@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 18 Jun 2002 22:11:49 -0400
To: Myrddin Ambrosius <imipak@yahoo.com>, root@chaos.analogic.com
From: Stevie O <stevie@qrpff.net>
Subject: Re: Drivers, Hardware, and their relationship to Bagels.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020618183515.13963.qmail@web12302.mail.yahoo.com>
References: <Pine.LNX.3.95.1020618111156.3808B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:35 AM 6/18/2002 -0700, Myrddin Ambrosius wrote:
>The problem with priviliged tasks is that (in general)
>they run with absolute privilige. Sure, some of these
>priviliges can be turned off, but if /dev/mem is
>reachable, then they can be turned back on again,
>precicely for the reasons you give.

What about the bagels? I like bagels! ;)

I agree that this is a problem.  A very, very good example of this is 'binding to a reserved port (<1024)'. A number of programs that should never need to run as root, do, some for the sole purpose of binding to a "reserved port":
        * Webservers in a relatively simple configuration (ex: my Apache install)
        * BIND (which doesn't even drop root. A security nightmare.)
        * identd

There are kernel patches that can help solve this problem. One, found at ftp://ftp.v-lo.krakow.pl/pub/linux/patches/, creates 'magic' GIDs that give special limited privileges like binding to a reserved port (above list) or creating a raw socket (ping, traceroute).

If I recall the Capabilities FAQ correctly, I think there's something relating to PAM that might let you give partial capabilities to certain users who login (like CAP_SYS_TIME to your normal desktop login, so you can set the clock without using 'su'). It would be nice to be able to (relatively easily) create certain uids/gids (or names) that get special privileges automatically... then certain apps (like ping, traceroute) could be setuid something-less-powerful-than-root.  I think that'd be an interesting project to work on when I'm bored... anybody on this list think it's worthy of discussion (or not worthy -- arguing is fun, it makes for more active threads!) ?

Just remember -- we need root/uid0/whatever, because in the end, the computers are here to serve US, to do OUR bidding. And using root is what I like to term an 'executive override' -- it cuts through all the protections and guards that the kernel has, and makes the computer do what we say. That's why we don't protect root from itself.


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

