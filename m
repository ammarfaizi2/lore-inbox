Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750805AbWFEI5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWFEI5Q (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWFEI5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:57:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53666 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750805AbWFEI5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:57:15 -0400
Date: Mon, 5 Jun 2006 01:57:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, tglx@linutronix.de,
        torvalds@osdl.org
Subject: Re: [RFC][PATCH] request_irq(...,SA_BOOTMEM);
Message-Id: <20060605015702.115597cf.akpm@osdl.org>
In-Reply-To: <1149497376.8543.65.camel@localhost.localdomain>
References: <1149486009.8543.42.camel@localhost.localdomain>
	<1149491309.8543.54.camel@localhost.localdomain>
	<20060605003127.fc1ea37a.akpm@osdl.org>
	<1149493691.8543.57.camel@localhost.localdomain>
	<20060605012405.ac17f918.akpm@osdl.org>
	<1149497376.8543.65.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2006 18:49:36 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > And yes, the mutex code will (with debug enabled) unconditionally enable
> > interrupts.  ppc64 tends to oops when this happens, in the timer handler
> > (so it'll be intermittent...)
> 
> I tend to say that any code that hard-enables interrupts is looking for
> trouble (mostly for that very reason of init stuff).

Usually.  But it's 100% daft to be preserving local irq state in
mutex_lock().
