Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbUAAUsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUAAUro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:47:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:36574 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264568AbUAAUrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:47:15 -0500
Date: Thu, 1 Jan 2004 12:42:18 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Problem with dev_kfree_skb_any() in 2.6.0
Message-Id: <20040101124218.258e8b73.davem@redhat.com>
In-Reply-To: <3FF1B939.1090108@pobox.com>
References: <1072567054.4112.14.camel@gaston>
	<20031227170755.4990419b.davem@redhat.com>
	<3FF0FA6A.8000904@pobox.com>
	<20031229205157.4c631f28.davem@redhat.com>
	<20031230051519.GA6916@gtf.org>
	<20031229220122.30078657.davem@redhat.com>
	<3FF11745.4060705@pobox.com>
	<20031229221345.31c8c763.davem@redhat.com>
	<3FF1B939.1090108@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Dec 2003 12:43:21 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Luckily, I feel there is an easy solution, as shown in the attached 
> patch.  We _already_ queue skbs in dev_kfree_skb_irq().  Therefore, 
> dev_kfree_skb_any() can simply use precisely that same solution.  The 
> raise-softirq code will immediately proceed to action if we are not in 
> hard IRQ context, otherwise it will follow the expected path.

Ok, this is reasonable and works.

Though, is there any particular reason you don't like adding a
"|| irqs_disabled()" check to the if statement instead?
I prefer that solution better actually.
