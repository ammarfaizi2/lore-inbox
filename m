Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTENT4k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbTENT4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:56:40 -0400
Received: from air-2.osdl.org ([65.172.181.6]:8882 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261182AbTENT4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:56:38 -0400
Date: Wed, 14 May 2003 13:05:08 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       acme@conectiva.com.br
Subject: Re: 2.5 qdisc problem
Message-Id: <20030514130508.4c6ece84.rddunlap@osdl.org>
In-Reply-To: <20030514.125923.102559449.davem@redhat.com>
References: <20030514122624.GA20480@babylon.d2dc.net>
	<20030514125941.GI15261@suse.de>
	<20030514130838.GJ15261@suse.de>
	<20030514.125923.102559449.davem@redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003 12:59:23 -0700 (PDT) "David S. Miller" <davem@redhat.com> wrote:

|    From: Jens Axboe <axboe@suse.de>
|    Date: Wed, 14 May 2003 15:08:38 +0200
|    
|    This half-assed back-out from bk current makes it work here, Arnaldo
|    could you please fix this??
| 
| This is a good clue, thanks for tracking it down this far.
| I'll help figure out what's wrong, I can reproduce the problem
| here too.
| 
| I believe the problem has something to do with changing when the
| rtnetlink/netlink init runs, not the socket owner stuff.

Ah, init ordering.  If it involvles initcalls (I see
./netlink/af_netlink.c:subsys_initcall(netlink_proto_init);),
you can set initcall_debug=1 on the kernel command line to get a
list of initcall addresses dumped into the syslog.
Then you can grep those lines and convert them to names
using
  http://www.xenotime.net/linux/scripts/cvrt_initcalls
which calls
  http://www.xenotime.net/linux/scripts/ksysmap

if that will help you any.
--
~Randy
