Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVAHMJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVAHMJP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 07:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVAHMJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 07:09:15 -0500
Received: from [213.146.154.40] ([213.146.154.40]:65230 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261858AbVAHMJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 07:09:02 -0500
Date: Sat, 8 Jan 2005 12:08:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
Message-ID: <20050108120858.GB27414@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <11051632633234@kroah.com> <11051632632994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11051632632994@kroah.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 09:47:43PM -0800, Greg KH wrote:
> ChangeSet 1.1938.444.33, 2004/12/22 13:50:21-08:00, davej@redhat.com
> 
> [PATCH] driver core: Fix up vesafb failure probing.
> 
> bus.c file invokes a probe callback for most devices in a list, then checks
> for -ENODEV return ("no such device"), if so it remains silent. However, some
> drivers (including vesafb.c) may return -ENXIO ("no such device or address"),
> which is indeed error -6.
> 
> I shut up the warning with the attached patch, that basically ignores
> both -ENODEV and -ENXIO.

NAK.  We shouldn't have two return codes indicating the same error (or
actually non-error in this case).  Let's fix the drivers instead.

