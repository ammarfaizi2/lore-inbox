Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbUKQSvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbUKQSvi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUKQSFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:05:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64931 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262426AbUKQR6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:58:16 -0500
Date: Wed, 17 Nov 2004 17:58:11 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, jelle@foks.8m.com,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] cx88: fix printk arg. type
Message-ID: <20041117175811.GE26051@parcelfarce.linux.theplanet.co.uk>
References: <419A89A3.90903@osdl.org> <20041117172519.GB8176@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117172519.GB8176@bytesex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 06:25:19PM +0100, Gerd Knorr wrote:
> > -		dprintk(0, "ERROR: Firmware size mismatch (have %ld, expected %d)\n",
> > +		dprintk(0, "ERROR: Firmware size mismatch (have %Zd, expected %d)\n",
> 
> Thanks, merged to cvs.  I like that 'Z'.  Or is that just a linux-kernel
> printk specific thingy?  Or is this standardized somewhere?  So I could
> use that in userspace code as well maybe?

'Z' is an obsolete equivalent of standard 'z'.  That one is portable and it
is, indeed, available in userland (libc6 and anything C99-compliant).  To
quote the manpage:

       z      A  following  integer  conversion  corresponds  to  a  size_t or
              ssize_t argument. (Linux libc5 has Z with  this  meaning.  Don't
              use it.)

       t      A  following integer conversion corresponds to a ptrdiff_t argu-
              ment.

Please, do s/Zd/zd/.

One more thing: folks, please stop using crap like "%08x", (int)pointer.
It's not only non-portable (consider 64bit boxen), it's extra work for
no good reason.  "%p" is standard and will do the right thing with less
PITA.
