Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268420AbUILDC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268420AbUILDC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 23:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268423AbUILDC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 23:02:27 -0400
Received: from [69.28.190.101] ([69.28.190.101]:50156 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S268420AbUILDCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 23:02:24 -0400
Date: Sat, 11 Sep 2004 23:01:50 -0400
From: David Eger <eger@havoc.gtf.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The Serial Layer
Message-ID: <20040912030150.GA22858@havoc.gtf.org>
References: <1094582980.9750.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094582980.9750.12.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 07:49:42PM +0100, Alan Cox wrote:
> Is anyone currently looking at fixing this before I start applying
> extreme violence ? 

While you're at it, could you patch it up so we can have more than one
serial device again?  I tracked down a bug a month ago having to do
with the pmac_zilog driver freaking out because it tried to 

  uart_register(major=TTY_MAJOR, minor=64, nr=foo)

and someone else had gotten there first.  It boils down to a call
to register_chrdev_region(), which fails if the requested space is
taken, instead of looking past the claimed device numbers for some
more empty ones...

-dte
