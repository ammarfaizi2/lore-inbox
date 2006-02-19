Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWBSRVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWBSRVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 12:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWBSRVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 12:21:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53160 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932164AbWBSRVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 12:21:24 -0500
Date: Sun, 19 Feb 2006 17:21:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Paul Mundt <lethal@linux-sh.org>, zanussi@us.ibm.com,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060219172120.GA9967@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Paul Mundt <lethal@linux-sh.org>, zanussi@us.ibm.com,
	Patrick Mochel <mochel@digitalimplant.org>,
	linux-kernel@vger.kernel.org
References: <20060219171748.GA13068@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219171748.GA13068@linux-sh.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 07:17:48PM +0200, Paul Mundt wrote:
> Now with relayfs integrated and the relay_file_operations exported for
> use by other file systems, I wonder what people think about adding in a
> sysfs attribute for setting up channel buffers.
> 
> The conventional relayfs doesn't make a lot of sense for the use cases
> where there are multiple devices to stream data from, particularly if
> they're already mapped out through the driver model. Rather than
> duplicating device enumeration, simply adding this as an attribute seems
> to work reasonably well.
> 
> Tom did some work on the rchan_callbacks for more easily implementing
> relay files in other file systems, and it would be nice to use this in a
> non-debug context, without duplicating device enumeration in multiple
> locations.

Hmm, this actually makes a lot of sense.  At this point we should probably
move the guts of relayfs into kernel/relay.c or something and add a different
config option for it.  Given this and debugs we could probably kill the
separate relayfs filesystem implementation.

