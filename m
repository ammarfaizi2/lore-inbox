Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTJVGCo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 02:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTJVGCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 02:02:44 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:19982 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263434AbTJVGCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 02:02:43 -0400
Date: Wed, 22 Oct 2003 08:04:38 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Colin Ngam <cngam@sgi.com>
cc: linux-kernel@vger.kernel.org, <habeck@sgi.com>
Subject: Re: [patch] pci_dma_sync_to_device
In-Reply-To: <3F9535B6.B574818D@sgi.com>
Message-ID: <Pine.LNX.4.44.0310211708520.1339-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Oct 2003, Colin Ngam wrote:

> Are these dma sync routines for NON Cache Coherent systems or
> are they performance features that allows the flushing of dirty
> cache data out to Memory before a transfer?

Well, my understanding of the pci dma api it is designed to hide the 
details of the underlaying bus and related complications. The caller just 
uses the api and doesn't care whether the system is cache coherent or not.
Individual archs have to provide implementation which deal with issues.

The patch includes the i386 implementation which is trivial because the 
pci bus view is coherent wrt. host due to cache snooping. The only thing 
left to do is we need to be careful with OOSTORE and PPro errata. This is 
done using flush_write_buffers() from include/asm-i386/io.h

Martin


