Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTE0Dmc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 23:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTE0Dmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 23:42:32 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:20864 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263126AbTE0Dmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 23:42:31 -0400
Date: Mon, 26 May 2003 20:55:48 -0700
From: Andrew Morton <akpm@digeo.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xirc2ps_cs irq return fix
Message-Id: <20030526205548.4853c92b.akpm@digeo.com>
In-Reply-To: <3ED2E03E.80004@pobox.com>
References: <200305252318.h4PNIPX4026812@hera.kernel.org>
	<3ED16351.7060904@pobox.com>
	<Pine.LNX.4.50.0305252051570.28320-100000@montezuma.mastecende.com>
	<1053992128.17129.15.camel@dhcp22.swansea.linux.org.uk>
	<3ED2E03E.80004@pobox.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2003 03:55:44.0724 (UTC) FILETIME=[D9645940:01C32403]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> If the fix is correct, we need to do a bombing run that adds the 
>  following code to each driver,
> 
>  	if (!netif_device_present(dev))
>  		return IRQ_HANDLED;

no...  What we need to do is to kill the printk in handle_IRQ_event().

It should only be turned on for special situations, where someone is trying
to hunt down a reproducible lockup.  These are situations in which the odd
false positive just doesn't matter.  And we know that there will always
be false positives due to apic delivery latency (at least).

I think the time is right to do this.  Add CONFIG_DEBUG_IRQ and get on with
fixing real stuff.



