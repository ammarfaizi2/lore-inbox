Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWDEPkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWDEPkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 11:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWDEPkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 11:40:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32920 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751099AbWDEPkA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 11:40:00 -0400
Date: Wed, 5 Apr 2006 16:39:57 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [patch 03/26] sysfs: zero terminate sysfs write buffers (CVE-2006-1055)
Message-ID: <20060405153957.GI27946@ftp.linux.org.uk>
References: <20060404235634.696852000@quad.kroah.org> <20060404235947.GD27049@kroah.com> <20060405190928.17b9ba6a.vsu@altlinux.ru> <20060405152123.GH27946@ftp.linux.org.uk> <9e4733910604050838g339d48cao4e0f8582f6d90187@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910604050838g339d48cao4e0f8582f6d90187@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 11:38:06AM -0400, Jon Smirl wrote:
> On 4/5/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> > On Wed, Apr 05, 2006 at 07:09:28PM +0400, Sergey Vlasov wrote:
> > > This will break the "color_map" sysfs file for framebuffers -
> > > drivers/video/fbsysfs.c:store_cmap() expects to get exactly 4096 bytes
> > > for a colormap with 256 entries.  In fact, the original patch which
> > > changed PAGE_SIZE - 1 to PAGE_SIZE:
> >
> > ... cheerfully assuming that nobody assumes NUL-termination and
> > everyone (sysfs patch writers!) certainly uses the length argument.
> > Fscking brilliant, that.
> >
> > Are you willing to audit all sysfs ->show() in the kernel?  Original
> > author of that turd had not been.
> >
> > FWIW, "color_map" is a blatant abuse of interface.  Doesn't get
> > any more borderline...
> 
> The firmware interface is worse. You write the ROM image line by line
> to the attribute and a hidden counter tracks how far your are into the
> image.
> 
> There needs to be a standardized way to transfer larger pieces of data
> via sysfs or we should go back to IOCTLs.

How about _NOT_ using sysfs and just having ->read()/->write() on a file in fs
of your own?  ~20 lines for all of it, not counting #include...
