Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUEXHyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUEXHyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUEXHyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:54:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:4513 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261685AbUEXHyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:54:09 -0400
Date: Mon, 24 May 2004 00:53:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: wli@holomorphy.com, jakob@unthought.net, linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
Message-Id: <20040524005331.71465614.akpm@osdl.org>
In-Reply-To: <20040524063959.5107.qmail@web90007.mail.scd.yahoo.com>
References: <20040524062754.GO1833@holomorphy.com>
	<20040524063959.5107.qmail@web90007.mail.scd.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phy Prabab <phyprabab@yahoo.com> wrote:
>
> Okay, here is the output:
> 
>  317955 total                                     
>  0.1302
>  263633 poll_idle                               
>  4545.3966
>    6764 do_page_fault                             
>  5.1951
>    3650 kmap_atomic 

It's strange that you appear to be using poll_idle().  Maybe it's an error
in the profiler - it sometimes makes mistakes in identifying small
functions.

But if you _are_ using poll_idle() and if your CPU is hyperthreaded then
yes, one "CPU" is going to take a performance hit from the "idle" one.

Is your CPU hyperthreaded?  (cat /proc/cpuinfo)

Are you booting with "idle=poll"?  Do `dmesg -s 1000000 | grep idle'.

