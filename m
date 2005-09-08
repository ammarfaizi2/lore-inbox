Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbVIHNwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbVIHNwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 09:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbVIHNwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 09:52:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32902 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751355AbVIHNwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 09:52:18 -0400
Date: Thu, 8 Sep 2005 14:52:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] synclink.c compiler optimiation fix
Message-ID: <20050908135211.GB8676@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Fulghum <paulkf@microgate.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1126112543.3984.17.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126112543.3984.17.camel@deimos.microgate.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 12:02:23PM -0500, Paul Fulghum wrote:
> -	u16 count;	/* buffer size/data count */
> -	u16 status;	/* Control/status field */
> -	u16 rcc;	/* character count field */
> +	volatile u16 count;	/* buffer size/data count */
> +	volatile u16 status;	/* Control/status field */
> +	volatile u16 rcc;	/* character count field */

this is wrong.  The structure is in ioremaped memory so you must
use reads/writes to access them instead.  volatile usage in drivers
is never okay - if you are accessing I/O memory you need to use
proper acessors, if it is normal memory and you want atomic sematics
you need to use the atomic_t type and the operators defined on it.

