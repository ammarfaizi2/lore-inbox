Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVHBAl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVHBAl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 20:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVHBAl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 20:41:57 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:23749 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261233AbVHBAl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 20:41:57 -0400
Subject: Re: pci cacheline size / latency oddness.
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <20050801233517.GA23172@redhat.com>
References: <20050801233517.GA23172@redhat.com>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 20:41:49 -0400
Message-Id: <1122943309.26405.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 19:35 -0400, Dave Jones wrote:
> This means we will do the wrong thing on AMD machines which have
> 64 byte cachelines.

pcibios_init (in i386/pci/common.c, which is linked in by X86_64 PCI
code) seems to do this 
 
if (c->x86 >= 6 && c->x86_vendor == X86_VENDOR_AMD)
                pci_cache_line_size = 64 >> 2;  /* K7 & K8 */

Is it correct to expect all AMD k7/8 machines to have 16 as cache line
size - I thought 64 was more appropriate?

On my Athlon64 laptop, all PCI devices end up having 0 latency. 

> x86-64 doesn't have an arch override for pci_cache_line_size

I am trying to fix it up - What's the right way to override it in x86_64
code?  Just initialize it to 64 may be?

Parag


