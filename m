Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265514AbUAPODI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265527AbUAPODI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:03:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64570 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265514AbUAPODF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:03:05 -0500
To: aeriksson@fastmail.fm
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-tiny1 tree for small systems
References: <20040115141411.97F9C3F60@latitude.mynet.no-ip.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Jan 2004 06:56:48 -0700
In-Reply-To: <20040115141411.97F9C3F60@latitude.mynet.no-ip.org>
Message-ID: <m1vfnc9eu7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aeriksson@fastmail.fm writes:

> Hi Matt,
> Using the attached .config, I get this build error:

Good catch.  I can't account for it all.  But half of it is that
/proc does not compile out it's block device reporting when CONFIG_BLOCK
is disabled.  Which accounts for:

> fs/built-in.o(.text+0x18946): In function `partitions_open':
> : undefined reference to `partitions_op'
> fs/built-in.o(.text+0x18957): In function `diskstats_open':
> : undefined reference to `diskstats_op'
> fs/built-in.o(.text+0x18c19): In function `devices_read_proc':
> : undefined reference to `get_blkdev_list'

Which still leaves:

> arch/i386/mm/built-in.o(.init.text+0x2e6): In function `mem_init':
> : undefined reference to `ppro_with_ram_bug'
> drivers/built-in.o(__ksymtab+0x130): undefined reference to 
> `pci_pci_problems'


Eric
