Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267575AbUHTGD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267575AbUHTGD7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 02:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267579AbUHTGD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 02:03:59 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:45575 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267575AbUHTGD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 02:03:58 -0400
Date: Fri, 20 Aug 2004 07:03:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Peter Osterlund <petero2@telia.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-ID: <20040820070355.A16988@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Peter Osterlund <petero2@telia.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040816143710.1cd0bd2c.akpm@osdl.org> <20040816224749.A15510@infradead.org> <m3r7q4huei.fsf@telia.com> <20040819104534.B7641@infradead.org> <m3n00qics0.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3n00qics0.fsf@telia.com>; from petero2@telia.com on Fri, Aug 20, 2004 at 07:44:47AM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 07:44:47AM +0200, Peter Osterlund wrote:
> The release/ioctl functions should be no problems to convert, but how
> do I prevent pkt_open() and pkt_remove_dev() from racing against each
> other with your suggestion? Currently this is handled by the ctl_mutex
> and the fact that pkt_find_dev_from_minor() returns NULL if the packet
> device has gone away.

If you call del_gendisk early enough the blocklayer will synchrnoize
them for you.  It looks like you'll have to move del_gendisk a little up
for that, though.
