Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWHKTSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWHKTSN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWHKTSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:18:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33726 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932113AbWHKTSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:18:12 -0400
Date: Fri, 11 Aug 2006 12:18:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, cpufreq@www.linux.org.uk
Subject: Re: cpufreq stops working after a while
Message-Id: <20060811121806.51a73fe5.akpm@osdl.org>
In-Reply-To: <44DCD618.2040700@rtr.ca>
References: <44DCCB96.5080801@rtr.ca>
	<20060811114631.4a699667.akpm@osdl.org>
	<44DCD618.2040700@rtr.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2006 15:10:16 -0400
Mark Lord <lkml@rtr.ca> wrote:

> >> WHY?
> > 
> > cpufreq seems to have relatively frequent problems.
> > 
> >>  And how can I fix it?
> > 
> > You could start by telling us which kernel versions are affected ;)
> 
> 
> Mmm.. since it appears to be related, kbuild dumps this out when building the kernel:
> 
> WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data: from .text between 'acpi_processor_power_init' (at offset 0xf29) and 'acpi_processor_cst_has_changed'
> 
> A possible source for the bug, or total red herring ?

An RH.  acpi_processor_power_init() is actually non-buggy, due to its
interesting games with `first_run'.

A section error would usually trigger a wild oops if you're affected by it.
