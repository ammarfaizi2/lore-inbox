Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbUKRFKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbUKRFKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 00:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbUKRFKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 00:10:41 -0500
Received: from cantor.suse.de ([195.135.220.2]:16796 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262564AbUKRFKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 00:10:33 -0500
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH} Network interface for IPMI
References: <31Fe2-5kB-11@gated-at.bofh.it>
From: Andi Kleen <ak@suse.de>
Date: 18 Nov 2004 05:36:44 +0100
In-Reply-To: <31Fe2-5kB-11@gated-at.bofh.it>
Message-ID: <p73oehv22oz.fsf@brahms.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <cminyard@mvista.com> writes:

> I have decided
> that the network interface for IPMI is a good thing, as the IPMI
> device ioctls have pointers and require ugly hacks.  None should be
> needed for the network interface.

That's a joke, right? 
 

> +struct ipmi_sock_msg {
> +	int                   recv_type;
> +	long                  msgid;
        ^^^^^^^^^^^

Of course long would need to be always emulated. Your patch
shows exactly why packet based protocols for this are a bad
idea. The problem is that people will get it wrong, and then
it's nearly impossible to fix for a socket based protocol
because read/write cannot be easily hooked
(with ipsec we have exactly this problem already)

ioctls at least can be fixed up. Please keep using them.

> +	int                   data_len;
> +	unsigned char         data[0];

And I don't even want to know what's in there.

Andrew, please don't apply this broken patch.

-Andi

