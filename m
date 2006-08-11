Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWHKSgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWHKSgJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 14:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWHKSgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 14:36:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32947 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932185AbWHKSgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 14:36:08 -0400
Date: Fri, 11 Aug 2006 11:36:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Haverkamp <markh@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2
Message-Id: <20060811113602.04867f46.akpm@osdl.org>
In-Reply-To: <1155319901.17493.9.camel@markh3.pdx.osdl.net>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<1155319901.17493.9.camel@markh3.pdx.osdl.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 11:11:40 -0700
Mark Haverkamp <markh@osdl.org> wrote:

> On Sun, 2006-08-06 at 03:08 -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
> 
> I am seeing problem loading modules at boot time.  My initrd tries to
> load scsi_mod and percpu_modalloc prints this;
> 
> Could not allocate 16 bytes percpu data
> 
> This is a 2 processor x86_64 machine.  I have attached the output from
> the serial console and the config file.
> 
> It is related to the mm patches.  I can boot OK from the main kernel
> tree and the scsi trees.

Yeah, sorry - this is almost certainly due to the increase in NR_IRQS.  It
made this, in include/linux/kernel_stat.h

	DECLARE_PER_CPU(struct kernel_stat, kstat);

really big and we consume all the per-cpu memory.


NR_IRQS is (sometimes) calculated from NR_CPUS via complex means.  Reducing
your NR_CPUS should fix things up.

