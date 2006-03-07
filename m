Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWCGV6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWCGV6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWCGV6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:58:13 -0500
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:21137 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964785AbWCGV6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:58:12 -0500
Date: Tue, 7 Mar 2006 16:54:24 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Fw: Re: oops in choose_configuration()
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200603071657_MC3-1-BA0F-6372@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.64.0603051840280.13139@g5.osdl.org>

On Sun, 5 Mar 2006 19:27:53 -0800, Linus Torvalds wrote:

> So I'd be more inclined to blame a buffer overflow on a kmalloc, and the 
> obvious target is the "add_uevent_var()" thing, since all/many of the 
> corruptions seem to come from uevent environment variable strings.

At least one susbsystem rolls its own method of adding env vars to the
uevent buffer, and it's so broken it triggers the WARN_ON() in
lib/vsprintf.c::vsnprintf() by passing a negative length to that function.
Start at drivers/input/input.c::input_dev_uevent() and watch the fun.

I reported this to linux-kernel, the input maintainer and the author
of that code on Feb. 26:

        http://lkml.org/lkml/2006/2/26/39


-- 
Chuck
"Penguins don't come from next door, they come from the Antarctic!"

