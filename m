Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269319AbUJEPut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269319AbUJEPut (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269999AbUJEPuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:50:32 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:42247 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269057AbUJEPsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:48:47 -0400
Date: Tue, 5 Oct 2004 16:48:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Message-ID: <20041005164842.A19754@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <200410042157.i94Lv7UC104750@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200410042157.i94Lv7UC104750@fsgi900.americas.sgi.com>; from pfg@sgi.com on Mon, Oct 04, 2004 at 04:57:06PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 04:57:06PM -0500, Pat Gefre wrote:
> 
> We have redone the I/O layer in the Altix code.
> 
> We've broken the patch set down to 2 patches. One to remove the files,
> the other to add in the new code. Most of the changes from the last
> posting are in response to review comments.

This looks pretty nice already, but a few small but important issues
need sorting out.

 - The interface between pci_dma.c and the lowlevel code is still wrong -
   and because of the additional 32bit direct translation in this code drop
   it got even worse because you might be calling into a function just to
   error out again.
   Please implement my suggestions from month ago, it's not a lot of work.
 - various sall baclls take bus_number and devfs but no pci domain, while
   the normal SAL calls do, I think you should make the kernel code aware
   of pci domains so the prom can introduce them seamlessly
 - is doing SAL calls from irq context really safe?  Also why do you need
   different SAL calls for shub vs ice error?  The prom should be easily
   able to find out what hub a given nasid corresponds to.
 - the patch reformats various unrelated or only slightly related files.
   Please don't do that - in general the new style is better than the old
   one, but it doesn't belong in this patchA
 - there's a SNDRV_SHUB_GET_IOCTL_VERSION ioctl define added but never
   used.  In fact it looks like all SNDRV_SHUB_ values are unused now?


