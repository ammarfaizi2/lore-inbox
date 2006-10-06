Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751764AbWJFDpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWJFDpq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 23:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWJFDpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 23:45:46 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:64661 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751764AbWJFDpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 23:45:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=b7AQ/VLj0VaNXpOBPwFsdmphd8pxtEfZ900QtcB7y92S7fkTDfz/94Yn+wBk6YLh4u6zPO2kI35RmQQxu31JYiXP+M6KvsIJedsuLNg+oD0R/7EwEb30RlQeafN4u9UxFLw9AkNgcF2HlnCA7wbPPj1AqUvjdQ0jY/o8PwVFMl8=  ;
From: David Brownell <david-b@pacbell.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Date: Thu, 5 Oct 2006 20:45:40 -0700
User-Agent: KMail/1.7.1
Cc: Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0610031355370.6765-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0610031355370.6765-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052045.41211.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 October 2006 11:03 am, Alan Stern wrote:

> > > Notice another questionable use of hcd->state. 
> > 
> > Questionable in what way?  When that code is called to clean up
> > after driver death, that loop must be ignored ... every pending I/O
> > can safely be scrubbed.  That's the main point of that particular
> > HC_IS_RUNNING() test.  In other cases, it's essential not to touch
> > DMA queue entries that the host controller is still using.
> 
> Questionable because changes to hcd->state aren't synchronized with the
> driver.  In this case it probably doesn't end up making any difference.

The driver changes hcd->state with its spinlock held ... or it did,
last time I audited that code.


> Removing "regs &&" might change other aspects too.  For instance, does 
> this routine ever get called from a timer routine, where regs would 
> normally be NULL?  In such situations removing "regs &&" would reverse 
> the sense of the test.

As I said in my previous comments:  should not be an issue.  OHCI doesn't
have timers.  That routine is normally called in_irq(), with the other
two call sites being cases where the controller is stopped.

- Dave
