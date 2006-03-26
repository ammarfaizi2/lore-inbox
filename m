Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWCZHy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWCZHy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 02:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWCZHy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 02:54:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50627 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751160AbWCZHy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 02:54:28 -0500
Date: Sat, 25 Mar 2006 23:50:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smp_locks reference_discarded errors
Message-Id: <20060325235035.5fcb902f.akpm@osdl.org>
In-Reply-To: <20060325033948.GA15564@redhat.com>
References: <20060325033948.GA15564@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
> since the addition of smp alternatives, the following is occuring..
> 
> Error: ./drivers/md/md.o .smp_locks refers to 0000008c R_386_32          .exit.text
> Error: ./drivers/usb/storage/libusual.o .smp_locks refers to 00000008 R_386_32          .exit.text
> Error: ./net/802/psnap.o .smp_locks refers to 00000000 R_386_32          .exit.text
> Error: ./drivers/pci/hotplug/ibmphp_hpc.o .smp_locks refers to 00000008 R_386_32          .exit.text
> Error: ./drivers/pci/hotplug/ibmphp_hpc.o .smp_locks refers to 0000000c R_386_32          .exit.text
> 
> example .config at http://people.redhat.com/davej/kernel-2.6.16-i686-smp.config
> 

I guess an atomic operation in __exit code will cause that.  down() and
atomic_dec_and_test() in two cases.

I suspect most of these callsites are just wrongly coded - it's pretty
unusual for __exit code to really need to lock anything - what is there to
be racing against?

This is emitted by reference_discarded.pl?
