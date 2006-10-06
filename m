Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422812AbWJFSUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422812AbWJFSUn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422817AbWJFSUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:20:43 -0400
Received: from mx2.rowland.org ([192.131.102.7]:38408 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1422812AbWJFSUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:20:42 -0400
Date: Fri, 6 Oct 2006 14:20:42 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: Pavel Machek <pavel@ucw.cz>, <usbatm@lists.infradead.org>,
       <linux-usb-devel@lists.sourceforge.net>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>, ueagle <ueagleatm-dev@gna.org>,
       matthieu castet <castet.matthieu@free.fr>
Subject: Re: [linux-usb-devel] [PATCH 1/3] UEAGLE : be suspend friendly
In-Reply-To: <200610061710.10603.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0610061417230.1311-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006, Duncan Sands wrote:

> > Maybe UEAGLE can do something a little more sensible...
> 
> What is the modem supposed to do if it receives a packet to
> transmit after it has been told to suspend?  This is a real
> question, I'm not pretending!  I've never thought about or
> read about suspend/resume and have no idea how it is supposed
> to work.  Should it just reject it, or should it wake the
> modem up?

It depends on the context in which the modem was suspended.  If this was a 
regular system sleep transition, or some other suspend request coming from 
outside the driver, then packets should be dropped.

But if the suspend originated within the driver itself, as a power-saving 
measure while the connection was idle, then new packets should cause the 
driver to wake the modem up.  That is, self-originated suspends should be 
transparent.  Outside-originated suspends are someone else's problem.

Alan Stern

