Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWJPJnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWJPJnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 05:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWJPJnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 05:43:52 -0400
Received: from ozlabs.org ([203.10.76.45]:27575 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030328AbWJPJnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 05:43:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17715.3265.870339.317367@cargo.ozlabs.ibm.com>
Date: Mon, 16 Oct 2006 14:38:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: Srinivasa Ds <srinivasa@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] 2.6.19-rc1: Fix build breakage with CONFIG_PPC32
In-Reply-To: <452F6838.6090605@in.ibm.com>
References: <452F6838.6090605@in.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivasa Ds writes:

> arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
> (.text+0x96d4): undefined reference to `low_cpu_die'
> ======================================================
> low_cpu_die() is defined under  CONFIG_PM || CONFIG_CPU_FREQ_PMAC  
> options ,but while calling this function ,no care has been to taken to 
> check these options. So please apply this fix,which solves the problem.

Nack.  The correct fix is to adjust the ifdefs in sleep.S to make
low_cpu_die available.  Otherwise it won't be possible to off-line
CPUs properly.

Paul.
