Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVACSas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVACSas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVACSaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:30:20 -0500
Received: from canuck.infradead.org ([205.233.218.70]:15630 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261668AbVACSYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:24:46 -0500
Subject: Re: pin files in memory after read
From: Arjan van de Ven <arjan@infradead.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050103180718.GA22138@suse.de>
References: <20050103180718.GA22138@suse.de>
Content-Type: text/plain
Date: Mon, 03 Jan 2005 19:24:40 +0100
Message-Id: <1104776680.4192.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 19:07 +0100, Olaf Hering wrote:
> Is there a way to always keep a file (once read from disk) in memory, no
> matter how much memory pressure exists?
> There are always complains that updatedb and similar tools wipe out all
> caches. So I guess there is no such thing yet.
> 
> I simply want to avoid the spinup of my ibook harddisk when something
> has been 'forgotten' and must be loaded again (like opening a new screen
> window after a while).
> 
> The best I could do so far was a cramfs image. I copied it to tmpfs
> during early boot, then mount -o bind every cramfs file over the real
> binary on disk. Of course that will fail as soon as I want to update an
> affected package because the binary is busy (readonly). So there must be
> a better way to achieve this.
> 
> How can one tell the kernel to pin a file in memory once it was read?
> Maybe with an xattr or something?
> Unfortunately I dont know about the block layer and other things
> involved, so I cant attach a patch that does what I want.

you could write a small userspace daemon that mmaps the file and mlock's
it....

