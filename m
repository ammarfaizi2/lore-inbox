Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbVL2LCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbVL2LCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbVL2LCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:02:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37038 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932583AbVL2LCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:02:11 -0500
Subject: Re: Redefinition error while compiling LKM
From: Arjan van de Ven <arjan@infradead.org>
To: "pretorious ." <pretorious_i@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY23-F21B799C42BAB6D34C0D762F7290@phx.gbl>
References: <BAY23-F21B799C42BAB6D34C0D762F7290@phx.gbl>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 12:02:09 +0100
Message-Id: <1135854129.2935.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 16:21 +0530, pretorious . wrote:
> hi!
>    I am facing problem in compiling an LKM. It seems Inclusion of 
> <sys/stat.h> conflicts with definitions in time.h.
> 
> 
> My linux kernal version is 2.4.21-4.EL
> 
> 
> #include <linux/kernel.h>
> #include <linux/module.h>
> 
> #if CONFIG_MODVERSIONS==1
> #define MODVERSIONS
> #include <linux/modversions.h>
> #endif

this is broken btw
> 
> #ifndef KERNEL_VERSION
> #define KERNEL_VERSION(a,b,c) ((a)*65536+(b)*256+(c))
> #endif
> 
> #include <linux/slab.h>
> #include <asm/uaccess.h>
> #include <sys/syscall.h>
> 
> #include <sys/stat.h>


you cannot use glibc headers in kernel modules. anything in sys/ is a
glibc header.

and.. why on earth would you need sys/syscall.h ?? (or sys/stat.h for
that matter)


