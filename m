Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUCNSOd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 13:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbUCNSOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 13:14:33 -0500
Received: from mill.mtholyoke.edu ([138.110.30.76]:13191 "EHLO
	mill.mtholyoke.edu") by vger.kernel.org with ESMTP id S261920AbUCNSO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 13:14:27 -0500
From: Ron Peterson <rpeterso@mtholyoke.edu>
Date: Sun, 14 Mar 2004 13:13:50 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: network/performance problem
Message-ID: <20040314181350.GB28180@mtholyoke.edu>
References: <20040311152728.GA11472@mtholyoke.edu> <20040311151559.72706624.akpm@osdl.org> <20040311233525.GA14065@mtholyoke.edu> <20040312164704.GA17969@mtholyoke.edu> <20040312225606.GA19722@mtholyoke.edu> <20040313223349.3dcbfb61.davem@redhat.com> <20040314132339.GA27540@mtholyoke.edu> <20040314093358.26147c5f.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314093358.26147c5f.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 09:33:58AM -0800, David S. Miller wrote:
> On Sun, 14 Mar 2004 08:23:40 -0500
> Ron Peterson <rpeterso@mtholyoke.edu> wrote:
> 
> > Don't think so.  If I revert to 2.4.20 from 2.4.21, and change nothing
> > else, this problem goes away.
> 
> That's right because a netfilter change during that time period
> makes certain auto-rule adding setups go berzerk and it's a bug
> in the netfilter userland bits not the kernel.

I may indeed be completely dense.  That's not unheard of around these
parts.  I'd certainly accept an explanation of my denseness in lieue of
any other explanation, as long as I can make this stop happening.

What is the nature of the auto-rule adding setups going berzerk problem?

Below are my current iptables rules on 'sam' (the only machine not
currently running 2.4.20).  There are no jumps to user defined chains.
I have not installed any scripts that dynamically add/alter iptables
rules.  I can't imagine what package I may have installed that might do
such a thing either.  Even if there were such a script somehow, since
nothing below ever jumps anywhere else, it wouldn't be getting called,
right?

If I flush and expunge my rules as follows, the problem goes away.  If
this was because a jump to user defined chain was being deleted, then I'd
understand.  But there are no jumps out of INPUT, OUTPUT, FORWARD,
PREROUTING, or POSTROUTING, so I'm confused.

$IPTABLES -F
$IPTABLES -t nat -F
$IPTABLES -X
$IPTABLES -P INPUT ACCEPT
$IPTABLES -P OUTPUT ACCEPT
$IPTABLES -P FORWARD ACCEPT

FWIW, I compiled the latest 'iptables' code against my current running
2.4.21 kernel also..

1052# iptables -V
iptables v1.2.9

1045# iptables -L
Chain INPUT (policy DROP)
target     prot opt source               destination
ACCEPT     all  --  anywhere             anywhere            state RELATED,ESTABLISHED
ACCEPT     icmp --  138.110.0.0/16       anywhere            icmp echo-request
ACCEPT     tcp  --  anywhere             anywhere            tcp dpt:ssh
ACCEPT     tcp  --  anywhere             anywhere            tcp dpt:https
ACCEPT     all  --  anywhere             localhost

Chain FORWARD (policy DROP)
target     prot opt source               destination

Chain OUTPUT (policy DROP)
target     prot opt source               destination
ACCEPT     all  --  anywhere             anywhere            state NEW,RELATED,ESTABLISHED

Sun Mar 14 12:57:25 root@sam /usr/src
1046# iptables -L -t nat
Chain PREROUTING (policy ACCEPT)
target     prot opt source               destination

Chain POSTROUTING (policy ACCEPT)
target     prot opt source               destination

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination

-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://www.mtholyoke.edu/~rpeterso
