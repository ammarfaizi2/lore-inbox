Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbULFWUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbULFWUn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbULFWUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:20:43 -0500
Received: from v6.netlin.pl ([62.121.136.6]:36622 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261679AbULFWUe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:20:34 -0500
Date: Mon,  6 Dec 2004 23:20:26 +0100
X-Mailer: JAW::Mail jawmail-2.0.1
X-Originating-IP: 195.150.77.250
Organization: K4 Labs
From: gj <gj@pointblue.com.pl>
To: <Valdis.Kletnieks@vt.edu>, Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Subject: Re: ip contrack problem, not strictly followed RFC, DoS very much possible 
Cc: kernel list <linux-kernel@vger.kernel.org>, <coreteam@netfilter.org>
In-Reply-To: <200412061948.iB6JmOpY003565@turing-police.cc.vt.edu>
References: <41B464B3.8020807@pointblue.com.pl> <200412061948.iB6JmOpY003565@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <20041206222026.C2DF41B@pointblue.com.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004 at 20:48:45, Valdis.Kletnieks@vt.edu wrote:

> On Mon, 06 Dec 2004 14:54:59 +0100, Grzegorz Piotr Jaskiewicz said:
> 
> > There is little bug, eversince, no author would agree to correct it 
> > (dunno why) in ip_conntrack_proto_tcp.c:91:
> > unsigned long ip_ct_tcp_timeout_established =   5 DAYS;
> 
> If you so desire, you can probably workaround this by doing:
> 
> echo 100 >
> /proc/sys/net/ipv4/netfilter/ip_conntrack_tcp_timeout_established
> 
> Of course, then if you don't type in an SSH window for 5 minutes, it
> evaporates
> on you - and even SSH keepalives don't help if a router takes a nose dive
> and
> it takes 2 minutes for our NOC to slap it upside the head.  This is a case
> *against* keepalives there - if a router hiccups and drops a keepalive on
> an
> otherwise idle session, you nuke a perfectly good idle session for reasons
> totally contrary to the original purpose of TCP, namely to *survive* such a
> router burp.

Shouldn't it be protocols thingie to take care about connections ?
Ussualy some protocols are sending ping packet to peer. 
This value as it is now, keeps too many connections in memory, which often leads
to conntrack overflow, that blocks litteraly whole machine up. That is nothing
more than DoS, and besides, there is no fallback routine, something that uppon
error would react. Like, flush very likely to be dead connections, etc.



-- 
Grzegorz Jaskiewicz
K4 Labs
