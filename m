Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUHaQ0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUHaQ0J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUHaQZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:25:46 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:13505 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262406AbUHaQYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:24:31 -0400
Date: Tue, 31 Aug 2004 21:51:40 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: RCU callback and scheduling while atomic!
Message-ID: <20040831162140.GD3957@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040831161710.GA21782@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831161710.GA21782@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 06:17:10PM +0200, Herbert Poetzl wrote:
> 
> it seems that the RCU callback is not allowed 
> to (re-)schedule, as it is done occasionally by 
> put_namespace() for example, as I keep getting 
> "bad: scheduling while atomic!", when I do so ...
> 
> now the question: what is the 'correct' way to
> drop a reference to a namespace when freeing up 
> a structure from an RCU callback?

You are right about not allowing schedule from callbacks. The callbacks
are called from softirq context.

Without your current code, it is difficult to say how to do this but here are
some guesses - 

1. You could mark the freed up structure deleted on update, do
   put_namspace() and do only the freeing in the rcu callback.
   dentries do this.

2. If not performance critical, you could use a workqueue to
   do the actual freeing including put_namespace(). Just wake up
   from the rcu callback.

These may or may not be applicable to your case. More details will
help.

Thanks
Dipankar
