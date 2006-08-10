Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161233AbWHJMub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161233AbWHJMub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161235AbWHJMub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:50:31 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:6089 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161233AbWHJMua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:50:30 -0400
Date: Thu, 10 Aug 2006 21:49:50 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: apw@shadowen.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Re : sparsemem usage
Message-Id: <20060810214950.71ddbd46.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060810124052.79249.qmail@web25805.mail.ukl.yahoo.com>
References: <20060810134616.31268991.kamezawa.hiroyu@jp.fujitsu.com>
	<20060810124052.79249.qmail@web25805.mail.ukl.yahoo.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006 14:40:52 +0200 (CEST)
moreau francis <francis_moreau2000@yahoo.fr> wrote: 
> > BTW, ioresouce information (see kernel/resouce.c)
> > 
> > [kamezawa@aworks Development]$ cat /proc/iomem | grep RAM
> > 00000000-0009fbff : System RAM
> > 000a0000-000bffff : Video RAM area
> > 00100000-2dfeffff : System RAM
> > 
> > is not enough ?
> > 
> 
> well actually you show that to get a really simple information, ie does
> a page exist ?, we need to parse some kernel data structures like 
> ioresource (which is, IMHO, hackish) or duplicate in each architecture
> some data to keep track of existing pages.
> 

becasue memory map from e820(x86) or efi(ia64) are registered to iomem_resource,
we should avoid duplicates that information. kdump and memory hotplug uses
this information. (memory hotplug updates this iomem_resource.)

Implementing "page_is_exist" function based on ioresouce is one of generic
and rubust way to go, I think.
(if performance of list walking is problem, enhancing ioresouce code is
 better.)
 
-Kame

