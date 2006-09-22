Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWIVSEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWIVSEU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 14:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWIVSEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 14:04:20 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16803
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964814AbWIVSET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 14:04:19 -0400
Date: Fri, 22 Sep 2006 11:04:36 -0700 (PDT)
Message-Id: <20060922.110436.34753480.davem@davemloft.net>
To: nenolod@atheme.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2.6.18 try 2] net/ipv4: sysctl to allow non-superuser
 to bypass CAP_NET_BIND_SERVICE requirement
From: David Miller <davem@davemloft.net>
In-Reply-To: <AD838733-3A8F-4B3E-B620-9B2284B8B2BF@atheme.org>
References: <736CE60D-FB88-4246-8728-B7AC7880B28E@atheme.org>
	<20060922.164109.112537486.yoshfuji@linux-ipv6.org>
	<AD838733-3A8F-4B3E-B620-9B2284B8B2BF@atheme.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Pitcock <nenolod@atheme.org>
Date: Fri, 22 Sep 2006 03:27:22 -0500

> * The software is untrusted by the end user, in the event that the  
> software is not trustworthy, the amount of damage it can do running  
> as a normal user is less than as a superuser. As it is, the bind()  
> may have failed before the CAP_NET_BIND_SERVICE capability was  
> granted to the process.

You have the power to exec() the daemon in question with
CAP_NET_BIND_SERVICE capability inherited from the parent,
and that will be the only "extra" capability the process will
have.

So there is in fact an existing mechanism for doing this.

If you have the power to set the sysctl, you have the power
to give the capability to an arbitrary process which you
want to get lower ports but do not trust to run completely
as root.
