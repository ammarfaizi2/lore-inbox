Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266070AbUAFD7o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 22:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbUAFD7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 22:59:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27024 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266070AbUAFD7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 22:59:43 -0500
Date: Mon, 5 Jan 2004 19:54:03 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Problem with dev_kfree_skb_any() in 2.6.0
Message-Id: <20040105195403.65ac4e9e.davem@redhat.com>
In-Reply-To: <20040102025807.GB3851@gtf.org>
References: <1072567054.4112.14.camel@gaston>
	<20031227170755.4990419b.davem@redhat.com>
	<3FF0FA6A.8000904@pobox.com>
	<20031229205157.4c631f28.davem@redhat.com>
	<20031230051519.GA6916@gtf.org>
	<20031229220122.30078657.davem@redhat.com>
	<3FF11745.4060705@pobox.com>
	<20031229221345.31c8c763.davem@redhat.com>
	<3FF1B939.1090108@pobox.com>
	<20040101124218.258e8b73.davem@redhat.com>
	<20040102025807.GB3851@gtf.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jan 2004 21:58:07 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> On Thu, Jan 01, 2004 at 12:42:18PM -0800, David S. Miller wrote:
> > Though, is there any particular reason you don't like adding a
> > "|| irqs_disabled()" check to the if statement instead?
> > I prefer that solution better actually.
> 
> Yep, in fact when I wrote the above message, I came across a couple when I
> was pondering...
> * the destructor runs in a more predictable context.
> * given the problem that started this thread, the 'if' test is a
>   potentially problematic area.  Why not eliminate all possibility that
>   this problem will occur again?

The way I see this, dev_kfree_skb_any() is not used in any performance critical
path, so at worst during device shutdown, reset, or power-down, TX queue
packet freeing work could be delayed by up to one jiffie.

Therefore I've put the "|| irqs_disabled()" version of the fix into my tree.

Thanks for working this out with me Jeff :)
