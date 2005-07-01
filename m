Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263203AbVGACxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbVGACxh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 22:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbVGACxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 22:53:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:64913
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S263203AbVGACxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 22:53:32 -0400
Date: Thu, 30 Jun 2005 19:52:54 -0700 (PDT)
Message-Id: <20050630.195254.71110580.davem@davemloft.net>
To: akpm@osdl.org
Cc: 76306.1226@compuserve.com, netdev@vger.kernel.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (dropped patches?)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050630161456.2ef0ab32.akpm@osdl.org>
References: <200506301605_MC3-1-A320-D9D6@compuserve.com>
	<20050630161456.2ef0ab32.akpm@osdl.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Thu, 30 Jun 2005 16:14:56 -0700

> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >
> > What happened to:
> > 
> >         remove-last_rx-update-from-loopback-device.patch
> 
> Davem rejected it.  hm, I can't find the email trail - it was cc'ed to
> netdev@oss.sgi.com mid-March, but nothing seems to have been sent back.

Every network device must reliably set ->last_rx, there are parts
of the kernel which depend upon this attribute having an accurate
value.

The bonding driver is one example.  And whilst one can argue that
loopback is unlikely to be used as part of a bond, it's massively
better from a consistency perspective if this invariant can be
relied upon across all networking drivers.

In short, the NUMA scalability hacks to loopback have gotten out
of control, and we need to stop this madness somewhere.
