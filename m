Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTJRWB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 18:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTJRWB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 18:01:26 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:64773 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S261871AbTJRWBZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 18:01:25 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] initrd with devfs enabled (Re: initrd and 2.6.0-test8)
Date: Sat, 18 Oct 2003 23:56:04 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <3F916A0C.10800@comcast.net> <1066501993.4208.6.camel@chtephan.cs.pocnet.net> <20031018194148.GE7665@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20031018194148.GE7665@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310182356.04346.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 of October 2003 21:41, viro@parcelfarce.linux.theplanet.co.uk 
wrote:
> 	OK, that should do it - the problems happened if you had devfs
> enabled; in that case late-boot code does temporary mount of devfs over
> rootfs /dev, which made /dev/initrd inaccessible.  For setups without
> devfs that didn't happen.
>
> 	Fix is trivial - put the file in question outside of /dev; IOW,
> we simply replace "/dev/initrd" with "/initrd.image" in init/*.  It works
> here; please check if it fixes all initrd problems on your boxen.
Works fine for me.

btw. is it possible to do not use initrd with some fs and instead use external 
initramfs image?

I've tried to create initramfs image with unpacking initrd image, mounting it 
over loop and creating cpio archive from that (find . | cpio -o -c > 
../x.cpio), gzipping that cpio and placeing it instead of old initrd at 
/boot/initrd + lilo reload. 

It doesn't work that way unfortunately (test8 with your patch).
-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

