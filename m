Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUBYVhu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbUBYVfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:35:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:15786 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261551AbUBYVex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:34:53 -0500
Date: Wed, 25 Feb 2004 13:36:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux@MichaelGeng.de (Michael Geng)
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: [ANNOUNCE] new driver for teletext decoder SAA5246A
Message-Id: <20040225133647.1a9a3231.akpm@osdl.org>
In-Reply-To: <20040225181041.GA2446@t-online.de>
References: <20040225113437.GA1824@t-online.de>
	<20040225041330.51961b28.akpm@osdl.org>
	<20040225181041.GA2446@t-online.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@MichaelGeng.de (Michael Geng) wrote:
>
> No, it doesn't shrink. I already tested that when I developed 
> the driver with saa5249.c as a template. Now I made a completely
> inline-free version, but /usr/bin/size shows exactly the same
> size. By the way, this shows that gcc does a good job. Of course
> this could also depend on the architecture, but on my Pentium 4
> box gcc really puts the inline parts inline.

Yup.  I was suggesting remmoval of the `inline' keyword, rather than
actually moving the bodies of those functions into the caller.

I've previously seen significant code size reductions by _not_ inlining
large functions which had a single call site - just leave them as normal
out-of-line functions.  So it worth experimenting with - pretty simple to
do.  But if you're using a recent gcc it's probably inlining the function
even when it's not marked inline.   Whatever.

> If you want to add the patch, how about the following changelog:
> 
> [V4L]: Added new driver for Teletext decoder SAA5246A from Philips

Thanks.
