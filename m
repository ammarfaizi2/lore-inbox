Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVCDMUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVCDMUB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbVCDMSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:18:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:52697 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262777AbVCDLPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:15:53 -0500
Date: Fri, 4 Mar 2005 03:15:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: mike@waychison.com, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport complete_all
Message-Id: <20050304031504.4ea49f83.akpm@osdl.org>
In-Reply-To: <58cb370e0503040240314120ea@mail.gmail.com>
References: <422817C3.2010307@waychison.com>
	<58cb370e0503040240314120ea@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
> Andrew, what is the policy for adding exports for out of tree GPL code?
> 

There isn't one.  Such things cause way too much email.

What complete_all() does is to permit more than one task to wait on a
completion and for all those tasks to be woken by a single complete(). 
Without it you'd need to record how many tasks are sleeping there and do
complete() that many times.

So it's a sensible part of the completion API from a regularity-of-the-API
POV.  We use it in the coredump code and I don't think we'd be likely to want
to rip it out.

In fact, I'd say that complete() should have always done it this way...

