Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129506AbRCBV1O>; Fri, 2 Mar 2001 16:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129509AbRCBV1E>; Fri, 2 Mar 2001 16:27:04 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:1183 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129506AbRCBV0t>;
	Fri, 2 Mar 2001 16:26:49 -0500
Date: Fri, 2 Mar 2001 16:26:24 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Roskin <proski@gnu.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
Subject: [FIX] Re: usbdevfs can be mounted multiple times
In-Reply-To: <Pine.LNX.4.33.0103021605570.22765-100000@fonzie.nine.com>
Message-ID: <Pine.GSO.4.21.0103021617500.15463-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Mar 2001, Pavel Roskin wrote:

> Hello!
> 
> I understand that root can do many strange and unsafe things, but mounting
> the same filesystem many times is not allowed for systems other than
> usbdevfs.

Mounting the same fs many times _is_ perfectly legitimate. However, I really
don't like the fact that you've been able to do it several times on the same
mountpoint...  Ah. I see - Linus, could you please do the following?

vi drivers/usb/inode.c '-c/DECLARE_FSTYPE/s/0/FS_SINGLE/
x'

I.e. replace the last argument in declaration of usbdevfs with FS_SINGLE -
without that we get a new instance every time.

								Cheers,
									Al

