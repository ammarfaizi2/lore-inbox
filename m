Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264711AbTE1Mtq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264712AbTE1Mtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:49:46 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:31964 "EHLO gaston")
	by vger.kernel.org with ESMTP id S264711AbTE1Mtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:49:45 -0400
Subject: Re: Console & FBDev vs. locking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <1054122360.602.197.camel@gaston>
References: <1054122360.602.197.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054126978.541.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 28 May 2003 15:02:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-28 at 13:46, Benjamin Herrenschmidt wrote:

> All printk originated console call should done with the console
> semaphore held. The console-sem is the de-facto locking mecanism for the
> console today, while not fine-grained, it's probably plenty enough for
> what we need in 2.5 and unless previous implementations which ran with
> irqs off, the console drivers can actually block and rely on HW
> interrupts.

Hrm... Of course, this is only true for things like resize/mode change,
etc... (and soon blanking once I'm done with it). The way the console
sem is used is so that normal output originating from printk can
still happen at interrupt time.

BTW. I know some people would prefer not doing so, but I'd like to
eventually disable that 'feature', or at least add a flag to the the
consw driver telling if it supports beeing called at interrupt/spinlock
time or not, and if not, defer operations to process context. ..

Ben.
