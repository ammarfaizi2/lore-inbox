Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbUCYSqq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 13:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbUCYSqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 13:46:45 -0500
Received: from ida.rowland.org ([192.131.102.52]:14084 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S263552AbUCYSqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 13:46:01 -0500
Date: Thu, 25 Mar 2004 13:46:00 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Colin Leroy <colin@colino.net>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Re: [linux-usb-devel] Re: [OOPS] reproducible oops with
 2.6.5-rc2-bk3
In-Reply-To: <20040325184620.3b6b070c@jack.colino.net>
Message-ID: <Pine.LNX.4.44L0.0403251341550.1083-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004, Colin Leroy wrote:

> Hi, 
> 
> Found out !
> cdc-acm wants both interfaces to be ready (cur_altsetting initialized) when acm_probe() is called. Hence, we have to make two parts out of the loop in message.c::usb_set_configuration(): one to init things, one to register them. 
> 
> The attached patch does that. It fixes the oops, and doesn't break any of my USB peripheral (printer, scanner, mouse, and diskonkey).
> 
> I hope it's fine enough to go in :)

It's obvious once you see the problem, isn't it?

Duncan Sands found exactly the same problem and the same solution a few 
months ago, but it was never added in.

In this case, your patch could be improved by calling device_initialize()  
during the first loop and device_add() during the second.  However, that
region of code is kind of in flux right at the moment.  When things settle
down, I promise to remember your change and make sure it gets in.

Alan Stern

