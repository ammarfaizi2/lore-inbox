Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWHHT6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWHHT6I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWHHT6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:58:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47489 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030245AbWHHT6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:58:07 -0400
Date: Tue, 8 Aug 2006 12:58:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Magnus Damm <magnus@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: mark two more functions as __init
Message-Id: <20060808125803.9aac260f.akpm@osdl.org>
In-Reply-To: <20060808081756.334.46571.sendpatchset@cherry.local>
References: <20060808081756.334.46571.sendpatchset@cherry.local>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  8 Aug 2006 17:17:00 +0900 (JST)
Magnus Damm <magnus@valinux.co.jp> wrote:

> i386: mark two more functions as __init
> 
> cyrix_identify() should be __init because transmeta_identify() is.
> tsc_init() is only called from setup_arch() which is marked as __init.
> 
> These two section mismatches have been detected using running modpost on
> a vmlinux image compiled with CONFIG_RELOCATABLE=y.
> 
> -static void cyrix_identify(struct cpuinfo_x86 * c)
> +static void __init cyrix_identify(struct cpuinfo_x86 * c)

Are we sure?  We end up putting a pointer to this into
arch/i386/kernel/cpu/common.c:cpu_devs[], and that gets used from __cpuinit
code.  

