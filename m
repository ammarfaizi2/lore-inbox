Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUIJBVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUIJBVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 21:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUIJBVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 21:21:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:442 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266836AbUIJBU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 21:20:59 -0400
Date: Thu, 9 Sep 2004 18:20:54 -0700
From: Chris Wright <chrisw@osdl.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: why is sk->skb->sk_socket->file  NULL on incoming packets?
Message-ID: <20040909182053.P1973@build.pdx.osdl.net>
References: <20040910004517.GC7587@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040910004517.GC7587@lkcl.net>; from lkcl@lkcl.net on Fri, Sep 10, 2004 at 01:45:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Luke Kenneth Casson Leighton (lkcl@lkcl.net) wrote:
> hi, simple question - if a userspace ip_queue program (fireflier)
> can determine the pid of an incoming packet, why can't ipt_owner.c
> do the same?
> 
> how do i force, even by using a userspace thing which asks the
> packet to be "re-examined", the skb->sk->sk_socket->file to be
> set?

I assume the netfilter hook you come in on is NF_IP_LOCAL_IN?  This is
at ip level.  The sock (sk) is protocol specific, and hasn't been
looked up yet.  Look at the protocols' input handlers (i.e. udp_rcv or
tcp_v4_rcv), they do this lookup (i.e. udp_v4_lookup or __tcp_v4_lookup).
The sk_filter() point is probably the first time you have an association
between the skb (inbound) and the sock it's going to be queued to.
LSM modules use security_sock_rcv_skb at this point.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
