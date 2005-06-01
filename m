Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVFAFnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVFAFnB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 01:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFAFnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 01:43:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48851 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261225AbVFAFm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 01:42:59 -0400
Date: Wed, 1 Jun 2005 06:42:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Introduce tty_unregister_ldisc()
Message-ID: <20050601054251.GA12275@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Fulghum <paulkf@microgate.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200505312356.00853.adobriyan@gmail.com> <1117578491.4627.14.camel@at2.pipehead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117578491.4627.14.camel@at2.pipehead.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 05:28:11PM -0500, Paul Fulghum wrote:
> This patch is wrong. Please do not apply.
> 
> An unmodified ldisc driver (externally maintained) will continue to call
> tty_register_ldisc with NULL, but the new behavior will be to set the
> ldisc pointer to NULL but have LDISC_FLAG_DEFINED set.
> 
> If you feel it is absolutely necessary to add this new function
> for cosmetic reasons, then leave the old behavior in place
> and make tty_unregister_ldisc a wrapper to tty_register_ldisc
> that uses a NULL pointer.

Nah, we don't want to allow staying out of tree folks out of sync.  Adding
a BUG_ON for ldisk beeing NULL is much more reasoable.

