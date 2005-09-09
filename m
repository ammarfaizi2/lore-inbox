Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbVIIWUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbVIIWUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbVIIWUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:20:14 -0400
Received: from [67.40.69.52] ([67.40.69.52]:57586 "EHLO morpheus")
	by vger.kernel.org with ESMTP id S932577AbVIIWUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:20:12 -0400
Subject: Re: [ham] Re: Gracefully killing kswapd, or any kernel thread
From: Kristis Makris <kristis.makris@asu.edu>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0509091513310.5663@chaos.analogic.com>
References: <1126122068.2744.20.camel@syd.mkgnu.net>
	 <Pine.LNX.4.61.0509071554190.4695@chaos.analogic.com>
	 <1126127233.2743.25.camel@syd.mkgnu.net>
	 <Pine.LNX.4.61.0509071826180.4951@chaos.analogic.com>
	 <1126291900.2725.4.camel@syd.mkgnu.net>
	 <Pine.LNX.4.61.0509091513310.5663@chaos.analogic.com>
Date: Fri, 09 Sep 2005 15:20:15 -0700
Message-Id: <1126304415.2727.27.camel@syd.mkgnu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-09 at 15:20 -0400, linux-os (Dick Johnson) wrote:

> Because it's now defunct <Z>, a zombie, waiting for somebody to
> reap its return status. You are almost there, you need to issue
> the kernel equivalent of waitpid() (sys_waitpid) to grab that
> status and throw it away. That's what the code I showed you
> did when it would shut down and remove a module that had
> a kernel thread.

It turns out I had to port reparent_to_init() from 2.4 to 2.2 to get it
going. issuing a sys_wait4 wasn't enough. Apparently there was no way
for the built-in kernel threads to exit at all in the first place. I
hope 2.6 at least issues a reparent_to_init in kernel_thread().

