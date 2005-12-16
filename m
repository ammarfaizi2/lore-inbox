Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVLPOfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVLPOfn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVLPOfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:35:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7080 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932312AbVLPOfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:35:42 -0500
Date: Fri, 16 Dec 2005 14:35:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org, wein@de.ibm.com,
       Horst.Hummel@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/3] s390: dasd extended error reporting module.
Message-ID: <20051216143540.GA25097@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	wein@de.ibm.com, Horst.Hummel@de.ibm.com,
	linux-kernel@vger.kernel.org
References: <20051216132953.GD8877@skybase.boeblingen.de.ibm.com> <20051216134754.GA23964@infradead.org> <1134743589.5495.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134743589.5495.16.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 03:33:09PM +0100, Martin Schwidefsky wrote:
> On a side not, Arnd just told my about the bug in the dasd_eckd
> discipline. We need to check the discipline in the eckd specific ioctls.
> I'll tell the appropriate people (well in fact I already did because
> they are on CC:). As for adding a per discipline .ioctl function, that
> won't work because of cmb and eer. These modules do not implement a
> discipline but still have to add ioctls.

cmd shouldn't be a module of it's own (see patch just sent), and the
same is true of this module.  Functionality that doesn't have it's own
fundamental objects to operate on should be separate modules.  If you
use modules ala dlopen()ed .so libraries in userspace you will always
get code that's a piece of junk and full of bugs.
