Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVBAPvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVBAPvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 10:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVBAPvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 10:51:05 -0500
Received: from canuck.infradead.org ([205.233.218.70]:6675 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262053AbVBAPuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 10:50:39 -0500
Subject: Re: question on symbol exports
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: linuxppc-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41FFA21C.8060203@nortelnetworks.com>
References: <41FECA18.50609@nortelnetworks.com>
	 <1107243398.4208.47.camel@laptopd505.fenrus.org>
	 <41FFA21C.8060203@nortelnetworks.com>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 16:50:16 +0100
Message-Id: <1107273017.4208.132.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 09:37 -0600, Chris Friesen wrote:
> Arjan van de Ven wrote:
> > On Mon, 2005-01-31 at 18:15 -0600, Chris Friesen wrote:
> 
> >>Is there any particular reason why modules should not be allowed to 
> >>flush the tlb, or is this an oversight?
> > 
> > can you point at the url to your module source? I suspect modules doing
> > tlb flushes is the wrong thing, but without seeing the source it's hard
> > to tell.
> 
> I've included the relevent code at the bottom.  The module will be 
> released under the GPL.
> 
> I've got a module that I'm porting forward from 2.4.  The basic idea is 
> that we want to be able to track pages dirtied by an application.  The 
> system has no swap, so we use the dirty bit to get this information.  On 
> demand we walk the page tables belonging to the process, store the 
> addresses of any dirty ones, flush the tlb, and mark them clean.

afaik one doesn't need to do a tlb flush in code that clears the dirty
bit, as long as you use the proper vm functions to do so. 
(if those need a tlb flush, those are supposed to do that for you
afaik).

Also note that your code isn't dealing with 4 level pagetables.... And
pagetable walking in drivers is basically almost always a mistake and a
sign that something is wrong.



