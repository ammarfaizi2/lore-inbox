Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266903AbUIJB06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266903AbUIJB06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 21:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUIJB06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 21:26:58 -0400
Received: from open.hands.com ([195.224.53.39]:31200 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S266914AbUIJBZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 21:25:10 -0400
Date: Fri, 10 Sep 2004 02:36:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: why is sk->skb->sk_socket->file  NULL on incoming packets?
Message-ID: <20040910013624.GG11160@lkcl.net>
References: <20040910004517.GC7587@lkcl.net> <20040909182053.P1973@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909182053.P1973@build.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 06:20:54PM -0700, Chris Wright wrote:
> * Luke Kenneth Casson Leighton (lkcl@lkcl.net) wrote:
> > hi, simple question - if a userspace ip_queue program (fireflier)
> > can determine the pid of an incoming packet, why can't ipt_owner.c
> > do the same?
> > 
> > how do i force, even by using a userspace thing which asks the
> > packet to be "re-examined", the skb->sk->sk_socket->file to be
> > set?
> 
> I assume the netfilter hook you come in on is NF_IP_LOCAL_IN?  This is
> at ip level.  The sock (sk) is protocol specific, and hasn't been
> looked up yet.  Look at the protocols' input handlers (i.e. udp_rcv or
> tcp_v4_rcv), they do this lookup (i.e. udp_v4_lookup or __tcp_v4_lookup).
> The sk_filter() point is probably the first time you have an association
> between the skb (inbound) and the sock it's going to be queued to.
> LSM modules use security_sock_rcv_skb at this point.
 
 oooo *wide-eyed*. thanks

