Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264649AbUEOGRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264649AbUEOGRM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 02:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbUEOGRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 02:17:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:62592 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264649AbUEOGRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 02:17:02 -0400
Date: Fri, 14 May 2004 23:16:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Message-Id: <20040514231620.0f653afd.akpm@osdl.org>
In-Reply-To: <E1BOs7C-0003Bd-00@gondolin.me.apana.org.au>
References: <20040514175918.6b9f4c9d.akpm@osdl.org>
	<E1BOs7C-0003Bd-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> > 
> > I don't know if it's worth the effort though.  Is any other driver likely
> > to want to discriminate between reboot and shutdown?
> 
> e100 used to (and still does in 2.4) send the device into D3 on shutdown.
> This causes problems on a number of boards if the box is only rebooting
> as the driver fails to bring the device back out of D3.

Ho hum.  Greg, any preferences?  We can either:

a) Add a `restart' driver method and call that during reboot instead of
   ->shutdown, if the driver implements ->restart.  Otherwise call
   ->shutdown or

b) stick with the

	if (system_state == SYSTEM_RESTART)
		...

   thing in IDE and potentially a couple of other places?
