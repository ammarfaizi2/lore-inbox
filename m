Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263327AbTIWIQT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 04:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263331AbTIWIQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 04:16:19 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:51729 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263327AbTIWIQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 04:16:19 -0400
Date: Tue, 23 Sep 2003 09:16:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
Message-ID: <20030923091617.B10818@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	sensors@stimpy.netroedge.com
References: <10642734271572@kroah.com> <1064273428551@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1064273428551@kroah.com>; from greg@kroah.com on Mon, Sep 22, 2003 at 04:30:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 04:30:28PM -0700, Greg KH wrote:
>  	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
> -		/* XXX: WTF is going on here??? */
> -		if ((is_isa && check_region(addr, 1)) ||
> +		void *region_used = request_region(addr, 1, "foo");
> +		release_region(addr, 1);
> +		if ((is_isa && (region_used == NULL)) ||

WTF??  Your papering over bugs again, this doesn't help at all.

