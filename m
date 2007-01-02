Return-Path: <linux-kernel-owner+w=401wt.eu-S964964AbXABTgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbXABTgG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 14:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbXABTgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 14:36:05 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45748 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964964AbXABTgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 14:36:02 -0500
Subject: Re: tty->low_latency + irq context
From: Hollis Blanchard <hollisb@us.ibm.com>
Reply-To: Hollis Blanchard <hollisb@us.ibm.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       p.hardwick@option.com
In-Reply-To: <20070102183829.10d861fc@localhost.localdomain>
References: <45906820.10805@gmail.com> <1167758231.5616.22.camel@basalt>
	 <20070102183829.10d861fc@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Tue, 02 Jan 2007 13:36:01 -0600
Message-Id: <1167766562.5616.29.camel@basalt>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 18:38 +0000, Alan wrote:
> > with tty->low_latency set, but it doesn't AFAICS. One possibility
> for
> > deadlock is if the tty->buf.lock spinlock is taken on behalf of a
> user
> > process...
> 
> The case to watch out for is
> 
>         flip_buffer_push -> ldisc -> driver write of echo/^S/^Q
> 
> if you call flip_buffer_push while holding your own lock you may get
> in a mess on the echo path. 

Agreed. However, that's not what the comment says:

 *      tty_flip_buffer_push    -       terminal
 *      @tty: tty to push
 *
 *      Queue a push of the terminal flip buffers to the line discipline. This
 *      function must not be called from IRQ context if tty->low_latency is set.

-- 
Hollis Blanchard
IBM Linux Technology Center

