Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWEKQnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWEKQnI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 12:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWEKQnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 12:43:08 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:54984 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1030339AbWEKQnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 12:43:06 -0400
Date: Thu, 11 May 2006 17:43:00 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 07/35] Make LOAD_OFFSET defined by subarch
Message-ID: <20060511164300.GA7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085150.509458000@sous-sol.org> <44627733.4010305@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44627733.4010305@vmware.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 04:28:51PM -0700, Zachary Amsden wrote:
> Chris Wright wrote:
> >Change LOAD_OFFSET so that the kernel has virtual addresses in the elf 
> >header fields.
> >
> >Unlike bare metal kernels, Xen kernels start with virtual address
> >management turned on and thus the addresses to load to should be
> >virtual addresses.
> 
> This patch interferes with using a traditional bootloader.  The loader 
> for Xen should be smarter - it already has VIRT_BASE from the xen_guest 
> section, and can simply add the relocation to these header fields.  This 
> is unnecessary, and one of the many reasons a Xen kernel can't run in a 
> normal environment.

It's certainly not as simple as you make it sound, if you want to
support existing kernels without having to guess how the kernel image
was built.

I've updated our loader to support this now, so that this patch is
no longer necessary.  I have at the same time added a new field to
xen_guest which allows specifying the entry point, allowing us to have
a different entry point when running the kernel image on Xen.

    christian

