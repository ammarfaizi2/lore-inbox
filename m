Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbWJMTDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWJMTDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWJMTDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:03:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53678 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751815AbWJMTDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:03:32 -0400
Date: Fri, 13 Oct 2006 12:03:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Don Mullis <dwm@meer.net>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [patch 7/7] stacktrace filtering for fault-injection
 capabilities
Message-Id: <20061013120321.148ee494.akpm@osdl.org>
In-Reply-To: <20061013180039.GD29079@localhost>
References: <20061012074305.047696736@gmail.com>
	<452df23e.44ca1e09.1a7f.780f@mx.google.com>
	<20061012142004.a111ca6a.akpm@osdl.org>
	<20061013180039.GD29079@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2006 03:00:39 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> On Thu, Oct 12, 2006 at 02:20:04PM -0700, Andrew Morton wrote:
> 
> > I read the documentation but I still don't understand this feature.  What
> > does the stacktrace actually do?  It gets stored somewhere and displayed
> > later?  What's it all for?
> 
> For example someone may want to inject kmalloc()/kmem_cache_alloc()
> failures into only e100 module. they want to inject not only direct
> kmalloc() call, but also indirect allocation, too.
> 
> - e100_poll --> netif_receive_skb --> packet_rcv_spkt --> skb_clone
>   --> kmem_cache_alloc
> 
> This patch enables to detect function calls like this by stacktrace
> and inject failures. The script
> Documentaion/fault-injection/failmodule.sh
> helps it.
> 
> The range of text section of loaded e100 is expected to be
> [/sys/module/e100/sections/.text, /sys/module/e100/sections/.exit.text)
> 
> So failmodule.sh stores these values into /debug/failslab/address-start
> and /debug/failslab/address-end.

Oh I see.  So you walk up the stack and if any caller falls between those
two addresses, we enable the fault-injector.   Fair enough.

