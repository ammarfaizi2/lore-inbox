Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWBXARY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWBXARY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWBXARY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:17:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14979 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932216AbWBXARW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:17:22 -0500
Date: Thu, 23 Feb 2006 16:16:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: stern@rowland.harvard.edu, sekharan@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Avoid calling down_read and down_write during startup
Message-Id: <20060223161631.6f8fa41d.akpm@osdl.org>
In-Reply-To: <20060223223729.GE30329@kvack.org>
References: <20060223110350.49c8b869.akpm@osdl.org>
	<Pine.LNX.4.44L0.0602231728300.4579-100000@iolanthe.rowland.org>
	<20060223223729.GE30329@kvack.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> wrote:
>
> On Thu, Feb 23, 2006 at 05:36:56PM -0500, Alan Stern wrote:
>  > This patch (as660) changes the registration and unregistration routines 
>  > for blocking notifier chains.  During system startup, when task switching 
>  > is illegal, the routines will avoid calling down_write().
> 
>  Why is that necessary?  The down_write() will immediately succeed as no 
>  other process can possibly be holding the lock when the system is booting, 
>  so the special casing doesn't fix anything.

down_write() unconditionally (and reasonably) does local_irq_enable() in
the uncontended case.  And enabling local interrupts early in boot can
cause crashes.
