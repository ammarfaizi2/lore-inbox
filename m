Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbTDKQda (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 12:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbTDKQd3 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 12:33:29 -0400
Received: from havoc.daloft.com ([64.213.145.173]:53962 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261206AbTDKQdX (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 12:33:23 -0400
Date: Fri, 11 Apr 2003 12:45:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Sriram Narasimhan <nsri@tataelxsi.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tasklet doubt!
Message-ID: <20030411164501.GA2721@gtf.org>
References: <3E96EAF5.4060609@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E96EAF5.4060609@tataelxsi.co.in>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 09:49:01PM +0530, Sriram Narasimhan wrote:
> Hello,
> 
> How much of memory can be allocated from a tasklet ? [ kmalloc 
> (GFP_ATOMIC) ].
> 
> I was able to allocate upto 2.5 MB. But I would like to allocate upto 
> 8MB. Is this possible?

You don't want to do that :)  You're starving other GFP_ATOMIC
processes, and will increase system failures due to lack of memory...
even though there may be plenty outside the emergency pools.

One option is to create a background kernel thread (via schedule_task or
schedule_work, depending on your kernel version) that allocates memory
which your tasklet then takes.

	Jeff



