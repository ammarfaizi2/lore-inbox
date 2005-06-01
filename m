Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVFASqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVFASqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVFASoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:44:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57054 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261536AbVFASLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:11:39 -0400
Date: Wed, 1 Jun 2005 19:11:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 5/11] s390: #ifdefs in compat_ioctls.
Message-ID: <20050601181137.GA24268@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20050601180312.GE6418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601180312.GE6418@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 08:03:12PM +0200, Martin Schwidefsky wrote:
> [patch 5/11] s390: #ifdefs in compat_ioctls.
> 
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Remove superflous #if .. #endif pairs from compat_ioctl.c.

Actually is there any chance you could just provide ->compat_ioctl handlers
in the drivers?  All these ioctls are specific to drivers, and it sounds like
a rather bad idea to pollute the global has table with them.  This is also
a good chance to switch the drivers to drop BKL usage in the ioctl path and
use the same handler for ->unlocked_ioctl and ->compat_ioctl.

