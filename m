Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269818AbUJGMnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269818AbUJGMnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 08:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269633AbUJGMbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 08:31:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16869 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269812AbUJGMSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 08:18:10 -0400
Date: Thu, 7 Oct 2004 14:17:41 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Probable module bug in linux-2.6.5-1.358
Message-ID: <20041007121741.GB23612@devserv.devel.redhat.com>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com> <1097143144.2789.19.camel@laptop.fenrus.com> <Pine.LNX.4.61.0410070753060.9988@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410070753060.9988@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 08:01:47AM -0400, Richard B. Johnson wrote:
> Also, when this driver is running, transferring large volumes
> of data, the kernel decides that there have been too many interrupts, and 
> does:
> 
> Message from syslogd@chaos at Wed Oct  6 21:22:57 2004 ...
> chaos kernel: Disabling IRQ #18
> 
> This, in spite of the fact that interrupts occur only when
> DMA completion happens and new data are available, i.e.,
> one interrupt every 16 megabytes of data transferred.
> 
> Who decided that it had a right to disable my interrupt????

the kernel did because you don't return the proper value for "I handled the
IRQ" from your ISR.

Also I don't see where you call cleanup_module(), the function that does the
deregistration of the chardev... where do you call that ????
