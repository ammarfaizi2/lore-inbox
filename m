Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbSJRVu3>; Fri, 18 Oct 2002 17:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265407AbSJRVu3>; Fri, 18 Oct 2002 17:50:29 -0400
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:3246 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id <S265400AbSJRVu2>; Fri, 18 Oct 2002 17:50:28 -0400
Date: Fri, 18 Oct 2002 22:56:29 +0100 (BST)
From: Bruce Cran <b.j.cran@sms.ed.ac.uk>
X-X-Sender: <brucec@tweed.dcs.ed.ac.uk>
To: <linux-kernel@vger.kernel.org>
Subject: ipv4 /proc/net/route bug in 2.4 and 2.5 kernels
Message-ID: <Pine.LNX.4.33.0210182250450.17991-100000@tweed.dcs.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've discovered a bug in the 2.4 and 2.5 kernels relating to the
information in /proc.   The values reported in /proc/net/route are wrong -
the main error is the MTU field which should be MSS, and should be the
MTU-40.  The route command has the header fixed, but still gets the value
from /proc, and so reports the wrong value of
40.

I'm currently using 2.5.43, and have tracked it down to line 1031 in
net/ipv4/fib_semantics.c in function fib_node_seq_show.  It appears that
fi->fib_advmss is 0, because when I change the '+40' to '+45' that is the
value which appears in the MTU field in /proc/net/route, and in the MSS
field when running '/sbin/route -e'.

Also, on line 191 of net/ipv4/ip_proc.c (in function fib_seq_show), I
think the 'MTU' should be 'MSS' according to the comments in route.c, and
to make the output of the route command and the proc entry consistent.

--
Bruce Cran


