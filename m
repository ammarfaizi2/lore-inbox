Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264196AbUFFWZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbUFFWZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 18:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbUFFWZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 18:25:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:10115 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264196AbUFFWZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 18:25:55 -0400
Subject: Re: [PATCH][RFC] Spinlock-timeout
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com>
References: <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1086560618.10538.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 06 Jun 2004 17:23:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-05 at 15:31, Jake Moilanen wrote:
> Here's a patch that will BUG() when a spinlock is held for longer then X
> seconds.  It is useful for catching deadlocks since not all archs have a
> NMI watchdog.  
> 
> It is also helpful to find locks that are held too long.
> 
> Please send comments.

It would be better to use the timebase on CPUs that have one, no ? Or
you'll miss cases where either irqs are disabled or you are on a code
path issued by the timer interrupt, and thus jiffies isn't updated


