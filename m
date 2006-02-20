Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWBTOR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWBTOR0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWBTORZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:17:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59305 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964932AbWBTORY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:17:24 -0500
Date: Mon, 20 Feb 2006 14:17:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Tom Zanussi <zanussi@us.ibm.com>, Paul Mundt <lethal@linux-sh.org>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, axboe@suse.de,
       karim@opersys.com
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060220141713.GA29479@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mathieu Desnoyers <compudj@krystal.dyndns.org>,
	Tom Zanussi <zanussi@us.ibm.com>, Paul Mundt <lethal@linux-sh.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	axboe@suse.de, karim@opersys.com
References: <20060219171748.GA13068@linux-sh.org> <20060219175623.GA2674@kroah.com> <20060219185254.GA13391@linux-sh.org> <17401.21427.568297.830492@tut.ibm.com> <20060220130555.GA29405@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220130555.GA29405@Krystal>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 08:05:56AM -0500, Mathieu Desnoyers wrote:
> * LTTng does have its own ltt_poll and ltt_ioctl that are all what is needed to
>   control the interaction with the file (along with the relayfs mmap/unmap).
> 
> In this scenario, the sysfs relay attribute creation would look like :
> 
> - create an empty attr
> - fill some of attr members
> - sysfs_create_relay_file(kobj, attr);
>   (it will overwrite some attr members : kobj, rchan, rchan_buf)
>   * set specific LTTng file operations on the inode

defintily not on sysfs.  sysfs doesn't allow drivers to modify the
file operations for good reasons.  it'll probably work the same as-is
when you use the rely file operations on debugfs or a custom filesystem,
although you're code will have zero chance to get merged when it modifies
an existing file operations struct or adds an ioctl.

