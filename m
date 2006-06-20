Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWFTAgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWFTAgw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 20:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWFTAgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 20:36:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39043 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964890AbWFTAgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 20:36:51 -0400
Date: Mon, 19 Jun 2006 17:40:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bongani Hlope <bhlope@mweb.co.za>
Cc: randy.dunlap@oracle.com, linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
Message-Id: <20060619174006.647e02c7.akpm@osdl.org>
In-Reply-To: <200606150738.18724.bhlope@mweb.co.za>
References: <44909A32.3010304@oracle.com>
	<200606150738.18724.bhlope@mweb.co.za>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bongani Hlope <bhlope@mweb.co.za> wrote:
>
> > @@ -342,7 +341,10 @@ static int acpi_ec_poll_read(union acpi_
> >  			return_VALUE(-ENODEV);
> >  	}
> >
> > -	spin_lock_irqsave(&ec->poll.lock, flags);
> > +	if (down_interruptible(&ec->polling.sem)) {
>                                                      ^^^^
> isn't this suppose to be: &ec->poll.sem

Good question.   Did it get resolved?
