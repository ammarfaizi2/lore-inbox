Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTFBH5f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 03:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTFBH5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 03:57:34 -0400
Received: from m239.net195-132-57.noos.fr ([195.132.57.239]:33928 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S261292AbTFBH5d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 03:57:33 -0400
Date: Mon, 2 Jun 2003 10:10:45 +0200
From: Stelian Pop <stelian@popies.net>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: OUPS 2.5.69-bk19 sonypi irq 11: nobody cared!
Message-ID: <20030602081045.GC12831@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
	lkml <linux-kernel@vger.kernel.org>
References: <1053971418.2003.13.camel@nalesnik.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053971418.2003.13.camel@nalesnik.localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 06:50:36PM +0100, Grzegorz Jaskiewicz wrote:

> irq 11: nobody cared!
> 
> Call Trace:
[...]
>  [<c790c8d0>] sonypi_irq+0x0/0x2a0 [sonypi]
>  [<c790fd00>] +0x0/0x200 [sonypi]
>  [<c030206f>] pci_find_device+0x2f/0x40
>  [<c790fd00>] +0x0/0x200 [sonypi]
>  [<c78fe030>] +0x30/0x3b [sonypi]
>  [<c013509f>] sys_init_module+0xff/0x210
>  [<c790fd00>] +0x0/0x200 [sonypi]
>  [<c010b21b>] syscall_call+0x7/0xb

I have been away for a while, moving to a new house etc...

Anyway, the sonypi messages appear because of the new irq infrastructure
Linus introduced a few weeks ago. Using this infrastructure a driver can
tell if he really handled the irq or not.

The problem with the sonypi driver is that it only knows about a 
limited set of events (button presses, battery events, lid events etc),
and any event not referenced in the sonypi source will give you the
backtrace you saw.

I intend to force the sonypi driver to return IRQ_HANDLED every time
he receives an event (because it does anyway print a warning message
when it happens), but this code has not reached Linus yet.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
