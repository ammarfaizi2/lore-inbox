Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVERPlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVERPlN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVERPhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:37:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43495 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262251AbVERPgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:36:54 -0400
Date: Wed, 18 May 2005 16:36:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Carsten Otte <cotte@freenet.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 2/5] mm/fs: execute in place (V2)
Message-ID: <20050518153650.GA25322@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Carsten Otte <cotte@freenet.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com,
	akpm@osdl.org
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com> <1116424413.2202.17.camel@cotte.boeblingen.de.ibm.com> <20050518142707.GA23162@infradead.org> <428B57AA.2030006@freenet.de> <20050518150053.GA24389@infradead.org> <428B5FC1.3090704@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428B5FC1.3090704@freenet.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 05:31:13PM +0200, Carsten Otte wrote:
> - generic_file_read           => xip_file_read

no need to have that one if you implement aio_read -> use do_sync_read

> - generic_file_aio_read    => xip_file_aio_read
> - __generic_file_aio_read => __xip_file_aio_read

readv and aio_read are just wrappers around this one.

> - generic_file_sendfile     => xip_file_sendfile

pretty trivial

> - generic file_readv          => xip_file_readv
> - generic_file_write          => xip_file_write

just use do_sync_write

> - generic_file_aio_write_nolock => xip_file_write_nolock
> - __generic_file_write_nolock => __xip_file_write_nolock
> - generic_file_write_nolock => xip_file_write_nolock
> - generic_file_aio_write => xip_file_aio_write

you don't need all these.  Just writev and aio_write as wrappers around a common one

> - generic_file_mmap => xip_file_mmap

this one doesn't share code anyway

> - generic_file_readonly_mmap => xip_file_readonly_mmap

unless you want to implement a readonly filesystem with xip support you
don't need this one.

