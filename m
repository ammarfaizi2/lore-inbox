Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTJXS77 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 14:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTJXS76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 14:59:58 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:64010 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262470AbTJXS74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 14:59:56 -0400
Date: Fri, 24 Oct 2003 20:59:53 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vid Strpic <vms@bofhlet.net>, linux-kernel@vger.kernel.org
Subject: Re: *FAT problem in 2.6.0-test8
Message-ID: <20031024185953.GA9265@win.tue.nl>
References: <20031024103225.GC1046@home.bofhlet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031024103225.GC1046@home.bofhlet.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 12:32:26PM +0200, Vid Strpic wrote:

> Yesterday, I just wanted to download some pics from a Smartmedia card
> from my camera.  I put the card into the reader (USB Mass Storage Flash
> Card Reader, Manufacturer: EZ, Serial Number: 9876543210ABCDEF, driver
> is usb-storage and working well now, I had problems earlier), but the
> kernel doesn't recognize FAT filesystem on the card...
> 
> Oct 23 17:19:01 moria kernel: FAT: invalid first entry of FAT (0xff8 != 0x0)
> 
> Luckily, I have a 2.4 machine around, I tried to mount the resulting
> disk image (NFS) on that machine (-o loop ofcourse), and it worked
> perfectly... kernel is 2.4.22.
> 
> Any ideas what's wrong?

Go to linux/fs/fat, edit inode.c, comment the bit

        if (FAT_FIRST_ENT(sb, media) != first
            && (media != 0xf8 || FAT_FIRST_ENT(sb, 0xfe) != first)) {
                if (!silent) {
                        printk(KERN_ERR "FAT: invalid first entry of FAT "
                               "(0x%x != 0x%x)\n",
                               FAT_FIRST_ENT(sb, media), first);
                }
                goto out_invalid;
        }

out by putting #if 0 ... #endif around it.

How was this card formatted?

