Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVCPEZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVCPEZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 23:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVCPEZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 23:25:37 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:59290 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262510AbVCPEZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 23:25:17 -0500
Subject: Re: [PATCH] Replace zone padding with a definition in cache.h
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503152010190.5134@server.graphe.net>
References: <Pine.LNX.4.58.0503152010190.5134@server.graphe.net>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 15:24:59 +1100
Message-Id: <1110947099.24808.3.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 20:12 -0800, Christoph Lameter wrote:
> This patch removes the zone padding hack and establishes definitions
> in include/linux/cache.h to define the padding within struct zone.
> 
> Signed-off-by: Christoph Lameter <christoph@lameter.com>
> Signed-off-by: Shai Fultheim <Shai@Scalex86.org>
> 
> Index: linux-2.6.11/include/linux/cache.h
> ===================================================================
> --- linux-2.6.11.orig/include/linux/cache.h	2005-03-08 18:40:15.000000000 -0800
> +++ linux-2.6.11/include/linux/cache.h	2005-03-14 10:33:45.247701040 -0800
> @@ -48,4 +48,12 @@
>  #endif
>  #endif
> 
> +#ifndef ____cacheline_pad_in_smp
> +#if defined(CONFIG_SMP)
> +#define ____cacheline_pad_in_smp struct { char  x; } ____cacheline_maxaligned_in_smp
                                             ^^^^^^^

Doesn't this add a redundant cacheline if the padding is
previously perfect? Because of the extra byte you're adding?

IIRC, the char x[0]; trick does the job correctly.




