Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423673AbWJZTAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423673AbWJZTAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 15:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161439AbWJZTAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 15:00:53 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:35293 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161438AbWJZTAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 15:00:52 -0400
Date: Thu, 26 Oct 2006 12:00:30 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>,
       paulus@samba.org, ak@suse.de, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] Create compat_sys_migrate_pages
In-Reply-To: <20061026133305.b0db54e6.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0610261158130.2802@schroedinger.engr.sgi.com>
References: <20061026132659.2ff90dd1.sfr@canb.auug.org.au>
 <20061026133305.b0db54e6.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2006, Stephen Rothwell wrote:

> This is needed on bigendian 64bit architectures. The obvious way to do
> this (taking the other compat_ routines in this file as examples) is to
> use compat_alloc_user_space and copy the bitmasks back there, however you
> cannot call compat_alloc_user_space twice for a single system call and
> this method saves two copies of the bitmasks.

Well this means also that sys_mbind and sys_set_mempolicy are also
broken because these functions also use get_nodes().

Fixing get_nodes() to do the proper thing would fix all of these 
without having to touch sys_migrate_pages or creating a compat_ function 
(which usually is placed in kernel/compat.c)
