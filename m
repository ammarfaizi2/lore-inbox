Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266756AbUJWFcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266756AbUJWFcV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUJWFcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:32:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:3460 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266756AbUJWF3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 01:29:44 -0400
Date: Fri, 22 Oct 2004 22:27:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: printk() with a spin-lock held.
Message-Id: <20041022222746.0313ed9f.akpm@osdl.org>
In-Reply-To: <1098503815.13176.2.camel@krustophenia.net>
References: <Pine.LNX.4.61.0410221504500.6075@chaos.analogic.com>
	<1098503815.13176.2.camel@krustophenia.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Fri, 2004-10-22 at 15:07 -0400, Richard B. Johnson wrote:
> > Linux-2.6.9 will bug-check and halt if my code executes
> > a printk() with a spin-lock held.
> > 
> > Is this the intended behavior?
> 
> Yes.  printk() can sleep.  No sleeping with a spinlock held.
> 

printk() does not sleep and may be called from any context except

a) NMI handlers and

b) when holding a scheduler runqueue->lock while klogd is running.
