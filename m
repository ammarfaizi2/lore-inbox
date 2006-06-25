Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWFYVVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWFYVVL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 17:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWFYVVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 17:21:11 -0400
Received: from xenotime.net ([66.160.160.81]:46781 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750747AbWFYVVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 17:21:10 -0400
Date: Sun, 25 Jun 2006 14:23:57 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: toralf.foerster@gmx.de, linux-kernel@vger.kernel.org, haveblue@us.ibm.com,
       y-goto@jp.fujitsu.com
Subject: Re: linux-2.6.17.1: undefined reference to `online_page'
Message-Id: <20060625142357.93036593.rdunlap@xenotime.net>
In-Reply-To: <200606251704_MC3-1-C36D-5D33@compuserve.com>
References: <200606251704_MC3-1-C36D-5D33@compuserve.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 17:01:22 -0400 Chuck Ebbert wrote:

> In-Reply-To: <200606231001.33766.toralf.foerster@gmx.de>
> 
> On Fri, 23 Jun 2006 10:01:33 +0200, Toralf Foerster wrote:
> 
> > I got the compile error :
> > 
> > ...
> >   UPD     include/linux/compile.h
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > mm/built-in.o: In function `online_pages':
> > : undefined reference to `online_page'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > with this config:
> 
> > CONFIG_X86_32=y
> 
> > CONFIG_NOHIGHMEM=y
> 
> > CONFIG_SPARSEMEM_MANUAL=y
> > CONFIG_SPARSEMEM=y
> > CONFIG_HAVE_MEMORY_PRESENT=y
> > CONFIG_SPARSEMEM_STATIC=y
> > CONFIG_MEMORY_HOTPLUG=y
> 
> Yes, that config is broken. mm/memory_hotplug.c::online_pages() calls
> online_page() but without HIGHMEM that doesn't get built and no dummy
> function gets defined.

Toralf, was this from a random config file?  (make randconfig)

It's certainly not just a 2.6.17.1 problem.  .1 didn't change this.

---
~Randy
