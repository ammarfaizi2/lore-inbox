Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263006AbUKSAoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbUKSAoc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUKSAoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 19:44:02 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:60649 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261221AbUKSAnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 19:43:25 -0500
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
	using SELinux and SOCK_SEQPACKET
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Morris <jmorris@redhat.com>
Cc: Ross Kendall Axe <ross.axe@blueyonder.co.uk>, netdev@oss.sgi.com,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Xine.LNX.4.44.0411181328460.5555-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0411181328460.5555-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100821144.6005.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 18 Nov 2004 23:39:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-18 at 18:40, James Morris wrote:
> One thing that looks broken (unrelated to the patch I posted) is that
> unix_dgram_sendmsg() already does not check sk->sk_shutdown &
> SEND_SHUTDOWN for SOCK_SEQPACKET.

Looks like a real bug yes.

As to the other stuff I think the only change needed is to check the
queued asynchronous error and report that before going on to the
connected test

