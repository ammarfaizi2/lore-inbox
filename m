Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265002AbUG1Wyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbUG1Wyt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266780AbUG1WxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:53:18 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:59319 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266749AbUG1WtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:49:18 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Date: Wed, 28 Jul 2004 15:44:24 -0700
User-Agent: KMail/1.6.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ebiederm@xmission.com,
       suparna@in.ibm.com, fastboot@osdl.org, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
References: <16734.1090513167@ocs3.ocs.com.au> <1091044742.31698.3.camel@localhost.localdomain> <20040728154230.11d658af.akpm@osdl.org>
In-Reply-To: <20040728154230.11d658af.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407281544.24901.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 28, 2004 3:42 pm, Andrew Morton wrote:
> But they're welcome to do that: the memory for the DMA transfer has
> already been allocated and our new universe will not be touching it.

Yeah, for the most part that should be ok.  We can be paranoid about 
misdirected DMA later...  (Some platforms will let you protect memory regions 
at the chipset level, so it seems like the new kernel should be so protected 
until it's actually jumped to by kexec, but prior to unprotecting it you'd 
want to make sure that a bad DMA from the broken kernel doesn't hose it.)

> What we need to do is to ensure that the new kexec-ed kernel appropriately
> whacks the devices to stop any in-progress operations.  So it's the probe()
> and open() routines which need to get the device into a sane state, not the
> shutdown routines.

That makes sense, and means that drivers may want to call a shutdown-like 
routine in their probe functions to make sure their device is in a known 
state before starting.  But all of this is very driver specific it seems.

Jesse
