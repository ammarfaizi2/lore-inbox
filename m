Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVCOQMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVCOQMb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVCOQMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:12:31 -0500
Received: from sccrmhc14.comcast.net ([204.127.202.59]:34753 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261365AbVCOQMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:12:19 -0500
Subject: Re: [PATCH][RFC] Make /proc/<pid> chmod'able
From: Albert Cahalan <albert@users.sf.net>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503151446140.2662@be1.lrz>
References: <1110771251.1967.84.camel@cube>
	 <42355C78.1020307@lsrfire.ath.cx> <1110816803.1949.177.camel@cube>
	 <Pine.LNX.4.58.0503142333480.6357@be1.lrz> <1110854667.7893.203.camel@cube>
	 <Pine.LNX.4.58.0503151446140.2662@be1.lrz>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 10:58:06 -0500
Message-Id: <1110902286.7893.237.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 15:31 +0100, Bodo Eggert wrote:
> (snipped the CC list - hope that's ok)
> 
> On Mon, 14 Mar 2005, Albert Cahalan wrote:
> > On Tue, 2005-03-15 at 00:08 +0100, Bodo Eggert wrote:
> > > On Mon, 14 Mar 2005, Albert Cahalan wrote:

> > This really isn't about security.
> 
> Information leakage is a security aspect.

If you will go to such extremes, Linux is poorly suited.
A user can detect activity on the computer by examining
the performance of their own activity.

> > Privacy may be undesirable.
> 
> May. That's why I suggested the min/max sysctl.
> 
> > With privacy comes anti-social behavior.
> 
> With anti-social behavior comes the admin and his LART.
> 
> BTW: If the users want to be anti-social, they'll just rename setiathome 
> to something like -bash or soffice.

This does not matter: "Rene, your soffice program is eating
too much CPU time. Find some other place to run it."

> > Supposing that the
> > users do get privacy, perhaps because the have paid for it:
> 
> Vservers,
> > Xen, UML, VM, VMware, separate computers
> > 
> > Going with separate computers is best.
> 
> If you like wasting space and energy. If the user's demands don't exceed 
> one percent of a historic PC, there is no point in buying more hardware.

Sure there is:

a. info leakage (way more than just /proc)
b. admin control
c. budget control
d. downtime hits fewer users

> > Don't forget to use
> > network traffic control to keep users from being able to
> > detect the network activity of other users.
> 
> Like that:?
> 
> $ netstat
> Active Internet connections (w/o servers)
> Proto Recv-Q Send-Q Local Address           Foreign Address         State
> /proc/net/tcp: Permission denied

Nope. If you really care about information leakage, you'll
be concerned about the ability to detect network congestion.

Example #1

A spy sends packets from time to time. He measures the delay
and packet loss to determine if the network is busy. When the
network suddenly becomes busy, he can guess that you have
started some operation that requires heavy network traffic.

Example #2

A spy sends packets from time to time. He measures the delay
and packet loss to determine if the network is busy. Over time,
he learns when workers are busy. From this he can determine an
appropriate time to sneak into your building.

Hey, if you're going to be paranoid about %CPU and %MEM, you
have to be paranoid about %NET too. This requires traffic
control unless you have separate networks. Assign a fixed
portion of bandwidth to any user that you wish to hide info
from. Be sure to consider latency as well.

> > > > Users who want privacy can get their
> > > > own computer. So, these need to work:
> > > > 
> > > > ps [...]
> > > > w
> > > > top
> > > 
> > > Works as intended. Only pstree breaks, if init isn't visible.
> > 
> > They work like they do with a rootkit installed.
> > Traditional behavior has been broken.
> 
> They are as broken as finger or ls are if the home directory is chmodded.

Probably something should be done to deal with the problem of
a chmodded home directory. It's not ls that matters though.
It's du that matters. On a normal shared system, a user should
be able to see where all the disk blocks and inodes are going.
Filenames need not be visible. Then: "Rene, you're being kind
of greedy about the disk space aren't you? You're using 666 GB."


