Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266883AbUAXHak (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 02:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266882AbUAXHai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 02:30:38 -0500
Received: from colo.lackof.org ([198.49.126.79]:9947 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S266881AbUAXHae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 02:30:34 -0500
Date: Sat, 24 Jan 2004 00:30:32 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@redhat.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] 2.6.1 tg3 DMA engine test failure
Message-ID: <20040124073032.GA7265@colo.lackof.org>
References: <20040124013614.GB1310@colo.lackof.org> <20040123.210023.74723544.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123.210023.74723544.davem@redhat.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 09:00:23PM -0800, David S. Miller wrote:
>    From: Grant Grundler <grundler@parisc-linux.org>
>    Date: Fri, 23 Jan 2004 18:36:14 -0700
> 
>    3) Broadcom engineer noted the meaning of DMA_RWCTRL_ASSERT_ALL_BE
>       has changed for bcm570[34] and also advised against setting
>       it on BCM570[01] chips. I'm just implementing his advice.
>       Comment below spells out more details.
> 
> Setting this bit is absolutely required on many RISC PCI boxes, where
> streaming mappings must have cacheline sized DMA transactions done
> on them with all byte enables on.

My gut feeling is if linux aligns or pads things nicely for any reason,
then the bye enables don't get used or clobber padding.

> In fact, since the later chips don't allow controlling this, some of
> them cause streaming byte hole errors on sparc64 and other RISC
> systems when they do cacheline sized DMA to streaming DMA mappings
> with not all the byte enables on.

yup.

> So I'm not going to add this part of your changes.

No problem. My take is, if it hasn't caused a problem on x86 because
things are well aligned, then no reason to change the code.
Knowing the issues about other RISC archs 

Maybe keep a shorter note about the bit changed meaning in later models
just to document the issues.

thanks,
grant
