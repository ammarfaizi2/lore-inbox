Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVCPJPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVCPJPg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 04:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVCPJPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 04:15:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:56977 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262300AbVCPJPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 04:15:32 -0500
Date: Wed, 16 Mar 2005 01:15:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: rostedt@goodmis.org, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-Id: <20050316011510.2a3bdfdb.akpm@osdl.org>
In-Reply-To: <20050316085029.GA11414@elte.hu>
References: <1110578809.19661.2.camel@mindpipe>
	<Pine.LNX.4.58.0503140214360.697@localhost.localdomain>
	<Pine.LNX.4.58.0503140427560.697@localhost.localdomain>
	<Pine.LNX.4.58.0503140509170.697@localhost.localdomain>
	<Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
	<Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
	<20050315120053.GA4686@elte.hu>
	<Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
	<20050315133540.GB4686@elte.hu>
	<Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
	<20050316085029.GA11414@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Damn! The answer was right there in front of my eyes! Here's the
> > cleanest solution. I forgot about wait_on_bit_lock.  I've converted
> > all the locks to use this instead. [...]
> 
> ah, indeed, this looks really nifty. Andrew?
> 

There's a little lock ranking diagram in jbd.h which tells us that these
locks nest inside j_list_lock and j_state_lock.  So I guess you'll need to
turn those into semaphores.

