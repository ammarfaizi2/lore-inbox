Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTJFV7k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 17:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbTJFV7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 17:59:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29850 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261746AbTJFV7h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 17:59:37 -0400
Date: Mon, 6 Oct 2003 22:59:36 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Haverkamp <markh@osdl.org>, linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] 2.6.0 aacraid driver update
Message-ID: <20031006215936.GF24824@parcelfarce.linux.theplanet.co.uk>
References: <1065475285.17021.79.camel@markh1.pdx.osdl.net> <3F81E34A.1040201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F81E34A.1040201@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 05:48:58PM -0400, Jeff Garzik wrote:
> >+		/*
> >+		 *	Yield the processor in case we are slow 
> >+		 */
> >+		set_current_state(TASK_UNINTERRUPTIBLE);
> >+		schedule_timeout(1);
> 
> hmmm... why not simply call yield() here instead?  I think yield() is 
> closer to the intent you wish to achieve...

Gods, no.  I believe it is always a bug for drivers to call yield()
in 2.6.  What is probably meant here is cond_resched().  I'd support
deleting the EXPORT_SYMBOL(yield) line and fixing the breakage afterwards
as it causes lots of very subtle breakage ("Under certain circumstances,
Linux just stops doing anything for 5 seconds").

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
