Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbUKRSXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUKRSXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbUKRSVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:21:08 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:29417 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262836AbUKRSBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:01:37 -0500
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
	using SELinux and SOCK_SEQPACKET
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Morris <jmorris@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Ross Kendall Axe <ross.axe@blueyonder.co.uk>, netdev@oss.sgi.com,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Xine.LNX.4.44.0411181219590.5236-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0411181219590.5236-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100797066.6019.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 18 Nov 2004 16:58:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-11-18 at 17:25, James Morris wrote:
> 1) Don't call security_unix_may_send() hook during sendmsg() for 
> SOCK_SEQPACKET, and ensure that sendmsg() can only be called on a 
> connected socket so as not to bypass the security_unix_stream_connect() 
> hook.
> 
> 2) Return -EINVAL if sendto() is called on SOCK_SEQPACKET with an address 
> supplied.

Consider shutdown(). A sendmsg into shutdown must return the pending
ECONNRESET
first. 

