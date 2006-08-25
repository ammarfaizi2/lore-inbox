Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWHYHo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWHYHo6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWHYHo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:44:58 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:38094 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1751222AbWHYHo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:44:57 -0400
Date: Fri, 25 Aug 2006 00:25:01 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 9/18] 2.6.17.9 perfmon2 patch for review: kernel-level interface
Message-ID: <20060825072501.GA5219@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608250300_MC3-1-C942-6359@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608250300_MC3-1-C942-6359@compuserve.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 25, 2006 at 02:56:37AM -0400, Chuck Ebbert wrote:
> On Wed, 23 Aug 2006 15:54:47 -0700, Andrew Morton wrote:
> 
> > > > Some users have requested the ability to create a monitoring session
> > > > with perfmon2 from iside the kernel using a kernel thread. Perfmon2
> > > > leverages a lot of kernel mechanisms which are not easy to use for
> > > > inside the kernel: e.g. file descriptor, signals, system calls.
> > > 
> > > Again, please drop this.  There are no planned intree kernel users
> > > so far, and once we add them we can architect a proper API for them.
> > > Getting rid of this should also help to collapse the tons of useless
> > > abstractions layers in the current perfmon code.
> > > 
> > 
> > Yes, I think we either need a stronger argument for including this code, or
> > we drop it.
> 
> This interface is for people writing kprobes who want to do performance
> monitoring within their probe code.  There will probably never be any
> in-kernel users, just like there are no in-kernel users of kprobes.
> 
That is indeed the reason why I put this in. In the context of kprobes
code (callback), I don't think it is possible to make some upcall
to userland to interact with the perfmon2 interface. Yet, I think that
combining kprobes with monitoring could be very useful. A simple example
is to use kprobes to control where monitoring starts and stops, e.g.,
on a function boundaries.

> > It is especially worrisome that the exports which are added here are plain
> > old EXPORT_SYMBOL().
> 
> kprobes exports are all GPL, so these should be too.
> 
Yes. I am just too used to EXPORT_SYMBOL(). I will fix this in the next patch.

-- 
-Stephane
