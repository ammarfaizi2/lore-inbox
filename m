Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWHXNDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWHXNDf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWHXNDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:03:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3762 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751317AbWHXNDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:03:34 -0400
Subject: RE: Serial custom speed deprecated?
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stuart MacDonald <stuartm@connecttech.com>,
       "'LKML'" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
In-Reply-To: <1156425568.3007.138.camel@localhost.localdomain>
References: <033001c6c77a$a7d8ab10$294b82ce@stuartm>
	 <1156425568.3007.138.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 14:03:30 +0100
Message-Id: <1156424610.3012.29.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 14:19 +0100, Alan Cox wrote:
> Actually to do this right we have to make a decision or two
> 
> The POSIX way of handling this requires the speeds are in the termios
> structure "somewhere". We can't easily implement cfgetispeed/cfgetospeed
> unless we grow the termios structure in the kernel and issue 3 new
> ioctls (keeping the others as trivial translations) and then bumping
> glibc and the kernel to do the right thing.
> 
> The alternative is that we provide an extra pair of speed ioctls and
> glibc does the magic to hide this lot while providing a termios with the
> new fields itself.
> 
> Whichever way we go glibc already has the fields present and the
> libc<->application API appears to be unchanged by this.
> 
> I'd rather we went the way of extending our termios to include c_ispeed,
> c_ospeed values. The code isn't hard for the remapping of the old ones
> and it avoids extra ioctls and the corner case races between two speed
> sets that occur if they are two ioctls.

Agreed. Some architectures have c_[io]speed in their struct termios
already, in fact, but others would need new ioctls for it.

-- 
dwmw2

