Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWH1UCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWH1UCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWH1UCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:02:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16044 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751128AbWH1UCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:02:41 -0400
Date: Mon, 28 Aug 2006 13:02:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, tchicks@us.ibm.com, tshighla@us.ibm.com
Subject: Re: [PATCH 1/4] eCryptfs: Netlink functions for public key
Message-Id: <20060828130237.23d965aa.akpm@osdl.org>
In-Reply-To: <20060825191837.GA3122@us.ibm.com>
References: <20060824181722.GA17658@us.ibm.com>
	<20060824181831.GB17658@us.ibm.com>
	<20060824205419.c3894612.akpm@osdl.org>
	<20060825191837.GA3122@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006 14:18:37 -0500
Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> > - _why_ does it use netlink?
> 
> Netlink provides the transport mechanism that would minimize the
> complexity of the implementation, given that we can have multiple
> daemons (one per user). I explored the possibility of using relayfs,
> but that would involve having to introduce control channels and a
> protocol for creating and tearing down channels for the daemons. We do
> not have to worry about any of that with netlink.

I'd have thought that a more appropriate communication mechanism would be
something which uses a file descriptor: a pipe, or a /dev node or whatever.

That way, the endpoints are more tightly defined and the
daemon-didnt-send-quit problem gets solved.  In fact, the quit message
might become unneeded: just use close()?
