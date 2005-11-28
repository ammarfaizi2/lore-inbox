Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVK1QQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVK1QQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 11:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVK1QQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 11:16:07 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:36786 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751248AbVK1QQG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 11:16:06 -0500
Date: Mon, 28 Nov 2005 21:47:47 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow lockless traversal of notifier lists
Message-ID: <20051128161747.GA4359@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20051128133757.GQ20775@brahms.suse.de> <20051128160129.GA8478@in.ibm.com> <20051128160547.GA20775@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128160547.GA20775@brahms.suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 05:05:47PM +0100, Andi Kleen wrote:
>   *
>   *	Returns zero on success, or %-ENOENT on failure.
>   */
> @@ -175,6 +181,7 @@
>  

There should be an smp_read_barrier_depends() here for the first
dereferencing of the notifier block head, I think.

>  	while(nb)
>  	{
> +		smp_read_barrier_depends();
>  		ret=nb->notifier_call(nb,val,v);
>  		if(ret&NOTIFY_STOP_MASK)
>  		{

Thanks
Dipankar
