Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUCUU3L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 15:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUCUU1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 15:27:14 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:61700 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261238AbUCUU07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 15:26:59 -0500
Date: Sun, 21 Mar 2004 20:26:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Andi Kleen <ak@suse.de>,
       Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: [PATCH] fix tiocgdev 32/64bit emul
Message-ID: <20040321202655.A11330@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	viro@parcelfarce.linux.theplanet.co.uk, Andi Kleen <ak@suse.de>,
	Miquel van Smoorenburg <miquels@cistron.nl>
References: <405DC698.4040802@pobox.com> <20040321165752.A9028@infradead.org> <405DE3EF.8090508@gmx.net> <20040321185538.A10504@infradead.org> <405DF3C6.8050508@gmx.net> <20040321200211.A11109@infradead.org> <405DF83C.2040703@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <405DF83C.2040703@gmx.net>; from c-d.hailfinger.kernel.2004@gmx.net on Sun, Mar 21, 2004 at 09:17:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 09:17:00PM +0100, Carl-Daniel Hailfinger wrote:
> > No, I'll leave that to Greg.  If you want my 2 (Euro-) Cent I'd rather avoid
> > exposing a dev_t to userspace wherever possible.
> 
> Understood. Especially since the recent upsizing of dev_t broke
> applications trying to be too clever about dev_t. However, look at this:
> 
> # cat /sys/class/tty/console/dev
> 5:1
> 
> Does this major:minor textfile export address your concerns?

No.  I'd really love to avoid having any userspace (escept makedev/udev)
to use dev_t as anything but a cookie, i.e. trying to make sense from it.

Having a special raw, non-redirected console device as in Al's patch is
*much* cleaner.
