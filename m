Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbWCULap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbWCULap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWCULap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:30:45 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:6115 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030315AbWCULao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:30:44 -0500
Date: Tue, 21 Mar 2006 13:30:38 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: optimize constant-size kzalloc calls
In-Reply-To: <20060321032101.3a4014fe.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0603211327540.23993@sbz-30.cs.Helsinki.FI>
References: <1142868958.11159.0.camel@localhost> <20060321032101.3a4014fe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> > Please note that the patch
> >  increases kernel text slightly (~200 bytes for defconfig on x86)

On Tue, 21 Mar 2006, Andrew Morton wrote:
> Why?

Because of the malloc_sizes lookup. As kindly explained by Eric, we're 
now doing:

	kzalloc(100, GFP_KERNEL);

and with the patch, we will do:

	kmem_cache_zalloc(malloc_sizes[4].cs_dmacachep, GFP_KERNEL);

which explains the the difference. The end result should be faster 
kzalloc(), though.

				Pekka
