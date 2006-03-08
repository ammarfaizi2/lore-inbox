Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWCHEC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWCHEC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 23:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWCHEC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 23:02:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8902 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750890AbWCHEC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 23:02:26 -0500
Date: Tue, 7 Mar 2006 20:01:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Fw: Re: oops in choose_configuration()
In-Reply-To: <200603072230_MC3-1-BA18-21AC@compuserve.com>
Message-ID: <Pine.LNX.4.64.0603071959360.32577@g5.osdl.org>
References: <200603072230_MC3-1-BA18-21AC@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Mar 2006, Chuck Ebbert wrote:
> 
> [2] The snprintf() and print_modalias() calls don't check for errors and
> thus don't return -ENOMEM when the buffer does fill up.  Shouldn't they
> do that instead of returning a truncated env string?

They try to act like the standard says "snprintf()" should act.

And yes, the standard says to return the number of bytes you _would_ have
written, had not the buffer been to small.

(Of course, giving a negative buffer length is not ok, and the kernel 
version checking for that is a kernel extension on the standard. In the 
standard, the buffer size is a "size_t", which doesn't have the notion of 
"negative", since it's an unsigned type. The kernel version is just being 
safe and nice).

		Linus
