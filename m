Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVLHTFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVLHTFc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVLHTFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:05:32 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:24803 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932252AbVLHTFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:05:31 -0500
Date: Thu, 8 Dec 2005 11:05:24 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: pcibus_to_node value when no pxm info is present for the pci
 bus
In-Reply-To: <20051207223414.GA4493@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0512081104280.29958@schroedinger.engr.sgi.com>
References: <20051207223414.GA4493@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Ravikiran G Thirumalai wrote:

> Most of the arches seem to return -1 for pcibus_to_node if there is no pxm
> kind of proximity information for the pci busses.  Arch specific code on
> those arches check if nodeid >= 0  before using the nodeid for kmalloc_node
> etc. But some code paths in x86_64/i386 does not doe this --
> x86_64/dma_alloc_pages() and e1000 node local descriptor (I am to blame for 
> the second one).  Also, pcibus_to_node seems to be 0 when there is no pxm 
> info available.

kmalloc_node falls back to kmalloc for node == -1. So there does not need 
to be a check.
 
> The question is, what should be the default pcibus_to_node if there is no
> pxm info? Answer seems like -1 -- in which case dma_alloc_pages and e1000
> driver has to be fixed.

Why would they have to be fixed?

