Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbUAYR50 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 12:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbUAYR5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 12:57:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12434 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265063AbUAYR5Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 12:57:24 -0500
Date: Sun, 25 Jan 2004 17:57:23 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jan Ischebeck <mail@jan-ischebeck.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.2-rc1-mm2: sleep_on_timeout with parport
Message-ID: <20040125175723.GQ21151@parcelfarce.linux.theplanet.co.uk>
References: <1074870538.5122.9.camel@JHome.uni-bonn.de> <20040123103959.4dcf5b58.akpm@osdl.org> <1075046073.26778.3.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075046073.26778.3.camel@JHome.uni-bonn.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 04:55:01PM +0100, Jan Ischebeck wrote:
> Trying to print without switching the printer on I got the following
> error messages.
> 
> lp0 out of paper
> Badness in interruptible_sleep_on_timeout at kernel/sched.c:2245
> Call Trace:
>  [<c0121a6f>] interruptible_sleep_on_timeout+0x10f/0x120
>  [<c0121500>] default_wake_function+0x0/0x20
>  [<e0a34e5f>] parport_release+0x7f/0x140 [parport]

Yeah...  parport locking primitives (and, frankly, the rest of parport
API) apparently had been designed on serious drugs.

I'm cleaning up that crap; some patches are already in -mm, more will
follow.  In particular, yes, parprt_claim()/parport_claim_or_block()/
parport_release() is racy and most of the users have problems with
missing wakeups.
