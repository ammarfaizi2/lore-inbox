Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272323AbTGYVa0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272335AbTGYVa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 17:30:26 -0400
Received: from tomts11.bellnexxia.net ([209.226.175.55]:54955 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S272337AbTGYVaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 17:30:11 -0400
Date: Fri, 25 Jul 2003 17:45:19 -0400
From: Marc Heckmann <mh@nadir.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Jim Gifford <maillist@jg555.com>, Andrea Arcangeli <andrea@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre5 deadlock
Message-ID: <20030725214518.GA2826@nadir.org>
References: <008701c34a29$caabb0f0$3400a8c0@W2RZ8L4S02> <20030719172103.GA1971@x30.local> <018101c34f4d$430d5850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307210943160.25565@freak.distro.conectiva> <005a01c34fed$fea51120$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307220852470.10991@freak.distro.conectiva> <012d01c35066$2c56d400$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307221358440.23424@freak.distro.conectiva> <01f001c352e4$9025e6d0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307251638590.15120@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307251638590.15120@freak.distro.conectiva>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 04:39:29PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Fri, 25 Jul 2003, Jim Gifford wrote:
> 
> > >From talking with others, we are considering this a netfilter issue, is this
> > correct??
> 
> It seems you have isolated the problem down to additional netfilter
> patches right ?

no. standard netfilter modules. I just happened to notice that everyone
who had the problem  seemed to be using
iptables.

just to recap what the problem is:

kernel 2.4.2[10] maybe even .19, etc SMP deadlock. systems still
responds to ping, iptables logs still scroll along on the console.
but nothing else.

please see my post with ksymoops output of sysrq+T :

http://marc.theaimsgroup.com/?l=linux-kernel&m=105821579624140&w=2

however, the deadlock happened when the system was under heavy disk IO.
all filesytems are raid1, ext3.

here are my modules:

[mh@zara mh]$ /sbin/lsmod
Module                  Size  Used by    Not tainted
ip_conntrack_ftp        5424   0 (unused)
8139too                17832   1
mii                     4124   0 [8139too]
e100                   55236   1
ipt_REJECT              4024   2 (autoclean)
ipt_state               1048  34 (autoclean)
ipt_limit               1688   2 (autoclean)
ipt_LOG                 4248   4 (autoclean)
iptable_nat            22872   0 (autoclean) (unused)
ip_conntrack           29896   3 (autoclean) [ip_conntrack_ftp ipt_state
iptable_nat]
iptable_filter          2412   1 (autoclean)
ip_tables              15672   8 [ipt_REJECT ipt_state ipt_limit ipt_LOG
iptable_nat iptable_filter]
keybdev                 2944   0 (unused)
mousedev                5688   0 (unused)
hid                    16296   0 (unused)
input                   6144   0 [keybdev mousedev hid]
usbcore                80704   1 [hid]
ext3                   76096   3
jbd                    65904   3 [ext3]
raid1                  16108   4

-m
