Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751940AbWCHA55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbWCHA55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbWCHA55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:57:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54927 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751940AbWCHA54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:57:56 -0500
Date: Tue, 7 Mar 2006 16:57:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>
cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: oops in choose_configuration()
In-Reply-To: <200603071657_MC3-1-BA0F-6372@compuserve.com>
Message-ID: <Pine.LNX.4.64.0603071648430.32577@g5.osdl.org>
References: <200603071657_MC3-1-BA0F-6372@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Mar 2006, Chuck Ebbert wrote:
> 
> At least one susbsystem rolls its own method of adding env vars to the
> uevent buffer, and it's so broken it triggers the WARN_ON() in
> lib/vsprintf.c::vsnprintf() by passing a negative length to that function.

Well, snprintf() should be safe, though. It will warn if the caller is 
lazy, but these days, the thing does

	max(buf_size - len, 0)

which should mean that the input layer passes in 0 instead of a negative 
number. And snprintf() will then _not_ print anything. 

So I think input_add_uevent_bm_var() is safe, even if it's not pretty.

However, input_devices_read() doesn't do any sanity checking at all, and 
if that ever ends up printing more than a page, that would be bad. I 
didn't look very closely, but it looks worrisome.

Dmitry?

		Linus
