Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268254AbUHQOJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268254AbUHQOJp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268261AbUHQOJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:09:43 -0400
Received: from ida.rowland.org ([192.131.102.52]:1540 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S268254AbUHQOI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:08:57 -0400
Date: Tue, 17 Aug 2004 10:08:57 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
cc: Pete Zaitcev <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>, <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][linux-usb-devel] Early USB handoff
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B3015B698A@scl-exch2k.phoenix.com>
Message-ID: <Pine.LNX.4.44L0.0408170959180.674-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004, Aleksey Gorelov wrote:

> >>   Here is slightly improved early USB legacy handoff patch for 2.4.27
> >
> >The usual caveat is how we all wait for this to go into 2.6.
> 
> Attached is a patch for 2.6.8.1

You could reorder and simplify slightly the code for handing off a UHCI
controller.  It's safer to disable PIRQD, SMI#, and legacy support first
and then turn off the interrupt enable bits, all before stopping the
controller.  You could even reset the controller rather than just stopping
it (although you might also want to avoid the 60ms delay this requires).  
Take a look at reset_hc() in drivers/usb/host/uhci-hcd.c and see what you
think.

Alan Stern

