Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTJ2AQQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 19:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTJ2AQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 19:16:15 -0500
Received: from palrel10.hp.com ([156.153.255.245]:38613 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261836AbTJ2AQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 19:16:14 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16287.1732.427119.22477@napali.hpl.hp.com>
Date: Tue, 28 Oct 2003 16:16:04 -0800
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       davem@redhat.com
Subject: Re: status of ipchains in 2.6?
In-Reply-To: <1067365417.14002.18.camel@tux.rsn.bth.se>
References: <200310280127.h9S1RM5d002140@napali.hpl.hp.com>
	<1067365417.14002.18.camel@tux.rsn.bth.se>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, Rusty mentioned the same patch yesterday.  I tried it now and
ipchain masquerading seems to be working fine again.

	--david

>>>>> On Tue, 28 Oct 2003 19:23:37 +0100, Martin Josefsson <gandalf@wlug.westbo.se> said:

  Martin> Please try this patch that just got included in linus tree.

  Martin> ChangeSet 1.1360, 2003/10/27 00:01:25-08:00, rusty@rustcorp.com.au

  Martin> [NETFILTER]: Fix ipchains oops in NAT

  Martin> We updated ip_nat_setup_info to set the initialized flag and call
  Martin> place_in_hashes, but *didn't* change the call in ip_fw_compat_masq.c
  Martin> which also calls place_in_hashes() itself (again!).  Result: corrupt
  Martin> list, and next thing which lands in the same hash bucket goes boom.

  Martin> Thanks to Andy Polyakov for chasing this down.


  Martin> # This patch includes the following deltas:
  Martin> #	           ChangeSet	1.1359  -> 1.1360 
  Martin> #	net/ipv4/netfilter/ip_fw_compat_masq.c	1.11    -> 1.12   
  Martin> #

  Martin> ip_fw_compat_masq.c |    3 ---
  Martin> 1 files changed, 3 deletions(-)


  Martin> diff -Nru a/net/ipv4/netfilter/ip_fw_compat_masq.c b/net/ipv4/netfilter/ip_fw_compat_masq.c
  Martin> --- a/net/ipv4/netfilter/ip_fw_compat_masq.c	Mon Oct 27 12:07:33 2003
  Martin> +++ b/net/ipv4/netfilter/ip_fw_compat_masq.c	Mon Oct 27 12:07:33 2003
  Martin> @@ -91,9 +91,6 @@
  Martin> WRITE_UNLOCK(&ip_nat_lock);
  Martin> return ret;
  Martin> }
  Martin> -
  Martin> -		place_in_hashes(ct, info);
  Martin> -		info->initialized = 1;
  Martin> } else
  Martin> DEBUGP("Masquerading already done on this conn.\n");
  Martin> WRITE_UNLOCK(&ip_nat_lock);

  Martin> -- 
  Martin> /Martin
