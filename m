Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTLLB3H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 20:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTLLB3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 20:29:07 -0500
Received: from vena.lwn.net ([206.168.112.25]:44484 "HELO lwn.net")
	by vger.kernel.org with SMTP id S264450AbTLLB3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 20:29:05 -0500
Message-ID: <20031212012903.26623.qmail@lwn.net>
To: "Hettinger Tamas" <hetting@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Fri, 12 Dec 2003 00:37:23 +0100."
             <002301c3c03f$ba925250$0101010a@client> 
Date: Thu, 11 Dec 2003 18:29:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) When I set a timer, it is added to a timer_list chain with add_timer().
> If the time is up and the scheduled function is called, should I remove the
> timer_list struct from the chain via del_timer() ? Or is it removed
> automatically ?

It will be removed automatically, just before your timer function is called.

> 2) How can a module safely removed if it has some running timers ? I have to
> call del_timer() in cleanup_module() for each running timer ? 

You cannot remove a module (safely) if there are outstanding timers.  Use
del_timer_sync() to get rid of them and ensure they aren't running on
another processor.

Chapter 6 of Linux Device Drivers covers this topic; see:

	http://www.xml.com/ldd/chapter/book/ch06.html

jon
