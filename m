Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWFYVHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWFYVHM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 17:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWFYVHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 17:07:12 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:5344 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750713AbWFYVHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 17:07:10 -0400
Date: Sun, 25 Jun 2006 17:01:22 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: linux-2.6.17.1: undefined reference to `online_page'
To: Toralf Foerster <toralf.foerster@gmx.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Hansen <haveblue@us.ibm.com>,
       Yasunori Goto <y-goto@jp.fujitsu.com>
Message-ID: <200606251704_MC3-1-C36D-5D33@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200606231001.33766.toralf.foerster@gmx.de>

On Fri, 23 Jun 2006 10:01:33 +0200, Toralf Foerster wrote:

> I got the compile error :
> 
> ...
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> mm/built-in.o: In function `online_pages':
> : undefined reference to `online_page'
> make: *** [.tmp_vmlinux1] Error 1
> 
> with this config:

> CONFIG_X86_32=y

> CONFIG_NOHIGHMEM=y

> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_HAVE_MEMORY_PRESENT=y
> CONFIG_SPARSEMEM_STATIC=y
> CONFIG_MEMORY_HOTPLUG=y

Yes, that config is broken. mm/memory_hotplug.c::online_pages() calls
online_page() but without HIGHMEM that doesn't get built and no dummy
function gets defined.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
